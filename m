Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSHOUp6>; Thu, 15 Aug 2002 16:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSHOUp6>; Thu, 15 Aug 2002 16:45:58 -0400
Received: from ulima.unil.ch ([130.223.144.143]:43658 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S317468AbSHOUpx>;
	Thu, 15 Aug 2002 16:45:53 -0400
Date: Thu, 15 Aug 2002 22:49:47 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx errors ???
Message-ID: <20020815204947.GB31520@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using 2.4.20-pre1-ac3 and I have two SCSI cards (2940U and
29160LP), and at boot:

Aug 15 21:45:54 localhost kernel: SCSI subsystem driver Revision: 1.00
Aug 15 21:45:54 localhost kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Aug 15 21:45:54 localhost kernel:         <Adaptec 2940 Ultra SCSI adapter>
Aug 15 21:45:54 localhost kernel:         aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs
Aug 15 21:45:54 localhost kernel: 
Aug 15 21:45:54 localhost kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Aug 15 21:45:54 localhost kernel:         <Adaptec 29160B Ultra160 SCSI adapter>
Aug 15 21:45:54 localhost kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Aug 15 21:45:54 localhost kernel: 
Aug 15 21:45:54 localhost kernel: (scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
Aug 15 21:45:54 localhost kernel: scsi0:0:1:0: Attempting to queue an ABORT message
Aug 15 21:45:54 localhost kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7d
Aug 15 21:45:54 localhost kernel: ACCUM = 0xf0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0
Aug 15 21:45:54 localhost kernel: HCNT = 0xf0 SCBPTR = 0x0
Aug 15 21:45:54 localhost kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Aug 15 21:45:54 localhost kernel:  DFCNTRL = 0x78, DFSTATUS = 0x40
Aug 15 21:45:54 localhost kernel: LASTPHASE = 0x40, SCSISIGI = 0x44, SXFRCTL0 = 0xa0
Aug 15 21:45:54 localhost kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Aug 15 21:45:54 localhost kernel: STACK == 0x0, 0x0, 0x189, 0x6f
Aug 15 21:45:54 localhost kernel: SCB count = 4
Aug 15 21:45:54 localhost kernel: Kernel NEXTQSCB = 3
Aug 15 21:45:54 localhost kernel: Card NEXTQSCB = 3
Aug 15 21:45:54 localhost kernel: QINFIFO entries: 
Aug 15 21:45:54 localhost kernel: Waiting Queue entries: 
Aug 15 21:45:54 localhost kernel: Disconnected Queue entries: 
Aug 15 21:45:54 localhost kernel: QOUTFIFO entries: 
Aug 15 21:45:54 localhost kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Aug 15 21:45:54 localhost kernel: Sequencer SCB Info: 0(c 0x48, s 0x17, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Aug 15 21:45:54 localhost kernel: Pending list: 2(c 0x48, s 0x17, l 0)
Aug 15 21:45:54 localhost kernel: Kernel Free SCB list: 1 0 
Aug 15 21:45:54 localhost kernel: Untagged Q(1): 2 
Aug 15 21:45:54 localhost kernel: DevQ(0:1:0): 0 waiting
Aug 15 21:45:54 localhost kernel: scsi0:0:1:0: Device is active, asserting ATN
Aug 15 21:45:54 localhost kernel: Recovery code sleeping
Aug 15 21:45:54 localhost kernel: Recovery code awake
Aug 15 21:45:54 localhost kernel: Timer Expired
Aug 15 21:45:54 localhost kernel: aic7xxx_abort returns 0x2003
Aug 15 21:45:54 localhost kernel: scsi0:0:1:0: Attempting to queue a TARGET RESET message
Aug 15 21:45:54 localhost kernel: aic7xxx_dev_reset returns 0x2003
Aug 15 21:45:54 localhost kernel: Recovery SCB completes
Aug 15 21:45:54 localhost kernel: (scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 15)
Aug 15 21:45:54 localhost kernel: scsi0:0:1:0: Attempting to queue an ABORT message
Aug 15 21:45:54 localhost kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7d
Aug 15 21:45:54 localhost kernel: ACCUM = 0xf0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0
Aug 15 21:45:54 localhost kernel: HCNT = 0xf0 SCBPTR = 0x0
Aug 15 21:45:54 localhost kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Aug 15 21:45:54 localhost kernel:  DFCNTRL = 0x78, DFSTATUS = 0x40
Aug 15 21:45:54 localhost kernel: LASTPHASE = 0x40, SCSISIGI = 0x44, SXFRCTL0 = 0xa0
Aug 15 21:45:54 localhost kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Aug 15 21:45:54 localhost kernel: STACK == 0x0, 0x159, 0x189, 0x6f
Aug 15 21:45:54 localhost kernel: SCB count = 4
Aug 15 21:45:54 localhost kernel: Kernel NEXTQSCB = 3
Aug 15 21:45:54 localhost kernel: Card NEXTQSCB = 3
Aug 15 21:45:54 localhost kernel: QINFIFO entries: 
Aug 15 21:45:54 localhost kernel: Waiting Queue entries: 
Aug 15 21:45:54 localhost kernel: Disconnected Queue entries: 
Aug 15 21:45:54 localhost kernel: QOUTFIFO entries: 
Aug 15 21:45:54 localhost kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Aug 15 21:45:54 localhost kernel: Sequencer SCB Info: 0(c 0x48, s 0x17, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Aug 15 21:45:54 localhost kernel: Pending list: 2(c 0x48, s 0x17, l 0)
Aug 15 21:45:54 localhost kernel: Kernel Free SCB list: 1 0 
Aug 15 21:45:54 localhost kernel: Untagged Q(1): 2 
Aug 15 21:45:54 localhost kernel: DevQ(0:1:0): 0 waiting
Aug 15 21:45:54 localhost kernel: scsi0:0:1:0: Device is active, asserting ATN
Aug 15 21:45:54 localhost kernel: Recovery code sleeping
Aug 15 21:45:54 localhost kernel: Recovery code awake
Aug 15 21:45:54 localhost kernel: aic7xxx_abort returns 0x2002
Aug 15 21:45:54 localhost kernel: scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 1 lun 0
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Attempting to queue an ABORT message
Aug 15 21:45:54 localhost kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7c
Aug 15 21:45:54 localhost kernel: ACCUM = 0xf0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0
Aug 15 21:45:54 localhost kernel: HCNT = 0xf0 SCBPTR = 0x0
Aug 15 21:45:54 localhost kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Aug 15 21:45:54 localhost kernel:  DFCNTRL = 0x78, DFSTATUS = 0x40
Aug 15 21:45:54 localhost kernel: LASTPHASE = 0x40, SCSISIGI = 0x54, SXFRCTL0 = 0xa0
Aug 15 21:45:54 localhost kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Aug 15 21:45:54 localhost kernel: STACK == 0x0, 0x159, 0x189, 0x6f
Aug 15 21:45:54 localhost kernel: SCB count = 4
Aug 15 21:45:54 localhost kernel: Kernel NEXTQSCB = 1
Aug 15 21:45:54 localhost kernel: Card NEXTQSCB = 3
Aug 15 21:45:54 localhost kernel: QINFIFO entries: 3 
Aug 15 21:45:54 localhost kernel: Waiting Queue entries: 
Aug 15 21:45:54 localhost kernel: Disconnected Queue entries: 
Aug 15 21:45:54 localhost kernel: QOUTFIFO entries: 
Aug 15 21:45:54 localhost kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Aug 15 21:45:54 localhost kernel: Sequencer SCB Info: 0(c 0x48, s 0x17, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Aug 15 21:45:54 localhost kernel: Pending list: 3(c 0x50, s 0x27, l 0), 2(c 0x48, s 0x17, l 0)
Aug 15 21:45:54 localhost kernel: Kernel Free SCB list: 0 
Aug 15 21:45:54 localhost kernel: Untagged Q(1): 2 
Aug 15 21:45:54 localhost kernel: Untagged Q(2): 3 
Aug 15 21:45:54 localhost kernel: DevQ(0:1:0): 0 waiting
Aug 15 21:45:54 localhost kernel: DevQ(0:2:0): 0 waiting
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Cmd aborted from QINFIFO
Aug 15 21:45:54 localhost kernel: aic7xxx_abort returns 0x2002
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Attempting to queue an ABORT message
Aug 15 21:45:54 localhost kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7c
Aug 15 21:45:54 localhost kernel: ACCUM = 0xf0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0
Aug 15 21:45:54 localhost kernel: HCNT = 0xf0 SCBPTR = 0x0
Aug 15 21:45:54 localhost kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Aug 15 21:45:54 localhost kernel:  DFCNTRL = 0x78, DFSTATUS = 0x40
Aug 15 21:45:54 localhost kernel: LASTPHASE = 0x40, SCSISIGI = 0x54, SXFRCTL0 = 0xa0
Aug 15 21:45:54 localhost kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Aug 15 21:45:54 localhost kernel: STACK == 0x0, 0x159, 0x189, 0x6f
Aug 15 21:45:54 localhost kernel: SCB count = 4
Aug 15 21:45:54 localhost kernel: Kernel NEXTQSCB = 3
Aug 15 21:45:54 localhost kernel: Card NEXTQSCB = 1
Aug 15 21:45:54 localhost kernel: QINFIFO entries: 1 
Aug 15 21:45:54 localhost kernel: Waiting Queue entries: 
Aug 15 21:45:54 localhost kernel: Disconnected Queue entries: 
Aug 15 21:45:54 localhost kernel: QOUTFIFO entries: 
Aug 15 21:45:54 localhost kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Aug 15 21:45:54 localhost kernel: Sequencer SCB Info: 0(c 0x48, s 0x17, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Aug 15 21:45:54 localhost kernel: Pending list: 1(c 0x50, s 0x27, l 0), 2(c 0x48, s 0x17, l 0)
Aug 15 21:45:54 localhost kernel: Kernel Free SCB list: 0 
Aug 15 21:45:54 localhost kernel: Untagged Q(1): 2 
Aug 15 21:45:54 localhost kernel: Untagged Q(2): 1 
Aug 15 21:45:54 localhost kernel: DevQ(0:1:0): 0 waiting
Aug 15 21:45:54 localhost kernel: DevQ(0:2:0): 0 waiting
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Cmd aborted from QINFIFO
Aug 15 21:45:54 localhost kernel: aic7xxx_abort returns 0x2002
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Attempting to queue a TARGET RESET message
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Is not an active device
Aug 15 21:45:54 localhost kernel: aic7xxx_dev_reset returns 0x2002
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Attempting to queue an ABORT message
Aug 15 21:45:54 localhost kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7c
Aug 15 21:45:54 localhost kernel: ACCUM = 0xf0, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0x0
Aug 15 21:45:54 localhost kernel: HCNT = 0xf0 SCBPTR = 0x0
Aug 15 21:45:54 localhost kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Aug 15 21:45:54 localhost kernel:  DFCNTRL = 0x78, DFSTATUS = 0x40
Aug 15 21:45:54 localhost kernel: LASTPHASE = 0x40, SCSISIGI = 0x54, SXFRCTL0 = 0xa0
Aug 15 21:45:54 localhost kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Aug 15 21:45:54 localhost kernel: STACK == 0x0, 0x159, 0x189, 0x6f
Aug 15 21:45:54 localhost kernel: SCB count = 4
Aug 15 21:45:54 localhost kernel: Kernel NEXTQSCB = 1
Aug 15 21:45:54 localhost kernel: Card NEXTQSCB = 3
Aug 15 21:45:54 localhost kernel: QINFIFO entries: 3 
Aug 15 21:45:54 localhost kernel: Waiting Queue entries: 
Aug 15 21:45:54 localhost kernel: Disconnected Queue entries: 
Aug 15 21:45:54 localhost kernel: QOUTFIFO entries: 
Aug 15 21:45:54 localhost kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Aug 15 21:45:54 localhost kernel: Sequencer SCB Info: 0(c 0x48, s 0x17, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Aug 15 21:45:54 localhost kernel: Pending list: 3(c 0x50, s 0x27, l 0), 2(c 0x48, s 0x17, l 0)
Aug 15 21:45:54 localhost kernel: Kernel Free SCB list: 0 
Aug 15 21:45:54 localhost kernel: Untagged Q(1): 2 
Aug 15 21:45:54 localhost kernel: Untagged Q(2): 3 
Aug 15 21:45:54 localhost kernel: DevQ(0:1:0): 0 waiting
Aug 15 21:45:54 localhost kernel: DevQ(0:2:0): 0 waiting
Aug 15 21:45:54 localhost kernel: scsi0:0:2:0: Cmd aborted from QINFIFO
Aug 15 21:45:54 localhost kernel: aic7xxx_abort returns 0x2002
Aug 15 21:45:54 localhost kernel: Recovery SCB completes
Aug 15 21:45:54 localhost kernel: (scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
Aug 15 21:45:54 localhost kernel:   Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08Aug 15 21:45:54 localhost kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 15 21:45:54 localhost kernel: (scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
Aug 15 21:45:54 localhost kernel:   Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08Aug 15 21:45:54 localhost kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 15 21:45:54 localhost kernel: (scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
Aug 15 21:45:54 localhost kernel:   Vendor: IBM       Model: DDRS-39130D       Rev: DC1BAug 15 21:45:54 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Aug 15 21:45:54 localhost kernel: (scsi1:A:15): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
Aug 15 21:45:54 localhost kernel:   Vendor: SEAGATE   Model: ST336706LW        Rev: 0108Aug 15 21:45:54 localhost kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Aug 15 21:45:54 localhost kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 49
Aug 15 21:45:54 localhost kernel: scsi1:A:15:0: Tagged Queuing enabled.  Depth 49
Aug 15 21:45:54 localhost kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Aug 15 21:45:54 localhost kernel: Attached scsi disk sdb at scsi1, channel 0, id 15, lun 0
Aug 15 21:45:54 localhost kernel: SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
Aug 15 21:45:54 localhost kernel:  /dev/scsi/host1/bus0/target0/lun0: p1 p2
Aug 15 21:45:54 localhost kernel: (scsi1:A:15): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
Aug 15 21:45:54 localhost kernel: SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
Aug 15 21:45:54 localhost kernel:  /dev/scsi/host1/bus0/target15/lun0: p1 p2
Aug 15 21:45:54 localhost kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
Aug 15 21:45:54 localhost kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, id 3, lun 0
Aug 15 21:45:54 localhost kernel: sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Aug 15 21:45:54 localhost kernel: Uniform CD-ROM driver Revision: 3.12
Aug 15 21:45:54 localhost kernel: sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray

And my first CD-ROM on the 2940U card isn't detected at all???
When I replace the 2940U by a 2940 I don't have those problem???
(the BIOS see all three CD without problem...).

What should I do?

Thank you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
