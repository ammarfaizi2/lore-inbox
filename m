Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTDPKEY (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 06:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTDPKEY 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 06:04:24 -0400
Received: from mail.hometree.net ([212.34.181.120]:46273 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S264284AbTDPKEU 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 06:04:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: [2.4.21-pre7-ac1] IDE Warning when booting
Date: Wed, 16 Apr 2003 10:16:12 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b7jahc$8f0$1@tangens.hometree.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1050488172 8672 212.34.181.4 (16 Apr 2003 10:16:12 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 16 Apr 2003 10:16:12 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get these since many 2.4.21-pre<x>-ac<y> versions.

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM BIGFOOT_CY6480A, ATA DISK drive
blk: queue c02d2bc0, I/O limit 4095Mb (mask 0xffffffff)
hdc: IBM-DTLA-307060, ATA DISK drive
blk: queue c02d3018, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

hda: 12706470 sectors (6506 MB) w/67KiB Cache, CHS=790/255/63, DMA
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, (U)DMA
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
 hdc: [PTBL] [7943/240/63] hdc1 < hdc5 hdc6 >
ide-floppy driver 0.99.newide

The kernels itself are not too stable on my trustworthy old PPro 200
box (which runs rock solid with the RedHat 7.3 release kernels). Not
too stable means "crashes about every other night".

The is a PPro 200 with 256 MBytes RAM, Tyan Mainboard. Not
overclocked, well cooled, lightly loaded. It normally crashes when the
only really disk pushing operation (Backup via Amanda) is started at
night.

I sent some crash reports to Alan, I will post any with pre7-ac1
here. I got a serial console hooked up to that box and I intent to use
it. :-)

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
