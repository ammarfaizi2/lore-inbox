Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSHHNDW>; Thu, 8 Aug 2002 09:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317499AbSHHNDW>; Thu, 8 Aug 2002 09:03:22 -0400
Received: from mail4.nsc.com ([12.151.32.19]:32776 "EHLO sc2k-ntrdcss2")
	by vger.kernel.org with ESMTP id <S317472AbSHHNDU>;
	Thu, 8 Aug 2002 09:03:20 -0400
X-Server-Uuid: 1A83F278-DC98-44E4-831E-2C3D1E03F475
Message-ID: <200208081306.HAA11756@ia.nsc.com>
From: "Scott Worley" <Scott.Worley@nsc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 08 Aug 2002 07:06:52 -0600
Reply-to: "Scott Worley" <Scott.Worley@nsc.com>
X-Mailer: PMMail 2000 Professional (2.20.2502) For Windows 2000 (
 5.0.2195;2)
Subject: =?iso-8859-1?q?=C9:+w_SCSI_abort_msg_with_2.4.19?=
MIME-Version: 1.0
X-WSS-ID: 114CB34788808-09-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With kernel 2.4.19 (aic7xxx driver 6.2.8) I observe SCSI queue abort message and sequencer dump on the first SCSI HD during linux boot.  I did not 
observe this with kernel 2.4.18.  The following dmesg cut happens with UP and SMP 2.4.19.  I have also had a few instances of hard locks when installing 
Debian 3.0 during the copying/unpacking of the .deb's.

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 3960D Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0x3, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x6
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x8
SCSIPHASE = 0x0
STACK == 0x3, 0x108, 0x160, 0x0
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0xff) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 
0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 
0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, 
t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 
0x0, s 0xff, l 255, t 0xff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff, 
l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255, t 0xff) 31(c 0x0, s 0xff, l 255, t 
0xff) 
Pending list: 
Kernel Free SCB list: 3 1 0 
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
  Vendor: SEAGATE   Model: ST39140W          Rev: 1487
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: SEAGATE   Model: ST336938LW        Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:A:0): 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: SONY      Model: CD-ROM CDU-76S    Rev: 1.1c
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi2:A:5): 5.681MB/s transfers (5.681MHz, offset 15)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 >
SCSI device sdb: 72176567 512-byte hdwr sectors (36954 MB)
 sdb: sdb1
NET4: Linux TCP/IP 1.0 for NET4.0

The system is a Tyan MPX dual-athlon board, AMD 762/768 chipset.  Two athlon 1.2GHz processors, 768MB DDR(266MHz).
66MHz PCI Slot1 = Adaptec 39160
	Channel A = ST39140W
	Channel B = ST36938LW

33MHz 32bit PCI Slot3 = Adaptec 2490UW
	Sony CDU-76 CDROM

I have tried a few things but the problem persists:
1. Abort message is always on the first SCSI HD.  Have tested with only the LW drive connected and 2940UW not present, still happens.
2. Slowed down SCSI sync clock in Adaptec BIOS, no affect.
3. FreeBSD 4.6 doesn't seem to have a problem, at least in UP mode.

Any ideas on how I should start debugging this?  This machine isn't critical, all data is backed up, do I don't mind trashing it to find the root cause.

Please reply directly, I'm not subscribed to the list and am using work e-mail as I don't have inet at home where the affected machine is.

thanks,
scott worley
scott.worley@nsc.com




