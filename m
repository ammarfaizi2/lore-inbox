Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289125AbSAJCPG>; Wed, 9 Jan 2002 21:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289124AbSAJCO6>; Wed, 9 Jan 2002 21:14:58 -0500
Received: from [202.99.6.10] ([202.99.6.10]:57472 "EHLO mail.zhengmai.com.cn")
	by vger.kernel.org with ESMTP id <S289120AbSAJCOo>;
	Wed, 9 Jan 2002 21:14:44 -0500
Message-ID: <003b01c1997c$4a86fec0$d20101c0@T21laser>
From: "Weiping He" <laser@zhengmai.com.cn>
To: "Oleg Drokin" <green@namesys.com>
Cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
In-Reply-To: <005401c18dc6$f3e3fb10$d20101c0@T21laser> <20011226094209.B871@namesys.com>
Subject: Re: anybody know about "journal-615" and/or "journal-601" log error?(may be SCSI problem?)
Date: Thu, 10 Jan 2002 10:11:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id NAA15139

Hi,

I've experienced another crash this morning.
I'v recorded the message displayed on the screen:

-------------------------------------8<------------------------------------------------
journal-601, buffer write failed
invalid operand: 0000
CPU:0
EIP: 0010:[<c018a7f9>] Not tainted
EFLAGS: 00010286
eax: 00000024    ebx: c028e020    ecx: da39c000    edx: 00000001
esi: dc615400    edi: dc615400    ebp: c1835e58    esp: c1835e58
ds: 0018    es: 0018    ss: 0018
Process Kupdated (pid: 7,    stackpage = c1835000)
stack:    c0286660    c0329d60    c028e020 c1835e3c 00000000 e0c3b504 c019985b dc615400
            c029e020    00001268    dc615400 e0c3a094 c1835f74 00000005 00000006 00000000
            ca2a31e0    c019d074    dc615400  c0c3b504 00000001 c1835fa0 dc615400 c1834560

CallTrace [<c01999856>] [<c019d074>] [<c01e356f>] [<c01d7c91>] [<c01123f9>]
               [<c01186f4>] [<c01991cd>] [<c019c263>] [<c01881c9>] [<c0132cb3>] [<c01325c0>]
               [<c0132841>] [<c0105000>] [<c01054aa>] [<c01054b3>]

Code: 0f 0b 68 60 9d 32 c0 85 f6 74 10 0f b7 46 08 50 e8 ea 4f fa
 scsi0:0:8:0: Attempting to queue an ABORT message
 scsi0: Dumping Card State while idle, at SEQADDR 0x8
 ACCUM = 0x0, SINDEX = 0x27, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa,
DFCNTRL=0x0, DFSTATUS = 0x89
LASTPHASE=0x1, SCSISIGI=0x0, SXFRCTL0=0x80
SSTAT0=0x0, SSTAT1=0x8
SCSIPHASE=0x0
STACK==0x3, 0x108, 0x160, 0x0
SCB Count = 116
Kernel NEXTQSCB=36
Card NEXTQSCB=36
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries: 18:28
QOUTFIFO entries:
Sequencer Free SCB List: 12 21 30 15 19 3 27 6 7 23 26 14 2 13 8 9 22 24 5 20 31
    28 0 11 1 4 25 16 17 29 10

Pending list: 28

Kernel Free SCB list: 39 26 4 22 56 19 0 44 45 21 31 62 2 30 26 7 41 13 20 32
 61 52 6 47 48 12 55 42 54 1 34 37 11 15 25 46 27 38 67 18 23 5 50 58 63 16 57 3
 17 9 59 43 112 60 14 49 10 53 24 8 35 33 40 113 114 115 108 109 110 111 104 105
 106 107 100 101 102 103 96 97 98 99 92 93 94 95 88 89 90 91 84 85 86 87 80 81 82
 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66

DevQ(0:4:0): 0 waiting
DevQ(0:6:0): 0 waiting
DevQ(0:8:0): 0 waiting
(scsi0:A:8:0): Queuing a recovery SCB
scsi0:0:8:0: Device is disconnected, re_queuing SCB
Recovery code sleeping
(scsi0:A:8:0): Abort Tag Message Sent
(scsi0:A:8:0): SCB 28 - Abort Tag Completed.
Recovery SCB completes
Recovery Code asake
aic7xxx_abort returns 0x2002.
-------------------------------------------------------8<---------------------------------------------- 

it's recorded by hand, so may be some typo there, but I think it should reflact something happended there.
It seems there are something related to my SCSI card or driver got problem, but I'm not sure whether
it's a hardware problem (my scsi card got problem) or something wrong in driver (or my config of that
driver)?

and in the syslog still just got "journal-601" report, but I think it's reasonable, 
because when the kernel wants to write some log, the hardware just don't act accordingly.
Any thoughts?

    thanks and regards    laser

ý:.žË›±Êâmçë¢kaŠÉb²ßìzwm…ébïîžË›±Êâmébžìÿ‘êçz_âžØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Þ—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨þ)ß£ømšSåy«­æ¶…­†ÛiÿÿðÃí»è®å’i
