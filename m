Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbUAJPJD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAJPJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:09:02 -0500
Received: from [81.3.4.101] ([81.3.4.101]:33481 "HELO localhost")
	by vger.kernel.org with SMTP id S265208AbUAJPIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:08:54 -0500
From: "Christian Kivalo" <valo@valo.at>
To: "Alex" <alex@meerkatsoft.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cannot boot after new Kernel Build
Date: Sat, 10 Jan 2004 16:08:52 +0100
Message-ID: <NMEHJKFGFEGJPIPOLFFECEBBDEAA.valo@valo.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3FFFB60C.9010309@meerkatsoft.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I am trying to build a new kernel but what ever version 2.4.24, 2.6.0,
> 2.6.1 i am trying to build I come across the same problem.
>
> when doing a "make install" i get the following error.
>
> /dev/mapper/control: open failed: No such file or directlry
> Is device-mapper driver missing from kernel?
> Comman failed.
>
> I have installed the lates packages
> device mapper 1.00.07
> initscripts 7.28.1
> modutils, lvm2.2.00.08
> mkinitrd-3.5.15.1-2
>
> If I just ignore the message and try to boot the machine with the new
> kernel then I get a Kernel Panic.
>
> VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unapble to mount root fs on unknown-block(0,0).
>
> The boot command in grub is
> root (hd0,0)
> kernel /vmlinuz-2.6.1 ro root=LABEL=/ hdc=ide-scsi
> initrd /initrd-2.6.1.img
>
> It is basically the same (except the version) as I use for
> 2.4.20-28 so
> I assume the label is correct.
>
> I saw quite a few messages of similar type but no real answer to the
> problem. Any Ideas what it could be ?  I am using RH9.0

hi!

as mentioned in this thread
(http://marc.theaimsgroup.com/?l=linux-kernel&m=107330398724534&w=2) a
few days ago, christophe saout wrote: "LABEL= is a RedHat extension.
Please use the normal root options that is described in the Grub or
kernel documentation."
rik van riel mentioned: "It's not even a Red Hat extension.  The LABEL=
stuff is done entirely in userspace, on the initrd.

If you do not want to use an initrd, you need to use the normal root
options instead, something like root=/dev/hda3" that thread also offers
some information to the problem."

have you created an initrd? if not, comment that line out of your grub
config.

you can leave your fstab like it is, using labels in fstab is ok.

hth
christian

> Thanks
> Alex

