Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278187AbRJRXIm>; Thu, 18 Oct 2001 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278200AbRJRXIW>; Thu, 18 Oct 2001 19:08:22 -0400
Received: from femail44.sdc1.sfba.home.com ([24.254.60.38]:54783 "EHLO
	femail44.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278187AbRJRXIS>; Thu, 18 Oct 2001 19:08:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steve Snyder <swsnyder@home.com>
Reply-To: swsnyder@home.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SCSI-2 device "refuses WIDE negotiation".  Huh?
Date: Thu, 18 Oct 2001 18:08:43 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01101818084300.01082@mercury.snydernet.lan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below are the messages related to my SCSI devices that I see when booting 
kernel v2.4.12.  Note that last device, scsi1:A:5:0.  The last 3 of the 5 
devices listed (CD-ROM, tape drive, DVD-RAM) are all on a single SCSI-2 
chain, so by definition they are accessed as 8-bit devices.  

So why does scsi1:A:5:0, the DVD-RAM, report this:

	refuses WIDE negotiation.  Using 8bit transfers

The only distinction I can see in these 3 Ultra SCSI devices is that the 
DVD-RAM is external where the CD-ROM and tape drive are internal.

Anyone know why this refusal is reported?  Thanks.

------------------------------

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/255 SCBs

(scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V__9_WLS    Rev: 0200
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:8): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V__9_WLS    Rev: 0200
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:0:6:0: Tagged Queuing enabled.  Depth 253
scsi0:0:8:0: Tagged Queuing enabled.  Depth 253
(scsi1:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.13
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: Seagate   Model: STT8000N          Rev: 3.54
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi1:A:5:0): refuses WIDE negotiation.  Using 8bit transfers
(scsi1:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: HITACHI   Model: DVD-RAM GF-2050   Rev: E006
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 8, lun 0
