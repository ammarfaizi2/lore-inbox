Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318704AbSICEUq>; Tue, 3 Sep 2002 00:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSICEUq>; Tue, 3 Sep 2002 00:20:46 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:2244 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP
	id <S318704AbSICEUp>; Tue, 3 Sep 2002 00:20:45 -0400
From: "Jeffrey J. Kosowsky" <jeff.kosowsky@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15732.14757.772376.605776@surgeon.pretender>
Date: Tue, 3 Sep 2002 00:25:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Scary SCSI disk error message
X-Mailer: VM 6.97 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running a pretty standard RH7.3 configuration (Kernel 2.4.18)
with root and key filesystems on a 20Gig  EIDE disk. 

I also have some older ext2 partitions (circa Kernel 2.0) on a 2Gig
SCSI running on an Adaptac 2490 adapter.

When I mount the SCSI ext2 partitions, everything works fine for a
while but then access to the partition freezes for several minutes
associated with the thousands of scary syslog messages (see below).

SCSI termination is done properly.
Also, it should be noted that the SCSI drive is *rock* solid when
booted under an old 2.0.28 kernel or when accessed from Win95. In
fact, just before the most recent incident, I had fuly fscked the old
Linux partitions (including the 'badblocks' option) under 2.0.28.

Any suggestions?
** Could you please copy me on an email response, since I do not (yet)
subscribe to the mailing list? . Thanks very much for your help.

--------
syslog extacts follow:

Sep  2 11:42:09 surgeon kernel: attempt to access beyond end of device
Sep  2 11:42:09 surgeon kernel: 08:02: rw=0, want=7053826, limit=32130
Sep  2 11:42:09 surgeon kernel: attempt to access beyond end of device
Sep  2 11:42:09 surgeon kernel: 08:02: rw=0, want=7054081, limit=32130
....
... (plus *thousands* more lines like this)
....
Sep  2 12:01:17 surgeon kernel: scsi0:0:0:0: Attempting to queue an ABORT message
Sep  2 12:01:17 surgeon kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x79
Sep  2 12:01:17 surgeon kernel: ACCUM = 0x0, SINDEX = 0x8, DINDEX = 0x8f, ARG_2 = 0xff
Sep  2 12:01:17 surgeon kernel: HCNT = 0x18 SCBPTR = 0xd
Sep  2 12:01:17 surgeon kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Sep  2 12:01:17 surgeon kernel:  DFCNTRL = 0x78, DFSTATUS = 0x0
Sep  2 12:01:17 surgeon kernel: LASTPHASE = 0x40, SCSISIGI = 0x44, SXFRCTL0 = 0x80
Sep  2 12:01:17 surgeon kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Sep  2 12:01:17 surgeon kernel: STACK == 0x96, 0x186, 0x156, 0x0
Sep  2 12:01:17 surgeon kernel: SCB count = 60
Sep  2 12:01:17 surgeon kernel: Kernel NEXTQSCB = 34
Sep  2 12:01:17 surgeon kernel: Card NEXTQSCB = 39
Sep  2 12:01:17 surgeon kernel: QINFIFO entries: 39 31 45 9 52 46 54 50 10 33 28 29 35 32 43 47 40 19 13 6 55 
Sep  2 12:01:17 surgeon kernel: Waiting Queue entries: 
Sep  2 12:01:17 surgeon kernel: Disconnected Queue entries: 
Sep  2 12:01:17 surgeon kernel: QOUTFIFO entries: 
Sep  2 12:01:17 surgeon kernel: Sequencer Free SCB List: 3 7 1 11 4 0 8 9 15 12 2 14 6 5 10 
Sep  2 12:01:17 surgeon kernel: Sequencer SCB Info: 0(c 0x60, s 0x7, l 0, t 0xff) 1(c 0x60, s 0x7, l 0, t 0xff) 2(c 0x60, s 0x7, l 0, t 0xff) 3(c 0x60, s 0x7, l 0, t 0xff) 4(c 0x60, s 0x7, l 0, t 0xff) 5(c 0x60, s 0x7, l 0, t 0xff) 6(c 0x60, s 0x7, l 0, t 0xff) 7(c 0x60, s 0x7, l 0, t 0xff) 8(c 0x60, s 0x7, l 0, t 0xff) 9(c 0x60, s 0x7, l 0, t 0xff) 10(c 0x60, s 0x7, l 0, t 0xff) 11(c 0x60, s 0x7, l 0, t 0xff) 12(c 0x60, s 0x7, l 0, t 0xff) 13(c 0x60, s 0x7, l 0, t 0x29) 14(c 0x60, s 0x7, l 0, t 0xff) 15(c 0x60, s 0x7, l 0, t 0xff) 
Sep  2 12:01:17 surgeon kernel: Pending list: 55(c 0x60, s 0x7, l 0), 6(c 0x60, s 0x7, l 0), 13(c 0x60, s 0x7, l 0), 19(c 0x60, s 0x7, l 0), 40(c 0x60, s 0x7, l 0), 47(c 0x60, s 0x7, l 0), 43(c 0x60, s 0x7, l 0), 32(c 0x60, s 0x7, l 0), 35(c 0x60, s 0x7, l 0), 29(c 0x60, s 0x7, l 0), 28(c 0x60, s 0x7, l 0), 33(c 0x60, s 0x7, l 0), 10(c 0x60, s 0x7, l 0), 50(c 0x60, s 0x7, l 0), 54(c 0x60, s 0x7, l 0), 46(c 0x60, s 0x7, l 0), 52(c 0x60, s 0x7, l 0), 9(c 0x60, s 0x7, l 0), 45(c 0x60, s 0x7, l 0), 31(c 0x60, s 0x7, l 0), 39(c 0x60, s 0x7, l 0), 41(c 0x60, s 0x7, l 0)
Sep  2 12:01:17 surgeon kernel: Kernel Free SCB list: 1 44 48 51 36 37 38 49 42 11 27 2 0 16 3 12 25 17 53 59 58 22 23 4 8 24 57 7 30 26 5 21 15 14 20 18 56 
Sep  2 12:01:17 surgeon kernel: DevQ(0:0:0): 0 waiting
Sep  2 12:01:17 surgeon kernel: DevQ(0:5:0): 0 waiting
Sep  2 12:01:17 surgeon kernel: DevQ(0:6:0): 0 waiting
Sep  2 12:01:17 surgeon kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Sep  2 12:01:17 surgeon kernel: aic7xxx_abort returns 0x2002
Sep  2 12:01:27 surgeon kernel: scsi0:0:0:0: Attempting to queue an ABORT message
Sep  2 12:01:27 surgeon kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7a
Sep  2 12:01:27 surgeon kernel: ACCUM = 0x0, SINDEX = 0x8, DINDEX = 0x8f, ARG_2 = 0xff
Sep  2 12:01:27 surgeon kernel: HCNT = 0x18 SCBPTR = 0xd
Sep  2 12:01:27 surgeon kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Sep  2 12:01:27 surgeon kernel:  DFCNTRL = 0x78, DFSTATUS = 0x0
Sep  2 12:01:27 surgeon kernel: LASTPHASE = 0x40, SCSISIGI = 0x44, SXFRCTL0 = 0x80
Sep  2 12:01:27 surgeon kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Sep  2 12:01:27 surgeon kernel: STACK == 0x96, 0x186, 0x156, 0x0
Sep  2 12:01:27 surgeon kernel: SCB count = 60
Sep  2 12:01:27 surgeon kernel: Kernel NEXTQSCB = 46
Sep  2 12:01:27 surgeon kernel: Card NEXTQSCB = 34
Sep  2 12:01:27 surgeon kernel: QINFIFO entries: 34 31 45 9 52 54 50 10 33 28 29 35 32 43 47 40 19 13 6 55 39 
Sep  2 12:01:27 surgeon kernel: Waiting Queue entries: 
Sep  2 12:01:27 surgeon kernel: Disconnected Queue entries: 
Sep  2 12:01:27 surgeon kernel: QOUTFIFO entries: 
Sep  2 12:01:27 surgeon kernel: Sequencer Free SCB List: 3 7 1 11 4 0 8 9 15 12 2 14 6 5 10 
Sep  2 12:01:27 surgeon kernel: Sequencer SCB Info: 0(c 0x60, s 0x7, l 0, t 0xff) 1(c 0x60, s 0x7, l 0, t 0xff) 2(c 0x60, s 0x7, l 0, t 0xff) 3(c 0x60, s 0x7, l 0, t 0xff) 4(c 0x60, s 0x7, l 0, t 0xff) 5(c 0x60, s 0x7, l 0, t 0xff) 6(c 0x60, s 0x7, l 0, t 0xff) 7(c 0x60, s 0x7, l 0, t 0xff) 8(c 0x60, s 0x7, l 0, t 0xff) 9(c 0x60, s 0x7, l 0, t 0xff) 10(c 0x60, s 0x7, l 0, t 0xff) 11(c 0x60, s 0x7, l 0, t 0xff) 12(c 0x60, s 0x7, l 0, t 0xff) 13(c 0x60, s 0x7, l 0, t 0x29) 14(c 0x60, s 0x7, l 0, t 0xff) 15(c 0x60, s 0x7, l 0, t 0xff) 
Sep  2 12:01:27 surgeon kernel: Pending list: 39(c 0x60, s 0x7, l 0), 55(c 0x60, s 0x7, l 0), 6(c 0x60, s 0x7, l 0), 13(c 0x60, s 0x7, l 0), 19(c 0x60, s 0x7, l 0), 40(c 0x60, s 0x7, l 0), 47(c 0x60, s 0x7, l 0), 43(c 0x60, s 0x7, l 0), 32(c 0x60, s 0x7, l 0), 35(c 0x60, s 0x7, l 0), 29(c 0x60, s 0x7, l 0), 28(c 0x60, s 0x7, l 0), 33(c 0x60, s 0x7, l 0), 10(c 0x60, s 0x7, l 0), 50(c 0x60, s 0x7, l 0), 54(c 0x60, s 0x7, l 0), 52(c 0x60, s 0x7, l 0), 9(c 0x60, s 0x7, l 0), 45(c 0x60, s 0x7, l 0), 31(c 0x60, s 0x7, l 0), 34(c 0x60, s 0x7, l 0), 41(c 0x60, s 0x7, l 0)
Sep  2 12:01:27 surgeon kernel: Kernel Free SCB list: 1 44 48 51 36 37 38 49 42 11 27 2 0 16 3 12 25 17 53 59 58 22 23 4 8 24 57 7 30 26 5 21 15 14 20 18 56 
Sep  2 12:01:27 surgeon kernel: DevQ(0:0:0): 0 waiting
Sep  2 12:01:27 surgeon kernel: DevQ(0:5:0): 0 waiting
Sep  2 12:01:27 surgeon kernel: DevQ(0:6:0): 0 waiting
Sep  2 12:01:27 surgeon kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Sep  2 12:01:27 surgeon kernel: aic7xxx_abort returns 0x2002
Sep  2 12:01:27 surgeon kernel: scsi0:0:0:0: Attempting to queue an ABORT message
Sep  2 12:01:27 surgeon kernel: scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x7a
Sep  2 12:01:27 surgeon kernel: ACCUM = 0x0, SINDEX = 0x8, DINDEX = 0x8f, ARG_2 = 0xff
Sep  2 12:01:27 surgeon kernel: HCNT = 0x18 SCBPTR = 0xd
Sep  2 12:01:27 surgeon kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Sep  2 12:01:27 surgeon kernel:  DFCNTRL = 0x78, DFSTATUS = 0x0
Sep  2 12:01:27 surgeon kernel: LASTPHASE = 0x40, SCSISIGI = 0x44, SXFRCTL0 = 0x80
Sep  2 12:01:27 surgeon kernel: SSTAT0 = 0x0, SSTAT1 = 0x2
Sep  2 12:01:27 surgeon kernel: STACK == 0x96, 0x186, 0x156, 0x0
Sep  2 12:01:27 surgeon kernel: SCB count = 60
Sep  2 12:01:28 surgeon kernel: Kernel NEXTQSCB = 34
Sep  2 12:01:28 surgeon kernel: Card NEXTQSCB = 46
Sep  2 12:01:28 surgeon kernel: QINFIFO entries: 46 31 45 9 52 54 50 10 33 28 29 35 32 43 47 40 19 13 6 55 
Sep  2 12:01:28 surgeon kernel: Waiting Queue entries: 
Sep  2 12:01:28 surgeon kernel: Disconnected Queue entries: 
Sep  2 12:01:28 surgeon kernel: QOUTFIFO entries: 
Sep  2 12:01:28 surgeon kernel: Sequencer Free SCB List: 3 7 1 11 4 0 8 9 15 12 2 14 6 5 10 
Sep  2 12:01:28 surgeon kernel: Sequencer SCB Info: 0(c 0x60, s 0x7, l 0, t 0xff) 1(c 0x60, s 0x7, l 0, t 0xff) 2(c 0x60, s 0x7, l 0, t 0xff) 3(c 0x60, s 0x7, l 0, t 0xff) 4(c 0x60, s 0x7, l 0, t 0xff) 5(c 0x60, s 0x7, l 0, t 0xff) 6(c 0x60, s 0x7, l 0, t 0xff) 7(c 0x60, s 0x7, l 0, t 0xff) 8(c 0x60, s 0x7, l 0, t 0xff) 9(c 0x60, s 0x7, l 0, t 0xff) 10(c 0x60, s 0x7, l 0, t 0xff) 11(c 0x60, s 0x7, l 0, t 0xff) 12(c 0x60, s 0x7, l 0, t 0xff) 13(c 0x60, s 0x7, l 0, t 0x29) 14(c 0x60, s 0x7, l 0, t 0xff) 15(c 0x60, s 0x7, l 0, t 0xff) 
Sep  2 12:01:28 surgeon kernel: Pending list: 55(c 0x60, s 0x7, l 0), 6(c 0x60, s 0x7, l 0), 13(c 0x60, s 0x7, l 0), 19(c 0x60, s 0x7, l 0), 40(c 0x60, s 0x7, l 0), 47(c 0x60, s 0x7, l 0), 43(c 0x60, s 0x7, l 0), 32(c 0x60, s 0x7, l 0), 35(c 0x60, s 0x7, l 0), 29(c 0x60, s 0x7, l 0), 28(c 0x60, s 0x7, l 0), 33(c 0x60, s 0x7, l 0), 10(c 0x60, s 0x7, l 0), 50(c 0x60, s 0x7, l 0), 54(c 0x60, s 0x7, l 0), 52(c 0x60, s 0x7, l 0), 9(c 0x60, s 0x7, l 0), 45(c 0x60, s 0x7, l 0), 31(c 0x60, s 0x7, l 0), 46(c 0x60, s 0x7, l 0), 41(c 0x60, s 0x7, l 0)
Sep  2 12:01:28 surgeon kernel: Kernel Free SCB list: 39 1 44 48 51 36 37 38 49 42 11 27 2 0 16 3 12 25 17 53 59 58 22 23 4 8 24 57 7 30 26 5 21 15 14 20 18 56 
Sep  2 12:01:28 surgeon kernel: DevQ(0:0:0): 0 waiting
Sep  2 12:01:28 surgeon kernel: DevQ(0:5:0): 0 waiting
Sep  2 12:01:28 surgeon kernel: DevQ(0:6:0): 0 waiting
Sep  2 12:01:28 surgeon kernel: scsi0:0:0:0: Cmd aborted from QINFIFO
Sep  2 12:01:28 surgeon kernel: aic7xxx_abort returns 0x2002
....
... (this cycle also repeats a few dozen times)


