Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSFZOmJ>; Wed, 26 Jun 2002 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSFZOmI>; Wed, 26 Jun 2002 10:42:08 -0400
Received: from pcp748332pcs.manass01.va.comcast.net ([68.49.120.123]:44672
	"EHLO pcp748332pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S316609AbSFZOmH>; Wed, 26 Jun 2002 10:42:07 -0400
Date: Wed, 26 Jun 2002 10:42:01 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.19 scsi error and question
Message-ID: <20020626144201.GA3397@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.56
Reply-To: Matthew Harrell 
	  <mharrell-dated-1025534521.3d2cfd@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I received the following error on my server this morning when it tried to
mount my jaz drive and copy some files to it.  The annoying thing is that
this crashed the machine.  I haven't yet tried a later kernel just due to
compilation problems.  Anyway, can someone tell me what this error means
and whether it denotes a problem with the scsi card, scsi device, or the 
media in the device?  The card is an Adaptec AHA-2940U2W

  found reiserfs format "3.5" with standard journal
  Reiserfs journal params: device 08:14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
  reiserfs: checking transaction log (sd(8,20)) for (sd(8,20))
  reiserfs: replayed 2 transactions in 1 seconds
  Using tea hash to sort names
  reiserfs: using 3.5.x disk format
  Packet log: CLPL=BLOCK IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:20:40:05:f3:31:08:00 SRC=192.168.100.1 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0xC0 TTL=1 ID=0 PROTO=2 
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0: Dumping Card State in Command phase, at SEQADDR 0x16d
  ACCUM = 0x80, SINDEX = 0xa0, DINDEX = 0xe4, ARG_2 = 0x1
  HCNT = 0x0
  SCSISEQ = 0x12, SBLKCTL = 0x6
   DFCNTRL = 0x4, DFSTATUS = 0x89
  LASTPHASE = 0x80, SCSISIGI = 0x84, SXFRCTL0 = 0x88
  SSTAT0 = 0x5, SSTAT1 = 0x2
  STACK == 0x17b, 0x165, 0x0, 0x35
  SCB count = 12
  Kernel NEXTQSCB = 4
  Card NEXTQSCB = 2
  QINFIFO entries: 2 10 11 6 3 0 1 7 
  Waiting Queue entries: 
  Disconnected Queue entries: 
  QOUTFIFO entries: 
  Sequencer Free SCB List: 4 3 7 8 6 5 2 1 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
  Pending list: 7, 1, 0, 3, 6, 11, 10, 2, 5
  Kernel Free SCB list: 9 8 
  Untagged Q(4): 5 
  DevQ(0:0:0): 0 waiting
  DevQ(0:4:0): 1 waiting
  DevQ(0:5:0): 0 waiting
  DevQ(0:6:0): 0 waiting
  scsi0:0:0:0: Cmd aborted from QINFIFO
  aic7xxx_abort returns 0x2002
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0:0:0:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0:0:0:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0:0:0:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0:0:0:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0:0:0:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0:0:0:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:0:0: Attempting to queue an ABORT message
  scsi0:0:0:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:4:0: Attempting to queue an ABORT message
  scsi0:0:4:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0:0:4:0: Attempting to queue an ABORT message
  scsi0:0:4:0: Command not found
  aic7xxx_abort returns 0x2002
  scsi0: ERROR on channel 0, id 4, lun 0, CDB: Write (10) 00 00 18 7c d0 00 00 08 00 
  Info fld=0x187cd1, Current sd08:10: sense key Medium Error
  Additional sense indicates Unrecovered read error
  end_request: I/O error, dev 08:10, sector 1604816
  (scsi0:A:4:0): data overrun detected in Data-out phase.  Tag == 0x4.
  (scsi0:A:4:0): Have seen Data Phase.  Length = 512.  NumSGs = 1.
  sg[0] - Addr 0x01641e00 : Length 512
  (scsi0:A:4:0): data overrun detected in Data-out phase.  Tag == 0x6.
  (scsi0:A:4:0): Have seen Data Phase.  Length = 512.  NumSGs = 1.
  sg[0] - Addr 0x01641e00 : Length 512
  (scsi0:A:4:0): data overrun detected in Data-out phase.  Tag == 0x5.
  (scsi0:A:4:0): Have seen Data Phase.  Length = 512.  NumSGs = 1.
  sg[0] - Addr 0x01641e00 : Length 512
  (scsi0:A:4:0): data overrun detected in Data-out phase.  Tag == 0x3.
  (scsi0:A:4:0): Have seen Data Phase.  Length = 512.  NumSGs = 1.
  sg[0] - Addr 0x01641e00 : Length 512
  (scsi0:A:4:0): data overrun detected in Data-out phase.  Tag == 0x6.
  (scsi0:A:4:0): Have seen Data Phase.  Length = 512.  NumSGs = 1.
  sg[0] - Addr 0x01641e00 : Length 512
  SCSI disk error : host 0 channel 0 id 4 lun 0 return code = 70000
  end_request: I/O error, dev 08:10, sector 1604817
