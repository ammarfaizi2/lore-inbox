Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbTL1LFA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 06:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbTL1LFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 06:05:00 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:60937 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S265071AbTL1LEz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 06:04:55 -0500
Date: Sun, 28 Dec 2003 12:04:52 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-mm lost my CD-r (aic7xxx)
Message-ID: <20031228110452.GA31088@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yesterday I wanted to make a backup from an audio CD, and I got same error
today:

cdrdao copy --device 1,2,0 --eject --keepimage
  SCSI interface library - (C) Joerg Schilling
  Paranoia DAE library - (C) Monty

Check http://cdrdao.sourceforge.net/drives.html#dt for current driver tables.

Using libscg version 'andreas-0.5-UNIXWARE_Patch'

1,2,0: PLEXTOR CD-R   PX-R820T  Rev: 1.08
Using driver: Generic SCSI-3/MMC - Version 2.0 (options 0x0000)

Starting CD copy resid: 102
at speed 8...

Track   Mode    Flags  Start                Length
------------------------------------------------------------
 1      AUDIO   0      00:00:00(     0)     04:58:17( 22367)
...
Track 16...
Found ISRC code.
?: No such device or address. Cannot send SCSI cmd via ioctl

Dec 28 11:52:35 greg kernel: scsi1:0:2:0: Attempting to queue an ABORT message
Dec 28 11:52:35 greg kernel: CDB: 0xbe 0x0 0x0 0x5 0x60 0x28 0x0 0x0 0x1a 0xf8 0x1 0x0
Dec 28 11:52:35 greg kernel: scsi1: At time of recovery, card was not paused
Dec 28 11:52:35 greg kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Dec 28 11:52:35 greg kernel: scsi1: Dumping Card State while idle, at SEQADDR 0x8
Dec 28 11:52:35 greg kernel: Card was paused
Dec 28 11:52:35 greg kernel: ACCUM = 0xad, SINDEX = 0x27, DINDEX = 0x23, ARG_2 = 0xff
Dec 28 11:52:35 greg kernel: HCNT = 0xe0 SCBPTR = 0x0
Dec 28 11:52:35 greg kernel: SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] 
Dec 28 11:52:35 greg kernel: SCSISEQ[0x12] SBLKCTL[0x0] SCSIRATE[0x0] SEQCTL[0x10] 
Dec 28 11:52:35 greg kernel: SEQ_FLAGS[0xc0] SSTAT0[0x0] SSTAT1[0xa] SSTAT2[0x0] 
Dec 28 11:52:35 greg kernel: SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] SXFRCTL0[0x80] 
Dec 28 11:52:35 greg kernel: DFCNTRL[0x0] DFSTATUS[0x21] 
Dec 28 11:52:35 greg kernel: STACK: 0x0 0x162 0x192 0x3
Dec 28 11:52:35 greg kernel: SCB count = 4
Dec 28 11:52:35 greg kernel: Kernel NEXTQSCB = 3
Dec 28 11:52:35 greg kernel: Card NEXTQSCB = 3
Dec 28 11:52:35 greg kernel: QINFIFO entries: 
Dec 28 11:52:35 greg kernel: Waiting Queue entries: 
Dec 28 11:52:35 greg kernel: Disconnected Queue entries: 0:2 
Dec 28 11:52:35 greg kernel: QOUTFIFO entries: 
Dec 28 11:52:35 greg kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Dec 28 11:52:35 greg kernel: Sequencer SCB Info: 
Dec 28 11:52:35 greg kernel:   0 SCB_CONTROL[0x44] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0x2] 
Dec 28 11:52:35 greg kernel:   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel:  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Dec 28 11:52:35 greg kernel: Pending list: 
Dec 28 11:52:35 greg kernel:   2 SCB_CONTROL[0x40] SCB_SCSIID[0x27] SCB_LUN[0x0] 
Dec 28 11:52:35 greg kernel: Kernel Free SCB list: 1 0 
Dec 28 11:52:35 greg kernel: Untagged Q(2): 2 
Dec 28 11:52:35 greg kernel: DevQ(0:1:0): 0 waiting
Dec 28 11:52:35 greg kernel: DevQ(0:2:0): 0 waiting
Dec 28 11:52:35 greg kernel: DevQ(0:3:0): 0 waiting
Dec 28 11:52:35 greg kernel: 
Dec 28 11:52:35 greg kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Dec 28 11:52:35 greg kernel: (scsi1:A:2:0): Device is disconnected, re-queuing SCB
Dec 28 11:52:35 greg kernel: Recovery code sleeping
Dec 28 11:52:35 greg kernel: (scsi1:A:2:0): Abort Message Sent
Dec 28 11:52:40 greg kernel: Recovery code awake
Dec 28 11:52:40 greg kernel: Timer Expired
Dec 28 11:52:40 greg kernel: aic7xxx_abort returns 0x2003
Dec 28 11:52:40 greg kernel: scsi1:0:2:0: Attempting to queue a TARGET RESET message
Dec 28 11:52:40 greg kernel: CDB: 0xbe 0x0 0x0 0x5 0x60 0x28 0x0 0x0 0x1a 0xf8 0x1 0x0
Dec 28 11:52:40 greg kernel: aic7xxx_dev_reset returns 0x2003
Dec 28 11:52:40 greg kernel: Recovery SCB completes
Dec 28 11:52:50 greg kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 2 lun 0

And I got the same problem with my other CD-R...

And then, I need to reboot to regain access to my CD-R:
cdda2wav -v255 -D  1,2,0 -B
Warning: numerical parameters for -v are no more supported in the next releases!
cdda2wav: Warning Linux Bus mapping botch.
cdda2wav: Warning Linux Bus mapping botch.
cdda2wav: No such file or directory. Cannot open '/dev/sg*'. Cannot open SCSI driver.
open(1,2,0) in file interface.c, line 532
Use the script scan_scsi.linux to find out more.
Probably you did not define your SCSI device.
You can scan the SCSI bus(es) with 'cdrecord -scanbus'.
Set the CDDA_DEVICE environment variable or use the -D option.
You can also define the default device in the Makefile.
For possible transport specifiers try 'cdda2wav dev=help'.


With cdda2wav -v255 -D  1,3,0 -B
the info are read but:
Dec 28 11:54:21 greg kernel: cdda2wav: page allocation failure. order:3, mode:0x20
Dec 28 11:54:21 greg kernel: Call Trace:
Dec 28 11:54:21 greg kernel:  [<c013c70e>] __alloc_pages+0x31b/0x31d
Dec 28 11:54:21 greg kernel:  [<c013c72f>] __get_free_pages+0x1f/0x41
Dec 28 11:54:21 greg kernel:  [<c02b92de>] sg_page_malloc+0x42/0xea
Dec 28 11:54:21 greg kernel:  [<c02b8050>] sg_build_indirect+0x165/0x1e8
Dec 28 11:54:21 greg kernel:  [<c02b8b3e>] sg_build_reserve+0x2f/0x4c
Dec 28 11:54:21 greg kernel:  [<c02b6c13>] sg_ioctl+0xc40/0xd32
Dec 28 11:54:21 greg kernel:  [<c013c48f>] __alloc_pages+0x9c/0x31d
Dec 28 11:54:21 greg kernel:  [<c013c72f>] __get_free_pages+0x1f/0x41
Dec 28 11:54:21 greg kernel:  [<c0138238>] find_get_page+0x2d/0x56
Dec 28 11:54:21 greg kernel:  [<c01395c3>] filemap_nopage+0x323/0x34f
Dec 28 11:54:21 greg kernel:  [<c0146a4a>] do_no_page+0x1da/0x384
Dec 28 11:54:21 greg kernel:  [<c02b53ca>] sg_read+0xce/0x40b
Dec 28 11:54:21 greg kernel:  [<c0146e5f>] handle_mm_fault+0x15d/0x1da
Dec 28 11:54:21 greg kernel:  [<c011a18c>] do_page_fault+0x182/0x571
Dec 28 11:54:21 greg kernel:  [<c011b160>] recalc_task_prio+0x13e/0x1b6
Dec 28 11:54:21 greg kernel:  [<c011bc7b>] schedule+0xed/0x684
Dec 28 11:54:21 greg kernel:  [<c02b5fd3>] sg_ioctl+0x0/0xd32
Dec 28 11:54:21 greg kernel:  [<c0166c2d>] sys_ioctl+0x24a/0x2c5
Dec 28 11:54:21 greg kernel:  [<c03ae9e7>] syscall_call+0x7/0xb
...

But I think this particular problem has been already discussed...

PLEASE, CC to me as I am not on the ml ;-)

	Grégoire
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
