Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSCMDLk>; Tue, 12 Mar 2002 22:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292233AbSCMDLc>; Tue, 12 Mar 2002 22:11:32 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:6893 "EHLO postfix2-1.free.fr")
	by vger.kernel.org with ESMTP id <S292231AbSCMDLO>;
	Tue, 12 Mar 2002 22:11:14 -0500
Date: Tue, 12 Mar 2002 17:12:25 +0100 (CET)
From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmrb@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: SCSI errors with Philips MOs
Message-ID: <Pine.LNX.4.33.0203121708390.761-100000@gaston.free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear Kernel-developers,
with my new Philips-MOs (3.5", 640MB), when writing near end of media, I
observe the SCSI errors, that you can find at the end of this message.
The drive is a M2513EL by Fujitsu.
I use linux-2.4.17 and the aic7xxx driver for my SCSI storage controller
Adaptec AHA-294x/AIC-7871 but with aic7xxx_old the result is not better.

See also:
  Newsgroups: comp.sys.ibm.pc.hardware.storage
  Subject: Magneto Optical disk: problem with Philips
  Date: Tue, 19 Feb 2002 20:43:34 +0100
  Message-ID: <Pine.LNX.4.33.0202192040510.20735-100000@gaston.free.fr>

Could this be a bug in the kernel?
Cheers, Peter

14:30:39 kernel: scsi0:0:4:0: Attempting to queue an ABORT message
14:30:39 kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x7
14:30:39 kernel: ACCUM = 0xe8, SINDEX = 0x47, DINDEX = 0x25, ARG_2 = 0x2
14:30:39 kernel: HCNT = 0x0
14:30:39 kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
14:30:39 kernel:  DFCNTRL = 0x0, DFSTATUS = 0x2d
14:30:39 kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
14:30:39 kernel: SSTAT0 = 0x5, SSTAT1 = 0xa
14:30:39 kernel: STACK == 0x3, 0x186, 0x156, 0x0
14:30:39 kernel: SCB count = 104
14:30:39 kernel: Kernel NEXTQSCB = 7
14:30:39 kernel: Card NEXTQSCB = 7
14:30:39 kernel: QINFIFO entries:
14:30:39 kernel: Waiting Queue entries:
14:30:39 kernel: Disconnected Queue entries: 4:8
14:30:39 kernel: QOUTFIFO entries:
14:30:39 kernel: Sequencer Free SCB List: 14 15 8 5 6 2 0 3 10 12 11 7 9 1 13
14:30:39 kernel: Pending list: 8
14:30:39 kernel: Kernel Free SCB list: 18 50 5 15 33 32 30 11 12 45 31 20 4 34 102 29 46 55 54 24 49 47 53 51 2 52 38 37 35 28 61 60 57 16 17 58 1 13 62 56 14 63 59 48 22 3 42 44 40 9 41 27 26 21 23 19 43 67 0 25 39 6 10 36 103 96 97 98 99 92 93 94 95 88 89 90 91 84 85 86 87 80 81 82 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66 101 100
14:30:39 kernel: Untagged Q(4): 8
14:30:39 kernel: DevQ(0:0:0): 0 waiting
14:30:39 kernel: DevQ(0:1:0): 0 waiting
14:30:39 kernel: DevQ(0:2:0): 0 waiting
14:30:39 kernel: DevQ(0:4:0): 0 waiting
14:30:39 kernel: DevQ(0:5:0): 0 waiting
14:30:39 kernel: (scsi0:A:4:0): Queuing a recovery SCB
14:30:39 kernel: scsi0:0:4:0: Device is disconnected, re-queuing SCB
14:30:39 kernel: Recovery code sleeping
14:30:39 kernel: (scsi0:A:4:0): Abort Message Sent
14:30:39 kernel: (scsi0:A:4:0): SCB 8 - Abort Completed.
14:30:39 kernel: Recovery SCB completes
14:30:39 kernel: Recovery code awake
14:30:39 kernel: aic7xxx_abort returns 0x2002
14:30:39 kernel: scsi0:0:4:0: Attempting to queue an ABORT message
14:30:39 kernel: scsi0:0:4:0: Command not found
14:30:39 kernel: aic7xxx_abort returns 0x2002
14:30:39 kernel: scsi0:0:4:0: Attempting to queue a TARGET RESET message
14:30:39 kernel: scsi0:0:4:0: Command not found
14:30:39 kernel: aic7xxx_dev_reset returns 0x2002
14:31:14 kernel: scsi0:0:4:0: Attempting to queue an ABORT message
14:31:14 kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x7
14:31:14 kernel: ACCUM = 0xf0, SINDEX = 0x47, DINDEX = 0x25, ARG_2 = 0x2
14:31:14 kernel: HCNT = 0x0
14:31:14 kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
14:31:14 kernel:  DFCNTRL = 0x0, DFSTATUS = 0x2d
14:31:14 kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
14:31:14 kernel: SSTAT0 = 0x5, SSTAT1 = 0xa
14:31:14 kernel: STACK == 0x3, 0x186, 0x156, 0xe1
14:31:14 kernel: SCB count = 104
14:31:14 kernel: Kernel NEXTQSCB = 7
14:31:14 kernel: Card NEXTQSCB = 7
14:31:14 kernel: QINFIFO entries:
14:31:14 kernel: Waiting Queue entries:
14:31:14 kernel: Disconnected Queue entries: 4:8
14:31:14 kernel: QOUTFIFO entries:
14:31:14 kernel: Sequencer Free SCB List: 14 15 8 5 6 2 0 3 10 12 11 7 9 1 13
14:31:14 kernel: Pending list: 8
14:31:14 kernel: Kernel Free SCB list: 18 50 5 15 33 32 30 11 12 45 31 20 4 34 102 29 46 55 54 24 49 47 53 51 2 52 38 37 35 28 61 60 57 16 17 58 1 13 62 56 14 63 59 48 22 3 42 44 40 9 41 27 26 21 23 19 43 67 0 25 39 6 10 36 103 96 97 98 99 92 93 94 95 88 89 90 91 84 85 86 87 80 81 82 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66 101 100
14:31:14 kernel: Untagged Q(4): 8
14:31:14 kernel: DevQ(0:0:0): 0 waiting
14:31:14 kernel: DevQ(0:1:0): 0 waiting
14:31:14 kernel: DevQ(0:2:0): 0 waiting
14:31:14 kernel: DevQ(0:4:0): 0 waiting
14:31:14 kernel: DevQ(0:5:0): 0 waiting
14:31:14 kernel: (scsi0:A:4:0): Queuing a recovery SCB
14:31:14 kernel: scsi0:0:4:0: Device is disconnected, re-queuing SCB
14:31:14 kernel: Recovery code sleeping
14:31:14 kernel: (scsi0:A:4:0): Abort Message Sent
14:31:15 kernel: Saw underflow (129024 of 129024 bytes). Treated as error
14:31:15 kernel: Recovery SCB completes
14:31:15 kernel: Recovery code awake
14:31:15 kernel: aic7xxx_abort returns 0x2002
14:31:15 kernel: scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 4 lun 0
14:31:20 kernel:  I/O error: dev 08:10, sector 1236700
14:31:20 kernel:  I/O error: dev 08:10, sector 1236952
14:31:20 kernel:  I/O error: dev 08:10, sector 1237204
14:31:20 kernel:  I/O error: dev 08:10, sector 1237456
14:31:20 kernel:  I/O error: dev 08:10, sector 1237708
14:31:20 kernel:  I/O error: dev 08:10, sector 1237960
14:31:20 kernel:  I/O error: dev 08:10, sector 1238212
14:31:20 kernel:  I/O error: dev 08:10, sector 1238464
14:31:20 kernel:  I/O error: dev 08:10, sector 1238716
14:31:20 kernel:  I/O error: dev 08:10, sector 1238968
14:31:20 kernel:  I/O error: dev 08:10, sector 1239220
14:31:20 kernel:  I/O error: dev 08:10, sector 1239472
14:31:20 kernel:  I/O error: dev 08:10, sector 1239724
14:31:20 kernel:  I/O error: dev 08:10, sector 1239976
14:31:20 kernel:  I/O error: dev 08:10, sector 1240228
14:31:20 kernel:  I/O error: dev 08:10, sector 1240480
14:31:20 kernel:  I/O error: dev 08:10, sector 1240732
14:31:20 kernel:  I/O error: dev 08:10, sector 1240984
14:31:20 kernel:  I/O error: dev 08:10, sector 1241236
14:31:20 kernel:  I/O error: dev 08:10, sector 736
14:31:20 kernel:  I/O error: dev 08:10, sector 1214416
14:31:20 kernel: SCSI disk error : host 0 channel 0 id 4 lun 0 return code = 70000
14:31:20 kernel:  I/O error: dev 08:10, sector 1236448
14:31:20 kernel:  I/O error: dev 08:10, sector 1236452
14:31:20 kernel:  I/O error: dev 08:10, sector 4

-- 
http://pmrb.free.fr/contact/

