Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289061AbSBDVxd>; Mon, 4 Feb 2002 16:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSBDVxX>; Mon, 4 Feb 2002 16:53:23 -0500
Received: from gate.mesa.nl ([194.151.5.70]:24846 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S289061AbSBDVxF>;
	Mon, 4 Feb 2002 16:53:05 -0500
Date: Mon, 4 Feb 2002 22:53:03 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: linux-kernel@vger.kernel.org
Subject: AIC7xxx error with Minolta scanner
Message-ID: <20020204225303.A3997@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to get a Minolta dimage scan dual (photo scanner) using an
Adaptec AHA-2940 Ultra scsi controller gave the following error:


Feb  4 22:30:27 rim kernel: PCI: Found IRQ 5 for device 00:0a.0 
Feb  4 22:30:27 rim kernel: scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4 
Feb  4 22:30:27 rim kernel:         <Adaptec 2940 SCSI adapter> 
Feb  4 22:30:27 rim kernel:         aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs 
Feb  4 22:30:27 rim kernel:  
Feb  4 22:30:43 rim kernel: scsi2: brkadrint, Scratch or SCB Memory Parity Error at seqaddr = 0x1 
Feb  4 22:30:43 rim kernel: scsi2: Dumping Card State while idle, at SEQADDR 0x1 
Feb  4 22:30:43 rim kernel: ACCUM = 0x3, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0 
Feb  4 22:30:43 rim kernel: HCNT = 0x0 
Feb  4 22:30:43 rim kernel: SCSISEQ = 0x12, SBLKCTL = 0x0 
Feb  4 22:30:43 rim kernel:  DFCNTRL = 0x4, DFSTATUS = 0x6d 
Feb  4 22:30:43 rim kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80 
Feb  4 22:30:43 rim kernel: SSTAT0 = 0x5, SSTAT1 = 0x0 
Feb  4 22:30:43 rim kernel: STACK == 0x17, 0x186, 0x0, 0x0 
Feb  4 22:30:43 rim kernel: SCB count = 4 
Feb  4 22:30:43 rim kernel: Kernel NEXTQSCB = 2 
Feb  4 22:30:43 rim kernel: Card NEXTQSCB = 2 
Feb  4 22:30:43 rim kernel: QINFIFO entries:  
Feb  4 22:30:43 rim kernel: Waiting Queue entries:  
Feb  4 22:30:43 rim kernel: Disconnected Queue entries:  
Feb  4 22:30:43 rim kernel: QOUTFIFO entries:  
Feb  4 22:30:43 rim kernel: Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15  
Feb  4 22:30:43 rim kernel: Pending list:  
Feb  4 22:30:43 rim kernel: Kernel Free SCB list: 3 1 0  
Feb  4 22:30:49 rim kernel: scsi2:0:1:0: Attempting to queue an ABORT message 
Feb  4 22:30:49 rim kernel: scsi2: Dumping Card State while idle, at SEQADDR 0x18 
Feb  4 22:30:49 rim kernel: ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0x0, ARG_2 = 0x0 
Feb  4 22:30:49 rim kernel: HCNT = 0x0 
Feb  4 22:30:49 rim kernel: SCSISEQ = 0x0, SBLKCTL = 0xc0 
Feb  4 22:30:49 rim kernel:  DFCNTRL = 0x0, DFSTATUS = 0x29 
Feb  4 22:30:49 rim kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x0 
Feb  4 22:30:49 rim kernel: SSTAT0 = 0x0, SSTAT1 = 0x8 
Feb  4 22:30:49 rim kernel: STACK == 0x17, 0x0, 0x0, 0x0 
Feb  4 22:30:49 rim kernel: SCB count = 4 
Feb  4 22:30:49 rim kernel: Kernel NEXTQSCB = 3 
Feb  4 22:30:49 rim kernel: Card NEXTQSCB = 0 
Feb  4 22:30:49 rim kernel: QINFIFO entries: 3 2  
Feb  4 22:30:49 rim kernel: Waiting Queue entries: 0:255 1:255 2:255 3:255 4:255 5:255 6:255 7:255 8:255 9:255 10:255 11:255 12:255 13:255 14:255 15:255  
Feb  4 22:30:49 rim kernel: Disconnected Queue entries: 0:255 1:255 2:255 3:255 4:255 5:255 6:255 7:255 8:255 9:255 10:255 11:255 12:255 13:255 14:255 15:255  
Feb  4 22:30:49 rim kernel: QOUTFIFO entries:  
Feb  4 22:30:49 rim kernel: Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15  
Feb  4 22:30:49 rim kernel: Pending list: 2 
Feb  4 22:30:49 rim kernel: Kernel Free SCB list: 1 0  
Feb  4 22:30:49 rim kernel: Untagged Q(1): 2  
Feb  4 22:30:49 rim kernel: DevQ(0:1:0): 0 waiting 
Feb  4 22:30:49 rim kernel: qinpos = 0, SCB index = 3 
Feb  4 22:30:49 rim kernel: Kernel panic: Loop 1 
Feb  4 22:30:49 rim kernel:  

This is on liunx-2.4.18-pre7-ac3.
The scanner is the only device on the scsi controller.
>From above I don't know if this really has to do with the scanner
or if it is the contrller itself, but during boot of the system
the scanner is seen by the 2940...


-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
