Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319354AbSIFTaM>; Fri, 6 Sep 2002 15:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319355AbSIFTaL>; Fri, 6 Sep 2002 15:30:11 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:15577 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S319354AbSIFTaI>;
	Fri, 6 Sep 2002 15:30:08 -0400
Message-ID: <3D79F1A8.1060900@gmx.de>
Date: Sat, 07 Sep 2002 14:31:36 +0200
From: Rainer Eisenhofer <Rainer.Eisenhofer@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aix7xxx scsi problem after 2.4.18
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have got a problem with the aix7xxx scsi driver contained in kernel
versions > 2.4.18.
My scsi disk based system hangs frequently and I get following errors in
the log:

  >>>>>>>>>>
Sep  7 13:52:57 linux kernel: scsi0:0:1:0: Attempting to queue an ABORT
message
Sep  7 13:52:57 linux kernel: scsi0: Dumping Card State while idle, at
SEQADDR 0x7
Sep  7 13:52:57 linux kernel: ACCUM = 0xe0, SINDEX = 0x64, DINDEX =
0x65, ARG_2 = 0xff
Sep  7 13:52:57 linux kernel: HCNT = 0x0 SCBPTR = 0xa
Sep  7 13:52:57 linux kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Sep  7 13:52:57 linux kernel:  DFCNTRL = 0x0, DFSTATUS = 0x14
Sep  7 13:52:57 linux kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0
= 0x80
Sep  7 13:52:57 linux kernel: SSTAT0 = 0x0, SSTAT1 = 0xa
Sep  7 13:52:57 linux kernel: STACK == 0xe1, 0x156, 0x186, 0x3
Sep  7 13:52:57 linux kernel: SCB count = 36
Sep  7 13:52:57 linux kernel: Kernel NEXTQSCB = 11
Sep  7 13:53:23 linux kernel: Card NEXTQSCB = 11
Sep  7 13:53:23 linux kernel: QINFIFO entries:
Sep  7 13:53:23 linux kernel: Waiting Queue entries:
Sep  7 13:53:23 linux kernel: Disconnected Queue entries: 10:13
Sep  7 13:53:23 linux kernel: QOUTFIFO entries:
Sep  7 13:53:23 linux kernel: Sequencer Free SCB List: 13 2 3 12 15 9 8
5 11 4 7 6 0 14 1
Sep  7 13:53:23 linux kernel: Sequencer SCB Info: 0(c 0x60, s 0x17, l 0,
t 0xff) 1(c 0x60, s 0x17, l 0, t 0xff) 2(c 0x60, s 0x17, l 0, t 0xff)
3(c 0x60, s 0x17, l 0, t 0xff) 4(c 0x60, s 0x17, l 0, t 0xff) 5(c 0x60,
s 0x17, l 0, t 0xff) 6(c 0x60, s 0x17, l 0, t 0xff) 7(c 0x60, s 0x17, l
0, t 0xff) 8(c 0x60, s 0x17, l 0, t 0xff) 9(c 0x60, s 0x17, l 0, t 0xff)
10(c 0x64, s 0x17, l 0, t 0xd) 11(c 0x60, s 0x17, l 0, t 0xff) 12(c
0x60, s 0x17, l 0, t 0xff) 13(c 0x60, s 0x17, l 0, t 0xff) 14(c 0x60, s
0x17, l 0, t 0xff) 15(c 0x60, s 0x17, l 0, t 0xff)
Sep  7 13:53:23 linux kernel: Pending list: 13(c 0x60, s 0x17, l 0)
Sep  7 13:53:23 linux kernel: Kernel Free SCB list: 4 19 8 6 14 1 0 2 5
9 10 12 35 28 15 3 7 29 30 31 24 25 26 27 20 21 22 23 16 17 18 34 33 32
Sep  7 13:53:23 linux kernel: DevQ(0:0:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:1:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:2:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:4:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:5:0): 0 waiting
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): Queuing a recovery SCB
Sep  7 13:53:23 linux kernel: scsi0:0:1:0: Device is disconnected,
re-queuing SCB
Sep  7 13:53:23 linux kernel: Recovery code sleeping
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): Abort Tag Message Sent
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): SCB 13 - Abort Tag Completed.
Sep  7 13:53:23 linux kernel: Recovery SCB completes
Sep  7 13:53:23 linux kernel: Recovery code awake
Sep  7 13:53:23 linux kernel: aic7xxx_abort returns 0x2002
Sep  7 13:53:23 linux kernel: scsi0:0:1:0: Attempting to queue an ABORT
message
Sep  7 13:53:23 linux kernel: scsi0: Dumping Card State while idle, at
SEQADDR 0x8
Sep  7 13:53:23 linux kernel: ACCUM = 0xe2, SINDEX = 0x64, DINDEX =
0x65, ARG_2 = 0x2
Sep  7 13:53:23 linux kernel: HCNT = 0x0 SCBPTR = 0xa
Sep  7 13:53:23 linux kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Sep  7 13:53:23 linux kernel:  DFCNTRL = 0x0, DFSTATUS = 0x2d
Sep  7 13:53:23 linux kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0
= 0x80
Sep  7 13:53:23 linux kernel: SSTAT0 = 0x5, SSTAT1 = 0xa
Sep  7 13:53:23 linux kernel: STACK == 0xe1, 0xe1, 0x186, 0x3
Sep  7 13:53:23 linux kernel: SCB count = 36
Sep  7 13:53:23 linux kernel: Kernel NEXTQSCB = 13
Sep  7 13:53:23 linux kernel: Card NEXTQSCB = 13
Sep  7 13:53:23 linux kernel: QINFIFO entries:
Sep  7 13:53:23 linux kernel: Waiting Queue entries:
Sep  7 13:53:23 linux kernel: Disconnected Queue entries: 10:11
Sep  7 13:53:23 linux kernel: QOUTFIFO entries:
Sep  7 13:53:23 linux kernel: Sequencer Free SCB List: 13 2 3 12 15 9 8
5 11 4 7 6 0 14 1
Sep  7 13:53:23 linux kernel: Sequencer SCB Info: 0(c 0x60, s 0x17, l 0,
t 0xff) 1(c 0x60, s 0x17, l 0, t 0xff) 2(c 0x60, s 0x17, l 0, t 0xff)
3(c 0x60, s 0x17, l 0, t 0xff) 4(c 0x60, s 0x17, l 0, t 0xff) 5(c 0x60,
s 0x17, l 0, t 0xff) 6(c 0x60, s 0x17, l 0, t 0xff) 7(c 0x60, s 0x17, l
0, t 0xff) 8(c 0x60, s 0x17, l 0, t 0xff) 9(c 0x60, s 0x17, l 0, t 0xff)
10(c 0x64, s 0x17, l 0, t 0xb) 11(c 0x60, s 0x17, l 0, t 0xff) 12(c
0x60, s 0x17, l 0, t 0xff) 13(c 0x60, s 0x17, l 0, t 0xff) 14(c 0x60, s
0x17, l 0, t 0xff) 15(c 0x60, s 0x17, l 0, t 0xff)
Sep  7 13:53:23 linux kernel: Pending list: 11(c 0x60, s 0x17, l 0)
Sep  7 13:53:23 linux kernel: Kernel Free SCB list: 4 19 8 6 14 1 0 2 5
9 10 12 35 28 15 3 7 29 30 31 24 25 26 27 20 21 22 23 16 17 18 34 33 32
Sep  7 13:53:23 linux kernel: DevQ(0:0:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:1:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:2:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:4:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:5:0): 0 waiting
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): Queuing a recovery SCB
Sep  7 13:53:23 linux kernel: scsi0:0:1:0: Device is disconnected,
re-queuing SCB
Sep  7 13:53:23 linux kernel: Recovery code sleeping
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): Abort Tag Message Sent
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): SCB 11 - Abort Tag Completed.
Sep  7 13:53:23 linux kernel: Recovery SCB completes
Sep  7 13:53:23 linux kernel: Recovery code awake
Sep  7 13:53:23 linux kernel: aic7xxx_abort returns 0x2002
Sep  7 13:53:23 linux kernel: scsi0:0:1:0: Attempting to queue a TARGET
RESET message
Sep  7 13:53:23 linux kernel: scsi0:0:1:0: Command not found
Sep  7 13:53:23 linux kernel: aic7xxx_dev_reset returns 0x2002
Sep  7 13:53:23 linux kernel: scsi0:0:1:0: Attempting to queue an ABORT
message
Sep  7 13:53:23 linux kernel: scsi0: Dumping Card State while idle, at
SEQADDR 0x7
Sep  7 13:53:23 linux kernel: ACCUM = 0xe4, SINDEX = 0x64, DINDEX =
0x65, ARG_2 = 0x3
Sep  7 13:53:23 linux kernel: HCNT = 0x0 SCBPTR = 0xa
Sep  7 13:53:23 linux kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Sep  7 13:53:23 linux kernel:  DFCNTRL = 0x0, DFSTATUS = 0x2d
Sep  7 13:53:23 linux kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0
= 0x80
Sep  7 13:53:23 linux kernel: SSTAT0 = 0x5, SSTAT1 = 0xa
Sep  7 13:53:23 linux kernel: STACK == 0xe1, 0xe1, 0x186, 0x3
Sep  7 13:53:23 linux kernel: SCB count = 36
Sep  7 13:53:23 linux kernel: Kernel NEXTQSCB = 11
Sep  7 13:53:23 linux kernel: Card NEXTQSCB = 11
Sep  7 13:53:23 linux kernel: QINFIFO entries:
Sep  7 13:53:23 linux kernel: Waiting Queue entries:
Sep  7 13:53:23 linux kernel: Disconnected Queue entries: 10:13
Sep  7 13:53:23 linux kernel: QOUTFIFO entries:
Sep  7 13:53:23 linux kernel: Sequencer Free SCB List: 13 2 3 12 15 9 8
5 11 4 7 6 0 14 1
Sep  7 13:53:23 linux kernel: Sequencer SCB Info: 0(c 0x60, s 0x17, l 0,
t 0xff) 1(c 0x60, s 0x17, l 0, t 0xff) 2(c 0x60, s 0x17, l 0, t 0xff)
3(c 0x60, s 0x17, l 0, t 0xff) 4(c 0x60, s 0x17, l 0, t 0xff) 5(c 0x60,
s 0x17, l 0, t 0xff) 6(c 0x60, s 0x17, l 0, t 0xff) 7(c 0x60, s 0x17, l
0, t 0xff) 8(c 0x60, s 0x17, l 0, t 0xff) 9(c 0x60, s 0x17, l 0, t 0xff)
10(c 0x64, s 0x17, l 0, t 0xd) 11(c 0x60, s 0x17, l 0, t 0xff) 12(c
0x60, s 0x17, l 0, t 0xff) 13(c 0x60, s 0x17, l 0, t 0xff) 14(c 0x60, s
0x17, l 0, t 0xff) 15(c 0x60, s 0x17, l 0, t 0xff)
Sep  7 13:53:23 linux kernel: Pending list: 13(c 0x60, s 0x17, l 0)
Sep  7 13:53:23 linux kernel: Kernel Free SCB list: 4 19 8 6 14 1 0 2 5
9 10 12 35 28 15 3 7 29 30 31 24 25 26 27 20 21 22 23 16 17 18 34 33 32
Sep  7 13:53:23 linux kernel: DevQ(0:0:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:1:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:2:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:4:0): 0 waiting
Sep  7 13:53:23 linux kernel: DevQ(0:5:0): 0 waiting
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): Queuing a recovery SCB
Sep  7 13:53:23 linux kernel: scsi0:0:1:0: Device is disconnected,
re-queuing SCB
Sep  7 13:53:23 linux kernel: Recovery code sleeping
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): Abort Tag Message Sent
Sep  7 13:53:23 linux kernel: (scsi0:A:1:0): SCB 13 - Abort Tag Completed.
Sep  7 13:53:23 linux kernel: Recovery SCB completes
Sep  7 13:53:23 linux kernel: Recovery code awake
Sep  7 13:53:23 linux kernel: aic7xxx_abort returns 0x2002
<<<<<<<<<<

Everything works fine with kernel 2.4.18 and before, so I don't think
it's a hardware problem.
Because I'm not on the kernel mailing list it would be nice, if you set
me CC to this mail thread.

Thanks,
Rainer


