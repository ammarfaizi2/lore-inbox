Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTEVWPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTEVWPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:15:17 -0400
Received: from jma24.plus.com ([212.159.46.210]:10176 "EHLO lion")
	by vger.kernel.org with ESMTP id S263339AbTEVWPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:15:14 -0400
From: "John Appleby" <john@dnsworld.co.uk>
To: "'linux kernel'" <linux-kernel@vger.kernel.org>
Subject: Root device problems on arm26
Date: Thu, 22 May 2003 23:32:55 +0100
Message-ID: <434747C01D5AC443809D5FC5405011315690@bobcat.unickz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <434747C01D5AC443809D5FC54050113104ABC4@bobcat.unickz.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm busy hacking into the arm26 port (Archimedes, A5k) in 2.5.69 and
I've hit a brick wall. I have fixed support for initrd, fdd and hdd on
the A5k (amongst other things), but I can't get any of them to boot into
a root fs.

If I try booting into root=/dev/hda1 (which contains a valid FS that I
can boot with a 2.0.31 kernel), I get the following:

{snip}
Floppy drive(s): fd0 is 1.44M, fd1 is 1.44M
FDC 0 is an 8272A
RAMDISK driver initializer; 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system buss speed for PIO modes; override with
idebus=xx
hda: Conner Peripherals 120MB - CP30104H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 11
hda: task_no_data-intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data-intr: status=0x54 { DriveStatusError }
 hda: hda1 hda2
Console: switching to colour frame buffer device 80x60
i2c /dev entries driver module version 2.7.0 (200221208)
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

If I try booting into initrd (no arguments), I get same with the
following at the end:

VFS: Insert root floppy disk to be loaded into RAM disk and press ENTER
VFS: Insert root floppy and press ENTER
Kernel panic: VFS: Unable to mount root fs on fd0

A point to note is that the machine then can't read its disks in RISC-OS
until it has been switched off. Hard reset does nothing. Also, the hda:
hda1 hda2 line doesn't contain a partition type label (it's DOS), which
strikes me as odd. I do have DOS partition support compiled in.
Overriding with idebus=25 makes no difference by the way.

I really don't have a clue where this problem could be caused... does
anyone have any pointers for me?

Regards,

John


