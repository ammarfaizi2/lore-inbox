Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUGKNMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUGKNMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266588AbUGKNMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:12:36 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:7298 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S266585AbUGKNM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:12:29 -0400
Date: Sun, 11 Jul 2004 15:12:24 +0200
From: Antonin Kral <A.Kral@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: AIC79xx problem
Message-ID: <20040711131224.GA13575@sh.cvut.cz>
References: <A6974D8E5F98D511BB910002A50A6647615FFBBF@hdsmsx403.hd.intel.com> <1089513010.32034.36.camel@dhcppc2> <20040711061351.GA4190@sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711061351.GA4190@sh.cvut.cz>
X-URL: http://www.bobek.cz
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> I've checked that the problem is closely releated to AIC79xx, because it
> raises when I use SCSI. I've got some old IDE disk and with it work
> everything perfectly.

I still have problems with AIC79xx driver, but I've finally got some
kernel outputs. Problems seem to araise only during writing to the disk.
When I install system to the same disk at other computer, I can run
programs without problem, but during writing to the disk I receive a lot
of messages similar to these:

scsi1: PCI error Interrupt
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0xe Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
DFFSTAT[0x1] SCSISIGI[0x24] SCSIPHASE[0x1] SCSIBUS[0x94] 
LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x10] 
SEQINTCTL[0x8] SEQ_FLAGS[0xc0] SEQ_FLAGS2[0x0] SSTAT0[0x0] 
SSTAT1[0x19] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x81] 

SCB Count = 30 CMDS_PENDING = 2 LASTSCB 0x6 CURRSCB 0x1d NEXTSCB 0xff00
qinstart = 1103 qinfifonext = 1103
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
 29 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x37] 
  6 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x37] 
Total 2
Kernel Free SCB list: 21 28 4 17 27 24 20 16 23 22 3 2 1 5 14 13 12 11 0 9 8 7 19 15 18 10 26 25 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi1: FIFO0 Active, LONGJMP == 0x80ff, SCB 0x6
SEQIMODE[0x3f] SEQINTSRC[0x20] DFCNTRL[0x0] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x38] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x7e] MDFFSTAT[0xc] SHADDR = 0x0361cb000, SHCNT = 0x1000 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0] 
scsi1: FIFO1 Active, LONGJMP == 0x257, SCB 0x6
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x2c] DFSTATUS[0xc9] 
SG_CACHE_SHADOW[0x38] SG_STATE[0x3] DFFSXFRCTL[0x0] 
SOFFCNT[0x7e] MDFFSTAT[0x2] SHADDR = 0x0361cc000, SHCNT = 0x0 
HADDR = 0x0361cc000, HCNT = 0x0 CCSGCTL[0x10] 
LQIN: 0x5 0x0 0x0 0x6 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x80 0x0 0x0 0x0 0x2 0x0 
scsi1: LQISTATE = 0x25, LQOSTATE = 0x0, OPTIONMODE = 0x42
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x3
SIMODE0[0xc] 
CCSCBCTL[0x0] 
scsi1: REG0 == 0x15, SINDEX = 0x133, DINDEX = 0x108
scsi1: SCBPTR == 0x15, SCB_NEXT == 0x6, SCB_NEXT2 == 0xffe4
CDB 0 10 0 80 60 96
STACK: 0x125 0x0 0x0 0x25e 0x257 0x257 0x29 0x1
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:3:0): 0 waiting
DevQ(0:6:0): 0 waiting
scsi1: Split completion read data parity error in DFF1
scsi1: Address or Write Phase Parity Error Detected in DFF1.
scsi1: PCI error Interrupt
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x27 Mode 0x22
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
DFFSTAT[0x11] SCSISIGI[0x24] SCSIPHASE[0x1] SCSIBUS[0x95] 
LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x10] 
SEQINTCTL[0x0] SEQ_FLAGS[0xc0] SEQ_FLAGS2[0x0] SSTAT0[0x0] 
SSTAT1[0x19] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x81] 

SCB Count = 30 CMDS_PENDING = 2 LASTSCB 0x6 CURRSCB 0x1d NEXTSCB 0xff00
qinstart = 1103 qinfifonext = 1103
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
 29 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x37] 
  6 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x37] 
Total 2
Kernel Free SCB list: 21 28 4 17 27 24 20 16 23 22 3 2 1 5 14 13 12 11 0 9 8 7 19 15 18 10 26 25 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi1: FIFO0 Free, LONGJMP == 0x80ff, SCB 0x6
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x7e] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0] 
scsi1: FIFO1 Active, LONGJMP == 0x257, SCB 0x6
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x2c] DFSTATUS[0xc9] 
SG_CACHE_SHADOW[0x28] SG_STATE[0x3] DFFSXFRCTL[0x0] 
SOFFCNT[0x7e] MDFFSTAT[0x2] SHADDR = 0x0361ad000, SHCNT = 0x0 
HADDR = 0x0361ad000, HCNT = 0x0 CCSGCTL[0x10] 
LQIN: 0x5 0x0 0x0 0x6 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x80 0x0 0x0 0x0 0x2 0x0 
scsi1: LQISTATE = 0x25, LQOSTATE = 0x0, OPTIONMODE = 0x42
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x3
SIMODE0[0xc] 
CCSCBCTL[0x0] 
scsi1: REG0 == 0x1d, SINDEX = 0x122, DINDEX = 0x108
scsi1: SCBPTR == 0x15, SCB_NEXT == 0x6, SCB_NEXT2 == 0xffe4
CDB 0 10 0 80 60 96
STACK: 0x15 0x125 0x0 0x0 0x25e 0x257 0x93 0x29
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:3:0): 0 waiting
DevQ(0:6:0): 0 waiting
scsi1: Split completion read data parity error in DFF1
scsi1: Address or Write Phase Parity Error Detected in DFF1.
scsi1: PCI error Interrupt
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x93 Mode 0x11
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
DFFSTAT[0x11] SCSISIGI[0x24] SCSIPHASE[0x1] SCSIBUS[0x95] 
LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x10] 
SEQINTCTL[0x0] SEQ_FLAGS[0xc0] SEQ_FLAGS2[0x0] SSTAT0[0x0] 
SSTAT1[0x19] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x81] 

SCB Count = 30 CMDS_PENDING = 2 LASTSCB 0x6 CURRSCB 0x6 NEXTSCB 0xffc0
qinstart = 1120 qinfifonext = 1120
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
  6 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x37] 
 20 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x37] 
Total 2
Kernel Free SCB list: 24 27 17 4 28 21 29 16 23 22 3 2 1 5 14 13 12 11 0 9 8 7 19 15 18 10 26 25 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi1: FIFO0 Free, LONGJMP == 0x80ff, SCB 0x18
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x7e] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0] 
scsi1: FIFO1 Active, LONGJMP == 0x257, SCB 0x14
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x2c] DFSTATUS[0xc9] 
SG_CACHE_SHADOW[0x28] SG_STATE[0x3] DFFSXFRCTL[0x0] 
SOFFCNT[0x7e] MDFFSTAT[0x2] SHADDR = 0x036461000, SHCNT = 0x0 
HADDR = 0x036461000, HCNT = 0x0 CCSGCTL[0x10] 
LQIN: 0x5 0x0 0x0 0x14 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x80 0x0 0x0 0x0 0x2 0x0 
scsi1: LQISTATE = 0x25, LQOSTATE = 0x0, OPTIONMODE = 0x42
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
SIMODE0[0xc] 
CCSCBCTL[0x0] 
scsi1: REG0 == 0x60, SINDEX = 0x122, DINDEX = 0x108
scsi1: SCBPTR == 0x14, SCB_NEXT == 0xffc0, SCB_NEXT2 == 0xffe4
CDB 2a 0 0 0 28 90
STACK: 0x29 0x15 0x125 0x0 0x0 0x257 0x257 0x257
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:3:0): 0 waiting
DevQ(0:6:0): 0 waiting
scsi1: Split completion read data parity error in DFF1
scsi1: Address or Write Phase Parity Error Detected in DFF1.

I've found some info, that this could be releated to the firmware
version on the disk (
http://lists.freebsd.org/pipermail/aic7xxx/2004-February/004083.html ).
So output from the /proc/scsi/scsi:

Attached devices: 
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: SUPER    Model: GEM318           Rev: 0   
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST373453LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: SUPER    Model: GEM318           Rev: 0   
  Type:   Processor                        ANSI SCSI revision: 02


   Any idea? I will appreciate any help, thaks

        Antonin
