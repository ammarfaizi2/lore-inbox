Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUGLOGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUGLOGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266840AbUGLOGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:06:33 -0400
Received: from stargate.fh-reutlingen.de ([134.103.32.26]:49029 "EHLO
	stargate.fh-reutlingen.de") by vger.kernel.org with ESMTP
	id S266839AbUGLOGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:06:17 -0400
Date: Mon, 12 Jul 2004 16:06:18 +0200 (CEST)
From: Michael Thalmann <mth@herakles.ath.cx>
X-X-Sender: mth@stargate.fh-reutlingen.de
To: linux-kernel@vger.kernel.org
Subject: Unable to mount DVD-RAM Media read/write on GSA-4040B with Kernel
 2.4.27-rc3
Message-ID: <Pine.LNX.4.44.0407121534570.827-100000@stargate.fh-reutlingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


I tried the prepatch 2.4.27-rc3 from www.kernel.org. After installing the
Kernel I was unable to write to my DVD-RAM Drive, LG GSA-4040B.

On 2.4.26 i was able to mount /dev/hda (the DVD-RAM Drive) with read/write
support enabled. mke2fs /dev/hda works without any problems.

With 2.4.27-rc3 I can mount the Disc read-only.
I can't create any filesystem nor write to a Disc which I prepared  on
2.4.26.

cat /proc/sys/dev/cdrom/info on 2.4.26 shows

CD-ROM information, Id: cdrom.c 3.12 2000/10/18

drive name:             hda
drive speed:            16
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         1
Can write CD-RW:        1
Can read DVD:           1
Can write DVD-R:        1
Can write DVD-RAM:      1


cat /proc/sys/dev/cdrom/info on 2.4.27-rc3 shows:

CD-ROM information, Id: cdrom.c 3.12 2000/10/18

drive name:             hda
drive speed:            16
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         1
Can write CD-RW:        1
Can read DVD:           1
Can write DVD-R:        1
Can write DVD-RAM:      1
Can write RAM:          1


The only diffrence is the addidional line on 2.4.27-rc3:
Can write RAM:          1

I used the same config-file for 2.4.26 and 2.4.27-rc3


dmesg|grep hda on 2.4.26:

drive name:             hda
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
hda: HL-DT-ST DVDRAM GSA-4040B, ATAPI CD/DVD-ROM drive
hda: attached ide-cdrom driver.
hda: ATAPI 16X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)

dmesg|grep hda on 2.4.27-rc3:
drive name:             hda
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
hda: HL-DT-ST DVDRAM GSA-4040B, ATAPI CD/DVD-ROM drive
hda: attached ide-cdrom driver.
hda: ATAPI 16X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)



Thank you very much for your help!

Best regards,
Michael Thalmann


