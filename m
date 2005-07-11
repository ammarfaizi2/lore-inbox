Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVGKQcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVGKQcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVGKQXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:23:16 -0400
Received: from main.gmane.org ([80.91.229.2]:13801 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262141AbVGKQWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:22:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jose Barroca <jose.barroca@netcabo.pt>
Subject: segmentation fault in TOP command
Date: Mon, 11 Jul 2005 17:21:00 +0100
Message-ID: <dau69d$vit$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.22.178.18
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm trying to deal with a peculiar problem that came up the other day.
I've searched the net, posted in newbie groups, but to no avail. So,
perhaps you can lend a hand:

Using a 2.6.12.12 straight from kernel.org:
- I experience loss of responsiveness (mouse, keyboard, music) during
r/w intensive operations, such as lengthy computations in matlab
(exceeding my RAM), or a simple system update using Debian's dselect.
Mouse clicks and keypresses don't get lost, but xmms may skip the
tracks. And all this happens intermitently during the mentioned r-w op.
== This did not happen with previous kernels ==

- I had a case of FS corruption, which I could not trace. I use ext3,
only one partition for the complete debian system. I keep my data in
other partitions. Reason is a small disk in a laptop. This corruption
made itself visible after a reboot, when I called top to check why bash
was taking so long to complete a directory name (TAB press):

rdrs@abafado:~$ top
Segmentation fault

Other outputs included: "can't execute binary file", "attempt to access
beyond end of device"

I ran e2fsck -vc to get a read-only badblock scan, but the latter came
out clean. I had a lot of illegal inodes, though. This ext3 partition
was never accessed by other OSs.
== I use top on a dayly basis, so corruption happenned not long ago.
There were no power outages, but the previous kernel (2.6.11) had
NLS_DEFAULT=iso8859-1, whereas the new one has NLS_DEFAULT=utf8 ==

---
And, to sum up, I've been through a MEMTEST86, an E2FSCK, don't think
the machine was cracked (not even literally speaking), and ran SMARTCTL
-a /dev/hda.

This one had an interesting output: there was indication of an error
happening some 197 days ago. I could decipher the remaining info. Also,
the REALLOACTED_SECTOR_CT has a very high number, though it is labelled
"PRE_FAIL".


I'm quite at a loss on what to do now - where should I start looking?
And even if I simply replace "top", is that even possible, or advisable?

Eagerly waiting for your answers,

Jose






