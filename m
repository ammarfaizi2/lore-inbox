Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSK0Sux>; Wed, 27 Nov 2002 13:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSK0Sux>; Wed, 27 Nov 2002 13:50:53 -0500
Received: from imail.ricis.com ([64.244.234.16]:56328 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S262712AbSK0Suw>;
	Wed, 27 Nov 2002 13:50:52 -0500
Date: Wed, 27 Nov 2002 12:58:10 -0600
From: Lee Leahu <lee@ricis.com>
To: linux-kernel@vger.kernel.org
Subject: vmware + aic7xxx + 2.4.19-4gb-smp = kernel panic
Message-Id: <20021127125810.2a4c4574.lee@ricis.com>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


my hardware is this:

2 pentium III 1.13 gb processors
tyan motharboard w/ via chipset
1.5 gb ram

adaptec 2490 scsi card.
plextor cd re-writer 8/2/20

sound blaster live card

-----------------------------------------------------------

problem description:

when i have vmware up and running w2k server,
and i burn a cd from bash (as root) using cdrecord,
i am getting a kernel panic.

also to note,  the emu10k1 sound driver is loaded with xmms playing mp3s.


----------------------------------------------------------

additional kernel info:

i was able to save this data because i configured the kernel to use the serial port as its console,
and i had tail -f /var/log/messages running on the serial port console



Nov 27 12:38:36 zadio kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
Nov 27 12:38:36 zadio kernel:  I/O error: dev 0b:00, sector 64
Nov 27 12:38:37 zadio last message repeated 4 times
Nov 27 12:38:37 zadio kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
Nov 27 12:38:37 zadio kernel:  I/O error: dev 0b:00, sector 64
Nov 27 12:38:37 zadio last message repeated 4 times
Nov 27 12:38:38 zadio kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
Nov 27 12:38:38 zadio kernel:  I/O error: dev 0b:00, sector 64
Nov 27 12:38:38 zadio last message repeated 4 times
Nov 27 12:38:38 zadio kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
Nov 27 12:38:38 zadio kernel:  I/O error: dev 0b:00, sector 64
Nov 27 12:38:39 zadio last message repeated 4 times
Nov 27 12:38:39 zadio kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
Nov 27 12:39:15 zadio kernel: scsi0:0:4:0: Attempting to queue an ABORT message
Nov 27 12:39:15 zadio kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x15c
Nov 27 12:39:15 zadio kernel: ACCUM = 0x2, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
Nov 27 12:39:15 zadio kernel: HCNT = 0x0 SCBPTR = 0x0
Nov 27 12:39:15 zadio kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Nov 27 12:39:15 zadio kernel:  DFCNTRL = 0x4, DFSTATUS = 0x6d
Nov 27 12:39:15 zadio kernel: LASTPHASE = 0x1, SCSISIGI = 0xb6, SXFRCTL0 = 0x88
Nov 27 12:39:15 zadio kernel: SSTAT0 = 0x7, SSTAT1 = 0x13
Nov 27 12:39:15 zadio kernel: STACK == 0x186, 0x156, 0x0, 0x35
Nov 27 12:39:15 zadio kernel: SCB count = 4
Nov 27 12:39:15 zadio kernel: Kernel NEXTQSCB = 3
Nov 27 12:39:15 zadio kernel: Card NEXTQSCB = 3
Nov 27 12:39:15 zadio kernel: QINFIFO entries: 
Nov 27 12:39:15 zadio kernel: Waiting Queue entries: 
Nov 27 12:39:15 zadio kernel: Disconnected Queue entries: 
Nov 27 12:39:15 zadio kernel: QOUTFIFO entries: 
Nov 27 12:39:15 zadio kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Nov 27 12:39:15 zadio kernel: Sequencer SCB Info: 0(c 0x40, s 0x47, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Nov 27 12:39:15 zadio kernel: Pending list: 2(c 0x40, s 0x47, l 0)
Nov 27 12:39:15 zadio kernel: Kernel Free SCB list: 1 0 
Nov 27 12:39:15 zadio kernel: Untagged Q(4): 2 
Nov 27 12:39:15 zadio kernel: DevQ(0:4:0): 0 waiting
Nov 27 12:39:15 zadio kernel: (scsi0:A:4:0): Queuing a recovery SCB
Nov 27 12:39:15 zadio kernel: scsi0:0:4:0: Device is disconnected, re-queuing SCB
Nov 27 12:39:15 zadio kernel: scsi0: brkadrint, Scratch or SCB Memory Parity Error at seqaddr = 0x15c
Nov 27 12:39:15 zadio kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x15c
Nov 27 12:39:15 zadio kernel: ACCUM = 0x2, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
Nov 27 12:39:15 zadio kernel: HCNT = 0x0 SCBPTR = 0x0
Nov 27 12:39:15 zadio kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Nov 27 12:39:15 zadio kernel:  DFCNTRL = 0x4, DFSTATUS = 0x6d
Nov 27 12:39:15 zadio kernel: LASTPHASE = 0x1, SCSISIGI = 0xb6, SXFRCTL0 = 0x88
Nov 27 12:39:15 zadio kernel: SSTAT0 = 0x7, SSTAT1 = 0x13
Nov 27 12:39:15 zadio kernel: STACK == 0x186, 0x156, 0x0, 0x35
Nov 27 12:39:15 zadio kernel: SCB count = 4
Nov 27 12:39:15 zadio kernel: Kernel NEXTQSCB = 3
Nov 27 12:39:15 zadio kernel: Card NEXTQSCB = 2
Nov 27 12:39:15 zadio kernel: QINFIFO entries: 2 
Nov 27 12:39:15 zadio kernel: Waiting Queue entries: 
Nov 27 12:39:15 zadio kernel: Disconnected Queue entries: 
Nov 27 12:39:15 zadio kernel: QOUTFIFO entries: 
Nov 27 12:39:15 zadio kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Nov 27 12:39:15 zadio kernel: Sequencer SCB Info: 0(c 0x40, s 0x47, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Nov 27 12:39:15 zadio kernel: Pending list: 2(c 0x54, s 0x47, l 0)
Nov 27 12:39:15 zadio kernel: Kernel Free SCB list: 1 0 
Nov 27 12:39:15 zadio kernel: Untagged Q(4): 2 
Nov 27 12:39:15 zadio kernel: DevQ(0:4:0): 0 waiting
Nov 27 12:39:15 zadio kernel: Recovery SCB completes
Nov 27 12:39:15 zadio kernel: Recovery code sleeping
Nov 27 12:39:15 zadio kernel: Recovery code awake
Nov 27 12:39:15 zadio kernel: aic7xxx_abort returns 0x2002
Kernel panic: Loop 1




-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|		-- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
