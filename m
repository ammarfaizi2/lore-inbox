Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbUJWXHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUJWXHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUJWXHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:07:35 -0400
Received: from zamok.crans.org ([138.231.136.6]:32968 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261336AbUJWXGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:06:06 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-mm1: LVM stopped working
From: Mathieu Segaud <matt@minas-morgul.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
Date: Sun, 24 Oct 2004 01:06:07 +0200
Message-ID: <87oeitdogw.fsf@barad-dur.crans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I gave a try to last -mm tree. The bot seemed good till it got to
LVM stuff. Vgchange does not find any volume groups. I can't say much because
lvm is pretty "early stuff" on this box; so it is pretty unusable. All I know
for now, as I changed a little my boot scripts to be more verbose, is that
vgchange -avvv y returns this kind of message: 
hdXN: cannot read LABEL
and this message for all parts it can test....
As I need this box up and running, I came back to 2.6.9-rc3-mm3 (it works
pretty well). I will be able to run more tests on it, tomorrow but for now
that's all I can provide.

Oh and dmesg didn't have any oops or BUG in it, and seemed quite usual,
in IDE detection and settings messages and device-mapper messages.

However, I use dm-crypt to encrypt my / (no initrd, just initramfs) and
it works under 2.6.9-mm1, so the bug is likely to be in IDE stuff.

Sorry, for not being able to provide more infos. I will see if I can try on
another LVM'ed box but not for critical stuff.

Mathieu

-- 
Lots of luck ... please pass your crack pipe arounds so the rest of us
idiots can see your vision or lack of ... 

	- Andre Hedrick on linux-kernel

