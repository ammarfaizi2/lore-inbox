Return-Path: <linux-kernel-owner+w=401wt.eu-S932070AbWLLGg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWLLGg4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWLLGg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:36:56 -0500
Received: from 203-217-29-35.perm.iinet.net.au ([203.217.29.35]:34153 "EHLO
	anu.rimspace.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbWLLGgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:36:55 -0500
From: Daniel Pittman <daniel@rimspace.net>
To: linux-kernel@vger.kernel.org
Subject: AIC79XX abort -- hardware fault?
Date: Tue, 12 Dec 2006 17:36:46 +1100
Message-ID: <87ac1tfwn5.fsf@rimspace.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.5-b27 (fiddleheads, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day.  One of the machines I maintain is having real trouble with the
AIC79XX HBA or the tape drive attached to it.  I believe this is a
hardware fault, but I am not certain where the problem lies.

Normally I would blame the cable or, maybe, the tape drive, but the
early stage of the fault and the reported SCSI driver state make me
wonder if this is perhaps an HBA fault?

Regards,
        Daniel

scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec 29320ALP Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

 target0:0:0: asynchronous
scsi 0:0:0:0: Attempting to queue an ABORT message:CDB: 0x12 0x0 0x0 0x0 0x24 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State at program address 0x1b1 Mode 0x11
Card was paused
INTSTAT[0x0] SELOID[0x0] SELID[0x0] HS_MAILBOX[0x0]
INTCTL[0x0] SEQINTSTAT[0x0] SAVED_MODE[0x0] DFFSTAT[0x19]
SCSISIGI[0xa4] SCSIPHASE[0x0] SCSIBUS[0x0] LASTPHASE[0xa0]
SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] SEQINTCTL[0x0]
SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] QFREEZE_COUNT[0x0]
KERNEL_QFREEZE_COUNT[0x0] MK_MESSAGE_SCB[0xff00]
MK_MESSAGE_SCSIID[0xff] SSTAT0[0x0] SSTAT1[0x0]
SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] SIMODE1[0xac]
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]
LQOSTAT1[0x0] LQOSTAT2[0x0]

SCB Count = 4 CMDS_PENDING = 1 LASTSCB 0xffff CURRSCB 0x3 NEXTSCB 0x0
qinstart = 1 qinfifonext = 1
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
  3 FIFO_USE[0x0] SCB_CONTROL[0x40] SCB_SCSIID[0x7]
Total 1
Kernel Free SCB list: 2 1 0
Sequencer Complete DMA-inprog list:
Sequencer Complete list:
Sequencer DMA-Up and Complete list:
Sequencer On QFreeze and Complete list:


scsi0: FIFO0 Free, LONGJMP == 0x80ff, SCB 0x0
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]

scsi0: FIFO1 Active, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89]
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x14] SHADDR = 0x06, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]
LQIN: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0
SIMODE0[0xc]
CCSCBCTL[0x4]
scsi0: REG0 == 0x3, SINDEX = 0x1e0, DINDEX = 0xe1
scsi0: SCBPTR == 0x3, SCB_NEXT == 0xffc0, SCB_NEXT2 == 0xffed
CDB 12 0 0 0 24 0
STACK: 0x121 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi 0:0:0:0: Device is active, asserting ATN
scsi0: Recovery code sleeping
scsi0: Timer Expired (active 1)
Recovery code awake
scsi0: Command abort returning 0x2003
scsi 0:0:0:0: Attempting to queue a TARGET RESET message:CDB: 0x12 0x0 0x0 0x0 0x24 0x
0
scsi0: Device reset code sleeping
scsi0: Device reset timer expired (active 2)
scsi0: Device reset returning 0x2003
Recovery SCB completes
Recovery SCB completes
scsi 0:0:0:0: Attempting to queue an ABORT message:CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State at program address 0x1b2 Mode 0x11
Card was paused
INTSTAT[0x0] SELOID[0x0] SELID[0x0] HS_MAILBOX[0x0]
INTCTL[0x0] SEQINTSTAT[0x0] SAVED_MODE[0x0] DFFSTAT[0x19]
SCSISIGI[0xa4] SCSIPHASE[0x0] SCSIBUS[0x0] LASTPHASE[0xa0]
SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] SEQINTCTL[0x0]
SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] QFREEZE_COUNT[0x0]
KERNEL_QFREEZE_COUNT[0x0] MK_MESSAGE_SCB[0xff00]
MK_MESSAGE_SCSIID[0xff] SSTAT0[0x0] SSTAT1[0x0]
SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] SIMODE1[0xac]
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]
LQOSTAT1[0x0] LQOSTAT2[0x0]

SCB Count = 4 CMDS_PENDING = 1 LASTSCB 0xffff CURRSCB 0x3 NEXTSCB 0x0
qinstart = 2 qinfifonext = 2
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
  3 FIFO_USE[0x0] SCB_CONTROL[0x40] SCB_SCSIID[0x7]
Total 1
Kernel Free SCB list: 2 1 0
Sequencer Complete DMA-inprog list:
Sequencer Complete list:
Sequencer DMA-Up and Complete list:
Sequencer On QFreeze and Complete list:


scsi0: FIFO0 Free, LONGJMP == 0x80ff, SCB 0x0
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]

scsi0: FIFO1 Active, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x4] DFSTATUS[0x89]
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0]
SOFFCNT[0x0] MDFFSTAT[0x14] SHADDR = 0x06, SHCNT = 0x0
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]
LQIN: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
scsi0: SAVED_SCSIID = 0x0 SAVED_LUN = 0x0
SIMODE0[0xc]
CCSCBCTL[0x4]
scsi0: REG0 == 0x3, SINDEX = 0x1e0, DINDEX = 0xe1
scsi0: SCBPTR == 0x3, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xffed
CDB 0 0 0 0 0 0
STACK: 0x121 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi 0:0:0:0: Device is active, asserting ATN
scsi0: Recovery code sleeping
Recovery SCB completes
Recovery code awake
scsi 0:0:0:0: scsi: Device offlined - not ready after error recovery
scsi 0:0:0:0: rejecting I/O to offline device

-- 
Digital Infrastructure Solutions -- making IT simple, stable and secure
Phone: 0401 155 707        email: contact@digital-infrastructure.com.au
                 http://digital-infrastructure.com.au/
