Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbTL3Og4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 09:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbTL3Og4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 09:36:56 -0500
Received: from pegasus.siol.net ([193.189.160.25]:32758 "EHLO pegasus.siol.net")
	by vger.kernel.org with ESMTP id S265799AbTL3Ogx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 09:36:53 -0500
Message-ID: <007401c3cee2$80edba60$0a03a8c0@brane>
From: "Branko" <brankob@avtomatika.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: LVM2 on Gentoo-Dual Opteron/Amd64 system troubles...
Date: Tue, 30 Dec 2003 15:37:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all,

 I have bothered support at Sistina with this, but received no answer yet
(being christmas time etc), so I thought of posting it here also...


I'm trying to use LVM on my new dual Opteron with 64-bit Gentoo and have
some (many) troubles.
My system is :

- dual Opteron 240 on TYAN Thunder S2885
-2 Gb RAM
-ATA RAID Controller 3Ware Escalade 7506-12 (12 IDE ports, hardware XOR,
supports multiple RAD fields and separate discs, does RAID 0/1/10/5)
- 4 x 180 Gb discs
- 6 x 200 Gb discs

4 CDRW units

gentoo kernel 2.6 with usual gentoo patches. Kernel has devfs, pts etc
compiled-in

Driver for 3ware is also compiled in kernel (not as a module) as are all
main scsi modules...

All CDRW units are connected to MB's primary and secondary channel.

All discs are on 3Ware card.

Five 200 GB units are in RAID5 array and four 180 Gb units and one 200 GB
are
free.

Machine sees 3Ware card as a SCSI controller with one big SCSI 800 Gb disc
and five smaller discs.

I have partitioned array in three partitions:
-small ext2 /boot partition (512 Mb or so)
-4 Gb swap partition
-the rest (cca 790 GB) is type 8E partition for LVM to be mounted as /

I have emerged LVM2 tools, made volume group etc and formatted it under
ext3.

I can activate it and mount it, but after reboot kernel doesn't see it
anymore...

Manual recommends using special script called lvmcreate_initdr to do initrd
initialisations, but my lvm2 doesn't have that script. After many trials and
errors  i have made initrd which succeeds with LVM initialisation, but
machine reboots just at the point when it should drop initrd environment and
jump into root  on LV.

In the initrd environment machine recognises VG and its LV just fine. I can
mount it and check it, but right after returning from linuxrc script machine
spews something like:

3w-xxxx driver: shutting off card (0)
3w-xxxx: reboot  (not sure about that one, it is shown just for a short
moment)


Otherwise, I can boot just fine from any other physical partition on one of
other discs on the 3Ware card
Lvm gets initialised (vgscan, vgchange -a y etc) and LV is available just
fine, but that's not what I want.

I guess I'm asking if:

-anyone else has similar machine with 3Ware RAID card and root on LV and how
did he accomplish this ?

-how does one make initrd with LVM ? I had to scavenge script from LVM1,
without much success...



Regards,


Branko

