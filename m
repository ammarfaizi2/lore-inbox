Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267809AbTAHOJ6>; Wed, 8 Jan 2003 09:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267815AbTAHOJ6>; Wed, 8 Jan 2003 09:09:58 -0500
Received: from gherkin.frus.com ([192.158.254.49]:27776 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267809AbTAHOJ5>;
	Wed, 8 Jan 2003 09:09:57 -0500
Subject: aic7xxx new driver (2.5.54 kernel) bug report
To: linux-kernel@vger.kernel.org
Date: Wed, 8 Jan 2003 08:18:38 -0600 (CST)
Cc: gibbs@scsiguy.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030108141838.0D06A4EE7@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno how useful this will be, but per the error message request, here's
a bug report of sorts...

Running 2.5.54 with the new aic7xxx driver.  Didn't get too far before
the machine crashed due to an unrelated problem, but saw the following
messages during bootup.  The device that didn't configure is the VIPER
2525 tape drive.

Jan  8 06:57:09 gherkin kernel: aic7xxx: PCI Device 0:9:0 failed memory mapped test.  Using PIO.
Jan  8 06:57:09 gherkin kernel: scsi0: PCI error Interrupt at seqaddr = 0x2
Jan  8 06:57:09 gherkin kernel: scsi0: Signaled a Target Abort
Jan  8 06:57:09 gherkin kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
Jan  8 06:57:09 gherkin kernel:         <Adaptec 2930 Ultra2 SCSI adapter>
Jan  8 06:57:09 gherkin kernel:         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Jan  8 06:57:09 gherkin kernel: 
Jan  8 06:57:09 gherkin kernel: (scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
Jan  8 06:57:09 gherkin kernel: (scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
Jan  8 06:57:09 gherkin kernel: (scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 11)
Jan  8 06:57:09 gherkin kernel: (scsi0:A:5): 8.333MB/s transfers (8.333MHz, offset 31)
Jan  8 06:57:09 gherkin kernel: scsi0:A:6:0: DV failed to configure device.  Please file a bug report against this driver.
Jan  8 06:57:09 gherkin kernel:   Vendor: WDIGTL    Model: WDE18300 ULTRA2   Rev: 1.30
Jan  8 06:57:09 gherkin kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jan  8 06:57:09 gherkin kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
Jan  8 06:57:09 gherkin kernel:   Vendor: PIONEER   Model: CD-ROM DR-U24X    Rev: 1.01
Jan  8 06:57:09 gherkin kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  8 06:57:09 gherkin kernel:   Vendor: EXABYTE   Model: EXB-82058VQANXR1  Rev: 07T0
Jan  8 06:57:09 gherkin kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Jan  8 06:57:09 gherkin kernel:   Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0j
Jan  8 06:57:09 gherkin kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan  8 06:57:09 gherkin kernel:   Vendor: ARCHIVE   Model: VIPER 2525 25462  Rev: -007
Jan  8 06:57:09 gherkin kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 01
Jan  8 06:57:09 gherkin kernel: SCSI device sda: drive cache: write back
Jan  8 06:57:09 gherkin kernel: SCSI device sda: 35761710 512-byte hdwr sectors (18310 MB)
Jan  8 06:57:09 gherkin kernel:  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15 >
Jan  8 06:57:09 gherkin kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
