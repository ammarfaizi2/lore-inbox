Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTBQUvD>; Mon, 17 Feb 2003 15:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTBQUvD>; Mon, 17 Feb 2003 15:51:03 -0500
Received: from imail.ricis.com ([64.244.234.16]:47883 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S267473AbTBQUu7>;
	Mon, 17 Feb 2003 15:50:59 -0500
Date: Mon, 17 Feb 2003 15:00:56 -0600
From: lee leahu <lee@ricis.com>
To: linux-kernel@vger.kernel.org
Subject: scsi causes kernel panic - please help
Message-Id: <20030217150056.3f5199bc.lee@ricis.com>
Reply-To: lee@ricis.com
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



im running 2.4.18-4GB-SMP.

i was running the following relevent applications at the time in the background:

 - vmware (i had the virtual machines cdrom drive connected to my cd-rewritter)
 - cdrdao read-toc --with-cddb --device 0,4,0  tocfile

appended to the end is the output from my system logs regarding the kernel panic.

does anyone have any idea what happened here?


Feb 17 14:43:58 zadio kernel: scsi0:0:4:0: Attempting to queue an ABORT message
Feb 17 14:43:58 zadio kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x7
Feb 17 14:43:58 zadio kernel: ACCUM = 0x17, SINDEX = 0x47, DINDEX = 0x25, ARG_2 = 0xff
Feb 17 14:43:58 zadio kernel: HCNT = 0xa0 SCBPTR = 0x0
Feb 17 14:43:58 zadio kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Feb 17 14:43:58 zadio kernel:  DFCNTRL = 0x0, DFSTATUS = 0x21
Feb 17 14:43:58 zadio kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
Feb 17 14:43:58 zadio kernel: SSTAT0 = 0x0, SSTAT1 = 0xa
Feb 17 14:43:58 zadio kernel: STACK == 0x3, 0x186, 0x156, 0x0
Feb 17 14:43:58 zadio kernel: SCB count = 4
Feb 17 14:43:58 zadio kernel: Kernel NEXTQSCB = 2
Feb 17 14:43:58 zadio kernel: Card NEXTQSCB = 2
Feb 17 14:43:58 zadio kernel: QINFIFO entries: 
Feb 17 14:43:58 zadio kernel: Waiting Queue entries: 
Feb 17 14:43:58 zadio kernel: Disconnected Queue entries: 0:3 
Feb 17 14:43:58 zadio kernel: QOUTFIFO entries: 
Feb 17 14:43:58 zadio kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Feb 17 14:43:58 zadio kernel: Sequencer SCB Info: 0(c 0x44, s 0x47, l 0, t 0x3) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Feb 17 14:43:58 zadio kernel: Pending list: 3(c 0x40, s 0x47, l 0)
Feb 17 14:43:58 zadio kernel: Kernel Free SCB list: 1 0 
Feb 17 14:43:58 zadio kernel: Untagged Q(4): 3 
Feb 17 14:43:58 zadio kernel: DevQ(0:4:0): 1 waiting
Feb 17 14:43:58 zadio kernel: (scsi0:A:4:0): Queuing a recovery SCB
Feb 17 14:43:58 zadio kernel: scsi0:0:4:0: Device is disconnected, re-queuing SCB
Feb 17 14:43:58 zadio kernel: Recovery code sleeping
Feb 17 14:43:58 zadio kernel: scsi0: brkadrint, Scratch or SCB Memory Parity Error at seqaddr = 0x7
Feb 17 14:43:58 zadio kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x7
Feb 17 14:43:58 zadio kernel: ACCUM = 0x17, SINDEX = 0x47, DINDEX = 0x25, ARG_2 = 0xff
Feb 17 14:43:58 zadio kernel: HCNT = 0xa0 SCBPTR = 0x0
Feb 17 14:43:58 zadio kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Feb 17 14:43:58 zadio kernel:  DFCNTRL = 0x0, DFSTATUS = 0x21
Feb 17 14:43:58 zadio kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
Feb 17 14:43:58 zadio kernel: SSTAT0 = 0x0, SSTAT1 = 0xa
Feb 17 14:43:58 zadio kernel: STACK == 0x3, 0x186, 0x156, 0x0
Feb 17 14:43:58 zadio kernel: SCB count = 4
Feb 17 14:43:58 zadio kernel: Kernel NEXTQSCB = 2
Feb 17 14:43:58 zadio kernel: Card NEXTQSCB = 3
Feb 17 14:43:58 zadio kernel: QINFIFO entries: 3 
Feb 17 14:43:58 zadio kernel: Waiting Queue entries: 
Feb 17 14:43:58 zadio kernel: Disconnected Queue entries: 
Feb 17 14:43:58 zadio kernel: QOUTFIFO entries: 
Feb 17 14:43:58 zadio kernel: Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Feb 17 14:43:58 zadio kernel: Sequencer SCB Info: 0(c 0x0, s 0x47, l 0, t 0xff) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255, t 0xff) 
Feb 17 14:43:58 zadio kernel: Pending list: 3(c 0x54, s 0x47, l 0)
Feb 17 14:43:58 zadio kernel: Kernel Free SCB list: 1 0 
Feb 17 14:43:58 zadio kernel: Untagged Q(4): 3 
Feb 17 14:43:58 zadio kernel: DevQ(0:4:0): 1 waiting
Feb 17 14:43:58 zadio kernel: Recovery SCB completes
Feb 17 14:43:58 zadio kernel: Recovery code awake
Feb 17 14:43:58 zadio kernel: aic7xxx_abort returns 0x2002





- -- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| PGP Public Key:          http://www.dyweni.com/lee.gpg             |
+--------------------------------------------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|               -- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+UU2Ixee+6O75B1MRAnWJAJ4kkRjGLX7X1XG8naLlRAb9rU4x7gCfaOtR
KFs2rsAnKhkWQaJiRfnSYm0=
=NWa6
-----END PGP SIGNATURE-----
