Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135730AbRDSWHs>; Thu, 19 Apr 2001 18:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135732AbRDSWHi>; Thu, 19 Apr 2001 18:07:38 -0400
Received: from email.cwcom.net ([195.44.0.150]:2055 "EHLO cwcom.net")
	by vger.kernel.org with ESMTP id <S135730AbRDSWH0>;
	Thu, 19 Apr 2001 18:07:26 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
Subject: aha1542 fails in 2.4.4-pre4
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <7b0.3adf600b.aeeec@trespassersw.daria.co.uk>
Date: Thu, 19 Apr 2001 22:00:43 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just rebuilt an old box (Celeron 400) with an aha1542 and SCSI
CD-ROM. Get the following:

(aha1542 as module)
 
Apr 19 21:22:04 kanga kernel: Configuring Adaptec (SCSI-ID 7) at IO:330, IRQ 10, DMA priority 6 
Apr 19 21:22:04 kanga kernel: scsi0 : Adaptec 1542 
Apr 19 21:22:04 kanga kernel:   Vendor: SONY      Model: CD-ROM CDU-8003A  Rev: 1.9a 
Apr 19 21:22:04 kanga kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02 
Apr 19 21:22:04 kanga kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0 
Apr 19 21:22:06 kanga kernel: sr0: scsi-1 drive 
Apr 19 21:22:06 kanga kernel: Uniform CD-ROM driver Revision: 3.12 
Apr 19 21:22:20 kanga kernel: sr: ran out of mem for scatter pad 
Apr 19 21:22:20 kanga kernel:  I/O error: dev 0b:00, sector 376 
Apr 19 21:22:20 kanga kernel: isofs_read_super: bread failed, dev=0b:00, iso_blknum=94, block=188 
Apr 19 21:23:41 kanga kernel: sr: ran out of mem for scatter pad 
Apr 19 21:23:41 kanga kernel:  I/O error: dev 0b:00, sector 64 

(aha1542 in kernel)
Apr 19 22:37:49 kanga automount[247]: attempting to mount entry /mnt/cdrom
Apr 19 22:37:50 kanga kernel: sr: ran out of mem for scatter pad
Apr 19 22:37:50 kanga kernel: Kernel panic: scsi_free:Bad offset

Works fine in 2.2.19.

