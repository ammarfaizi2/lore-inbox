Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRAaDAd>; Tue, 30 Jan 2001 22:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRAaDAX>; Tue, 30 Jan 2001 22:00:23 -0500
Received: from [64.160.188.242] ([64.160.188.242]:23557 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129393AbRAaDAP>; Tue, 30 Jan 2001 22:00:15 -0500
Date: Tue, 30 Jan 2001 18:59:38 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: linux-kernel@vger.kernel.org
Subject: VIA VT82C686X
Message-ID: <Pine.LNX.4.21.0101301847530.3488-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Woohoo! Just found out that ATA66 on the VIA aint too great.

I set the kernel boot options idebus=66 ide0=ata66 enabling ATA66
according to dmesg. The HDD is a WDC UDMA100 30.5GB drive. I retried the

dd if=/dev/hda7 of=/tmp/testing2.img bs=1024k count=2000 

on one VT, ran renice -20 on the dd process then ran procinfo on another
and top on a 3rd. I logged into a fourth and ran sync;sync;sync;sync;sync.

After @30 seconds the machine became totally unresponsive, locking up all
but the current VT.

I let it sit there and waited until the dd finished in case the renice was
what killed the control. When dd finished I tried running any type of
command but the tty was completely frozen. All other VTs were non
responsive as well.


This is gonna be fun when I test the Promise controller. hehe


David D.W. Downey


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
