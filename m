Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275827AbRI1EHe>; Fri, 28 Sep 2001 00:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275829AbRI1EHZ>; Fri, 28 Sep 2001 00:07:25 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:19471 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S275827AbRI1EHN>; Fri, 28 Sep 2001 00:07:13 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org, gadio@netvision.net.il
Subject: ide-scsi driver trouble in ac15
Date: Fri, 28 Sep 2001 00:07:37 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010928040722Z275827-760+17888@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not entirely sure if this is ac15's fault or the preempt patch acting up. 
But this is very ide-scsi centric so i'm leaning towards ac15.  I burned a cd 
using my ide writer and it worked fine.  Then i went to burn another and the 
drive went into an infinite reset loop.  like this.
	SCSI bus is being reset for host 0 channel 0.
	scsi0 : channel 0 target 0 lun 0 request sense failed, performing reset.

reloading the modules does nothing but report this error. 
	SCSI subsystem driver Revision: 1.00
	scsi0 : SCSI host adapter emulation for IDE ATAPI devices
	scsi0 : channel 0 target 0 lun 0 request sense failed, performing reset.
	SCSI bus is being reset for host 0 channel 0.

Even though the modules were removed, the drive led is still blinking like it 
was writing.  If anyone needs some more info i'll try and get it. 
the cdr did detect and work correctly at boot. 

hardware:
    Promise ide controller : 
	PDC20262: chipset revision 1
	PDC20262: not 100% native mode: will probe irqs later
	PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    CDR: 
	hde: CREATIVE CD-RW RW8438E, ATAPI CD/DVD-ROM drive
	SCSI subsystem driver Revision: 1.00
	scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  	Vendor: CREATIVE  Model:  CD-RW RW8438E    Rev: FC03
  	Type:   CD-ROM                             ANSI SCSI revision: 02
software:
    Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
    linux-2.4.9-ac15-preempt-fix
     
