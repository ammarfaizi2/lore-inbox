Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280695AbRKBODh>; Fri, 2 Nov 2001 09:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280699AbRKBOD2>; Fri, 2 Nov 2001 09:03:28 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:1414 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S280695AbRKBODP>;
	Fri, 2 Nov 2001 09:03:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx bug, 2.4.13/6.2.4
In-Reply-To: <20011101222455.A5885@orr.falooley.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <20011101222455.A5885@orr.falooley.org>
Date: 02 Nov 2001 15:03:09 +0100
Message-ID: <m3n1259so2.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz <j@falooley.org> writes:

> I'm having troubles with the last few revisions of the new Gibbs aic7xxx
> driver that until now has served me well. This is kernel
> 2.4.13-preempt-lvmrc4 with the 6.2.4 scsi driver, but I saw it happen on
> 2.4.12 with 6.2.1. I haven't tried older versions with this CD.

Something similar here, but I have disks on this SCSI :-(

Plain 2.4.13-ac5 kernel, dual PIII-1000, VIA686B chipset, AHA2940UW
(more details available on request):

Adaptec AIC7xxx driver version: 6.2.4
aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
Channel A Target 0 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
	Channel A Target 0 Lun 0 Settings
		Commands Queued 7357
		Commands Active 0
		Command Openings 253
		Max Tagged Openings 253
		Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
	Channel A Target 1 Lun 0 Settings
		Commands Queued 365
		Commands Active 0
		Command Openings 253
		Max Tagged Openings 253
		Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 4 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 40.000MB/s transfers (20.000MHz, offset 255, 16bit)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SAH0
  Type:   Direct-Access                    ANSI SCSI revision: 03

scsi0:A:0: parity error detected in Message-in phase. SEQADDR(0x1b6) SCSIRATE(0x0) 
scsi0: Unexpected busfree in Message-out phase 
SEQADDR == 0x166 
scsi0:0:0:0: Attempting to queue an ABORT message 
scsi0: Dumping Card State while idle, at SEQADDR 0x7 
ACCUM = 0x33, SINDEX = 0x7, DINDEX = 0x8c, ARG_2 = 0x0 
HCNT = 0x0 
SCSISEQ = 0x12, SBLKCTL = 0x2 
 DFCNTRL = 0x0, DFSTATUS = 0x29 
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80 
SSTAT0 = 0x5, SSTAT1 = 0xa 
STACK == 0x3, 0x105, 0x160, 0xe4 
SCB count = 20 
Kernel NEXTQSCB = 19 
Card NEXTQSCB = 19 
QINFIFO entries:  
Waiting Queue entries:  
Disconnected Queue entries: 7:5  
QOUTFIFO entries:  
Sequencer Free SCB List: 8 11 4 5 10 15 2 3 1 0 9 13 14 6 12  
Pending list: 5 
Kernel Free SCB list: 7 12 0 4 10 6 9 14 3 1 8 11 15 13 2 18 17 16  
DevQ(0:0:0): 0 waiting 
DevQ(0:1:0): 0 waiting 
(scsi0:A:0:0): Queuing a recovery SCB 
scsi0:0:0:0: Device is disconnected, re-queuing SCB 
Recovery code sleeping 
(scsi0:A:0:0): Abort Tag Message Sent 
(scsi0:A:0:0): SCB 5 - Abort Tag Completed. 
Recovery SCB completes 
Recovery code awake 
aic7xxx_abort returns 0x2002 
scsi0:A:0: parity error detected in Message-in phase. SEQADDR(0x1b6) SCSIRATE(0x0) 
Kernel panic: HOST_MSG_LOOP with invalid SCB ff 
 
In interrupt handler - not syncing 

-- 
Krzysztof Halasa
Network Administrator
