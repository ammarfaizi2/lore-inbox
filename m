Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUADWHg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUADWHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:07:36 -0500
Received: from 213-0-143-57.dialup.nuria.telefonica-data.net ([213.0.143.57]:22912
	"HELO phantom.matrix.com") by vger.kernel.org with SMTP
	id S265101AbUADWGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:06:46 -0500
From: yoros@wanadoo.es
Date: Sun, 4 Jan 2004 23:03:51 +0100
To: linux-kernel@vger.kernel.org
Subject: Hangs when accesing IDE devices with SATA and PIIX support.
Message-ID: <20040104220351.GA705@phantom.matrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have an Intel 848P mainboard with a SATA HD, a DVD and a CDRW. My
processor is a Pentium 4 2.6Ghz with HyperThreading and I have a linux
kernel 2.6.0 compiled with gcc-3.3 and with support for all of those
devices (SMP, SCSI_SATA, BLK_DEV_PIIX, etc...). I have the DVD in
Primary Slave and the CDRW in SecondaryMaster (I'll put a HD in Primary
Master as soon as I can).

I'm having problems with the access to my DVD and my CDRW devices.
Sometimes the system hangs with a simple "modprobe ide-cd", other times
it hangs using "hdparm -I /dev/cdrw", other times in the middle of an
access, etc...

The SATA hard disk works very well and with high results in "hdparm -t".

Without SATA support and configuring the HD in Legacy Mode (in the BIOS)
the DVD uint worked right (I don't know if CDRW worked because the
legacy mode makes me loose "ide1" for using SATA drives in it...

I noticed that in "dmesg" there is a difference between the two
configurations...

Without SCSI_ATA_PIIX (SCSI_SATA):

ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hdb: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ST3160023AS, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15


With SATA:

ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: 100% native mode on irq 18
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
hdb: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
ide0 at 0xc000-0xc007,0xbc02 on irq 18
hdc: HL-DT-ST GCE-8525B, ATAPI CD/DVD-ROM drive
ide1 at 0xb800-0xb807,0xb402 on irq 18



I don't know the difference but with the first it works and with the
second it does not work.

Please ask me for any extra information and, please again, answer me to
my e-mail address because I'm not in the list.

Thank you all.

Regards,

    Pedro

-- 
Pedro Martínez Juliá
\  yoros@terra.es
)|    yoros@wanadoo.es
/        http://yoros.dyndns.org
Socio HispaLinux #311
Usuario Linux #275438 - http://counter.li.org
GnuPG public information:  pub  1024D/74F1D3AC
Key fingerprint = 8431 7B47 D2B4 5A46 5F8E  534F 588B E285 74F1 D3AC
