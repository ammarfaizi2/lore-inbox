Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314232AbSDFMZx>; Sat, 6 Apr 2002 07:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314233AbSDFMZx>; Sat, 6 Apr 2002 07:25:53 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:20141 "EHLO
	sparsus.humilis.net") by vger.kernel.org with ESMTP
	id <S314232AbSDFMZw> convert rfc822-to-8bit; Sat, 6 Apr 2002 07:25:52 -0500
Date: Sat, 6 Apr 2002 14:25:44 +0200
From: Ookhoi <ookhoi@humilis.net>
To: linux-kernel@vger.kernel.org
Subject: scsi0:0:10:0: Attempting to queue an ABORT message, scsi0:0:10:0: Command not found, aic7xxx_abort returns 0x2002
Message-ID: <20020406142544.F19096@humilis>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.19i
X-Uptime: 15:47:46 up 41 days, 21:34, 18 users,  load average: 0.07, 0.02, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

dmesg gives a lot of lines like this:

scsi0:0:10:0: Attempting to queue an ABORT message
scsi0:0:10:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:10:0: Attempting to queue an ABORT message
scsi0:0:10:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:10:0: Attempting to queue an ABORT message
scsi0:0:10:0: Command not found
aic7xxx_abort returns 0x2002

We think it is a hardware problem, but I thought it is a good thing to
ask here for suggestions. I searched the archives and the web, but could
only find similar messages dated last year. 

I'm happy to provide more info, but hope all below is enough. Thanks in 
advance for suggestions or hints!

        Ookhoi


kernel 2.4.19-pre2-ac4
asus a7m266-d (amd 760mxp)
00:08.0 SCSI storage controller: Adaptec 7892A (rev 02)

/proc/scsi/scsi:
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03

/proc/scsi/aic7xxx/0:
Adaptec AIC7xxx driver version: 6.2.5
aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Channel A Target 0 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 1 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 4 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
	Channel A Target 8 Lun 0 Settings
		Commands Queued 652545
		Commands Active 1
		Command Openings 63
		Max Tagged Openings 64
		Device Queue Frozen Count 0
Channel A Target 9 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
	Channel A Target 10 Lun 0 Settings
		Commands Queued 605981
		Commands Active 0
		Command Openings 64
		Max Tagged Openings 64
		Device Queue Frozen Count 0
Channel A Target 11 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)

Also in dmesg:
scsi0:0:8:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x4, SINDEX = 0x64, DINDEX = 0x65, ARG_2 = 0x16
HCNT = 0x0 SCBPTR = 0x7
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0x8
SCSIPHASE = 0x0
STACK == 0x3, 0x175, 0x160, 0x0
SCB count = 136
Kernel NEXTQSCB = 61
Card NEXTQSCB = 61
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 7:91 27:59 17:104 15:62 6:17 8:51 10:13 
QOUTFIFO entries: 
Sequencer Free SCB List: 16 12 11 14 29 25 26 2 23 24 20 4 19 13 21 30 0 9 22 28 5 31 3 18 1 
Sequencer SCB Info: 0(c 0x60, s 0x87, l 0, t 0xff) 1(c 0x60, s 0xa7, l 0, t 0xff) 2(c 0x60, s 0x87, l 0, t 0xff) 3(c 0x60, s 0x87, l 0, t 0xff) 4(c 0x60, s 0x87, l 0, t 0xff) 5(c 0x60, s 0x87, l 0, t 0xff) 6(c 0x64, s 0x87, l 0, t 0x11) 7(c 0x64, s 0x87, l 0, t 0x5b) 8(c 0x64, s 0x87, l 0, t 0x33) 9(c 0x60, s 0xa7, l 0, t 0xff) 10(c 0x64, s 0x87, l 0, t 0xd) 11(c 0x60, s 0xa7, l 0, t 0xff) 12(c 0x60, s 0x87, l 0, t 0xff) 13(c 0x60, s 0xa7, l 0, t 0xff) 14(c 0x60, s 0xa7, l 0, t 0xff) 15(c 0x64, s 0x87, l 0, t 0x3e) 16(c 0x60, s 0x87, l 0, t 0xff) 17(c 0x64, s 0x87, l 0, t 0x68) 18(c 0x60, s 0xa7, l 0, t 0xff) 19(c 0x60, s 0xa7, l 0, t 0xff) 20(c 0x60, s 0xa7, l 0, t 0xff) 21(c 0x60, s 0xa7, l 0, t 0xff) 22(c 0x60, s 0x87, l 0, t 0xff) 23(c 0x60, s 0x87, l 0, t 0xff) 24(c 0x60, s 0xa7, l 0, t 0xff) 25(c 0x60, s 0xa7, l 0, t 0xff) 26(c 0x60, s 0x87, l 0, t 0xff) 27(c 0x64, s 0x87, l 0, t 0x3b) 28(c 0x60, s 0x87, l 0, t 0xff) 29(c 0x60, s 0x87, l 0, t 0xff) 30(c 0x60, s 0xa7, l 0, t 0xff) 31(c 0x60, s 0xa7, l 0, t 0xff) 
Pending list: 91(c 0x60, s 0x87, l 0), 59(c 0x60, s 0x87, l 0), 104(c 0x60, s 0x87, l 0), 62(c 0x60, s 0x87, l 0), 17(c 0x60, s 0x87, l 0), 51(c 0x60, s 0x87, l 0), 13(c 0x60, s 0x87, l 0)
Kernel Free SCB list: 10 95 126 6 108 105 94 64 44 129 50 84 85 74 53 43 16 106 111 107 22 73 88 28 39 18 119 56 127 63 81 14 15 3 9 54 89 112 31 90 75 19 117 125 98 4 128 130 135 92 69 109 99 7 116 34 20 101 35 72 25 113 100 102 52 110 2 41 23 79 76 21 30 96 114 66 5 70 29 118 78 131 49 11 80 103 58 12 124 36 38 8 121 42 97 24 57 67 120 93 27 77 71 55 123 0 65 1 115 122 60 82 37 47 32 86 83 87 26 134 68 48 33 46 40 45 133 132 
DevQ(0:8:0): 0 waiting
DevQ(0:10:0): 0 waiting
(scsi0:A:8:0): Queuing a recovery SCB
scsi0:0:8:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:8:0): Abort Tag Message Sent
(scsi0:A:8:0): SCB 51 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
scsi0:0:8:0: Attempting to queue an ABORT message
scsi0:0:8:0: Command not found
aic7xxx_abort returns 0x2002
scsi0:0:8:0: Attempting to queue an ABORT message
scsi0:0:8:0: Command not found
aic7xxx_abort returns 0x2002
