Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUASLeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUASLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:32:22 -0500
Received: from mail36.messagelabs.com ([193.109.254.211]:37018 "HELO
	mail36.messagelabs.com") by vger.kernel.org with SMTP
	id S264575AbUASLb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:31:57 -0500
X-VirusChecked: Checked
X-Env-Sender: okiddle@yahoo.co.uk
X-Msg-Ref: server-17.tower-36.messagelabs.com!1074511912!3197532
X-StarScan-Version: 5.1.15; banners=-,-,-
X-VirusChecked: Checked
X-StarScan-Version: 5.1.13; banners=.,-,-
From: Oliver Kiddle <okiddle@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: page allocation failure
Date: Mon, 19 Jan 2004 12:36:02 +0100
Message-ID: <7641.1074512162@gmcs3.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a problem with 2.6.1 on my machine. It will be fine
for a matter of a few days and then this error will appear on the
console. The message then appears repeatedly and continuously. The
first I know is that my remote login shell ceases to respond. About the
only thing I can do is switch between virtual consoles (until I hit the
reset button).

/var/log/messages shows:
kernel: cat: page allocation failure. order:0, mode:0x20

Then the same for lots of other processes (pdflush, syslogd, klogd,
kswapd0, nfsd to name a few). I expect that after a point it is unable
to even log stuff so syslog is quiet after a while.

It has happened three times now and on all occasions, I was untarring a
huge file on an XFS partition. I assume the problem is something to do
with VM. The machine has 1GB of RAM which should be plenty. For the
most part it is just serving NFS and NIS (to no more than about 10
clients).

The hardware is a Dell PowerEdge 600SC. It's a new machine that never
ran 2.4 before. I can supply any other information that might help in
diagnosing the problem. I don't subscribe so please CC me in any reply
(but I'll keep an eye on the archives).

If anyone can suggest any /proc variables I might change to reduce the
risk of it doing this again, I would appreciate it. I tried increasing
/proc/sys/vm/min_free_kbytes after the first time this happened. Not
that I understand what that does: I searched the archives and it was
mentioned in a vaguely relevant looking post.

Cheers

Oliver Kiddle
