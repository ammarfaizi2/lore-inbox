Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSLFV3n>; Fri, 6 Dec 2002 16:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbSLFV3n>; Fri, 6 Dec 2002 16:29:43 -0500
Received: from snow.ball.teaser.net ([213.91.6.13]:10761 "EHLO
	snow.ball.reliam.net") by vger.kernel.org with ESMTP
	id <S262472AbSLFV3l>; Fri, 6 Dec 2002 16:29:41 -0500
Date: Fri, 6 Dec 2002 22:34:44 +0100
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <17730135168.20021206223444@uni.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.50] odd SCSI messages on shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

on shutdown the following lines are displayed, but _not_ logged to
/var/log/messages:

Going to halt the system ...
Synchronizing SCSI caches: sda FAILED
  status = 1, message = 00, host = 0, driver = 08
  Current sd?: sense = 70  5
ASC=20 ASCQ= 0
Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0e 0x00 0x00 0x00
0x00 0x20 0x00 0x00 0xc0 0x00 0x00 0x00 0x00 0x00
Power off.


Information about my SCSIs:

/var/log/messages:
==================
Dec  6 21:00:24 brood kernel: SCSI subsystem driver Revision: 1.00
Dec  6 21:00:24 brood kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
Dec  6 21:00:24 brood kernel:         <Adaptec 2940 SCSI adapter>
Dec  6 21:00:24 brood kernel:         aic7870: Single Channel A, SCSI Id=0, 16/253 SCBs
Dec  6 21:00:24 brood kernel: 
Dec  6 21:00:24 brood kernel: (scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
Dec  6 21:00:24 brood kernel:   Vendor: SEAGATE   Model: ST52160N          Rev: 0285
Dec  6 21:00:24 brood kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec  6 21:00:24 brood kernel: SCSI device sda: drive cache: write back
Dec  6 21:00:24 brood kernel: SCSI device sda: 4238282 512-byte hdwr sectors (2170 MB)
Dec  6 21:00:24 brood kernel:  /dev/scsi/host0/bus0/target1/lun0: p1 p2
Dec  6 21:00:24 brood kernel: Attached scsi disk sda at scsi0, channel 0, id 1, lun 0

/proc/scsi/scsi:
================
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST52160N         Rev: 0285
  Type:   Direct-Access                    ANSI SCSI revision: 02

/proc/scsi/aic7xxx/0:
=====================
Adaptec AIC7xxx driver version: 6.2.4
aic7870: Single Channel A, SCSI Id=0, 16/253 SCBs
Channel A Target 0 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 1 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)
        Goal: 10.000MB/s transfers (10.000MHz, offset 15)
        Curr: 10.000MB/s transfers (10.000MHz, offset 15)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 155
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 3 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 4 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 5 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 6 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)
Channel A Target 7 Negotiation Settings
        User: 10.000MB/s transfers (10.000MHz, offset 255)

/proc/iomem:
============
...
e4000000-e4000fff : Adaptec AHA-2940/2940W / AIC
  e4000000-e4000fff : aic7xxx
...

/proc/ioports:
==============
...
6000-60ff : Adaptec AHA-2940/2940W / AIC
  6000-60ff : aic7xxx
...

any hints?
-- 
cheers,
 Tobias

