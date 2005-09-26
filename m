Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbVIZRcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbVIZRcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbVIZRcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:32:13 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:44744 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751694AbVIZRcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:32:12 -0400
To: Izo <I@siol.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help needed: kernel boot waits for Synaptics TouchPAD for whole minute
References: <4336F78D.9020308@siol.net>
From: Peter Osterlund <petero2@telia.com>
Date: 26 Sep 2005 19:32:06 +0200
In-Reply-To: <4336F78D.9020308@siol.net>
Message-ID: <m3ek7b3fc9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Izo <I@siol.net> writes:

> kernel: 2.6.13 (CPU=P4)
> GRUB kernel line: kernel (hd0,4)/boot/bzImage-2.6.13 root=/dev/hda5
> vga=0x317 selinux=0 splash=silent resume=/dev/hda2 desktop elevator=as
> showopts
> 
> On my Gericom Blockbuster notebook kernel waits at boot for whole minute
> for Synaptics TouchPad (while SuSE-9.3 packaged kernel (2.6.11) boots
> fine). After this minute the kernel boot continues and it works OK
> afterwards.
> 
> ......
> ACPI wakeup devices:
> PCI0 PS2M PS2K  EC0  LID USB1 USB2 USB3 USB4 S139  LAN  MDM  AUD SLPB
> ACPI: (supports S0 S3 S4 S5)
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> input: AT Translated Set 2 keyboard on isa0060/serio0
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
> might be trying access hardware directly.
> Synaptics Touchpad, model: 1, fw: 4.1, id: 0x848a1, caps: 0x0/0x0
> input: SynPS/2 Synaptics TouchPad on isa0060/serio2
> 
> after minute or so kernel boot continues:
> 
> ReiserFS: hda5: found reiserfs format "3.6" with standard journal
> ReiserFS: hda5: using ordered data mode
> ReiserFS: hda5: journal params: device hda5, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hda5: checking transaction log (hda5)
> ReiserFS: hda5: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Trying to move old root to /initrd ... /initrd does not exist. Ignored.
> Unmounting old root
> Trying to free ramdisk memory ... okay
> ....
> and smoothly on
> 
> 
> I've been googling for some helpful info and found nothing.
> 
> Can somebody tell me what to do to et rid of this delay at boot ?

My guess is that the delay is in the reiserfs code, not in the
synaptics code. Googling for "reiserfs boot delay" gives some
interesting looking links, but I didn't find an answer to your
question after a quick look.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
