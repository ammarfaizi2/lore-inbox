Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276138AbRJYUKI>; Thu, 25 Oct 2001 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRJYUKA>; Thu, 25 Oct 2001 16:10:00 -0400
Received: from genesis.westend.com ([212.117.67.2]:24559 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S274055AbRJYUJw>; Thu, 25 Oct 2001 16:09:52 -0400
Date: Thu, 25 Oct 2001 22:10:22 +0200
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: Re: BUG() in asm/pci.h:142 with 2.4.13
Message-ID: <20011025221022.A4922@westend.com>
In-Reply-To: <20011025120701.C6557@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011025120701.C6557@westend.com>; from ch@westend.com on Thu, Oct 25, 2001 at 12:07:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Now it crashed again when writing the tape but after writing 1GB to it.
This time I could capture the output of the extra new-queue debugging
output that I enabled in the kernel configuration (this time 2.4.12-ac6).

For the linux-scsi guys: if you need more information please take a look
at my previous posts to linux-kernel (same subject) or contact me directly.

bye,

 -christian-

On Thu, Oct 25, 2001 at 12:07:01PM +0200, Christian Hammers wrote:
> 2.4.13 was the easiest one to reproduce: when starting the tape backup
> to a HP DDS3/DAT Streamer (C1537A) via a Adaptec SCSI Controller 
> (Adaptec 7892A in /proc/pci) on a Gigabyte GA-6VTXD Dual Motherboard with
> two PIII and 2GB of RAM it crashed immediately with the error attached
> below. The machine was under "stresstest-simulation" load at this time.

#
# console dump via minicom and serial line
#
 /USR/SBIN/CRON[10591]: (root) CMD
(/usr/local/maint/watchdog)
 kernel: scsi0:0:0:0: Attempting to queue an
ABORT message
 kernel: scsi0: Dumping Card State while idle, at
SEQADDR 0x8
 kernel: ACCUM = 0x0, SINDEX = 0x20, DINDEX =
0xe4, ARG_2 = 0x0
 kernel: HCNT = 0x0
 kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
 kernel:  DFCNTRL = 0x0, DFSTATUS = 0x89
 kernel: LASTPHASE = 0x1, SCSISIGI = 0x0,
SXFRCTL0 = 0x80
 kernel: SSTAT0 = 0x0, SSTAT1 = 0x8
 kernel: SCSIPHASE = 0x0
 kernel: STACK == 0x3, 0x108, 0x160, 0x0
 kernel: SCB count = 248
 kernel: Kernel NEXTQSCB = 62
 kernel: Card NEXTQSCB = 62
 kernel: QINFIFO entries: 
 kernel: Waiting Queue entries: 
 kernel: Disconnected Queue entries: 6:150 12:210
2:178 29:28 23:181 13:61 24:7 
 kernel: QOUTFIFO entries: 
 kernel: Sequencer Free SCB List: 22 26 9 4 11 19
10 16 28 1 8 5 27 7 20 31 0 30 
25 17 21 3 14 15 18 
 kernel: Pending list: 150, 210, 178, 28, 181,
61, 7
 kernel: Kernel Free SCB list: 32 77 79 149 198
171 223 152 140 105 189 151 78 66
 199 88 6 224 138 177 67 84 194 191 23 246 215 24 160 185 225 230 93 174 49
241 110 2 20 147 170 240 33 59 
243 99 54 175 19 176 18 192 76 100 190 238 108 8 159 208 207 60 242 217 56
221 1 17 213 92 127 70 162 74 19
7 142 239 196 82 124 29 235 134 232 123 179 218 139 211 117 3 119 57 219
125 122 209 101 44 155 45 39 212 1
28 233 202 158 91 187 46 0 180 182 201 109 118 228 131 12 4 112 229 200 236
173 132 247 97 186 148 55 216 1
33 144 113 231 30 63 37 137 206 156 83 146 135 141 161 64 165 98 35 234 166
81 9 10 214 43 58 111 71 115 10
6 85 183 72 11 204 172 157 130 47 154 188 226 90 220 96 107 27 227 145 40
87 22 94 129 48 205 65 120 73 163
 69 26 41 86 103 68 169 53 5 237 167 42 51 195 15 38 80 13 168 21 89 52 16
114 50 193 36 136 75 25 34 95 14
 153 203 126 222 116 31 143 104 164 121 102 184 245 244 
 kernel: DevQ(0:0:0): 0 waiting
 kernel: DevQ(0:2:0): 0 waiting
 kernel: (scsi0:A:0:0): Queuing a recovery SCB
 kernel: scsi0:0:0:0: Device is disconnected,
re-queuing SCB
 kernel: Recovery code sleeping
 kernel: (scsi0:A:0:0): Abort Tag Message Sent
 kernel: (scsi0:A:0:0): SCB 7 - Abort Tag
Completed.
 kernel: Recovery SCB completes
 kernel: Recovery code awake
 kernel: aic7xxx_abort returns 0x2002
 sendmail[349]: rejecting connections on daemon
MTA: load average: 83
<80>xüxÀ<80>xÀ<80>x<ð<80>xx<xþ<80><80><80>øx<øxÀ<80>xü<80>x<ðøxüøxÀøx<80><80><80><80><80>xÀøø<80><80><80>


-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

