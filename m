Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312334AbSCVNNA>; Fri, 22 Mar 2002 08:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312336AbSCVNMy>; Fri, 22 Mar 2002 08:12:54 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:11960 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S312334AbSCVNMe>;
	Fri, 22 Mar 2002 08:12:34 -0500
Message-ID: <022501c1d1a3$3c8729d0$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre4 aic7xxx problems
Date: Fri, 22 Mar 2002 08:12:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P.S.  I had the same problems on 2.4.19-pre2-ac3
Linux yeti 2.4.19-pre4 #1 SMP Fri Mar 22 06:21:03 EST 2002 i686 unknown
Dual PIII/1Ghz
Adaptec 39160 (two of them) plus two on-board AIC-7892.
Thirteen Seagate ST1181677LCV split 6/7 across two channels on one 39160
card.
RAID5 resync going on:
md6 : active raid5 sdg1[12] sdm1[0] sdl1[11] sdk1[10] sdj1[9] sdi1[8]
sdh1[7] sdf1[5] sde1[4] sdd1[3] sdc1[2] sdb1[1]
      1950225024 blocks level 5, 128k chunk, algorithm 2 [12/11]
[UUUUUU_UUUUU]
      [>....................]  recovery =  3.6% (6538460/177293184)
finish=6456.2min speed=440K/sec

The scsi channel I'm having problems with (my next step is to put the 6/7
disk split on two different controllers rather than two channels on the same
controller):
Dual PIII/1Ghz
Host: scsi2 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 05 Lun: 00
  Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 10 Lun: 00
  Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03

Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 8
                Commands Active 0
                Command Openings 253
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 2 Lun 0 Settings
                Commands Queued 276009
                Commands Active 0
                Command Openings 42
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 183022
                Commands Active 0
                Command Openings 41
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 4 Lun 0 Settings
                Commands Queued 243444
                Commands Active 0
                Command Openings 54
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 5 Lun 0 Settings
                Commands Queued 310831
                Commands Active 0
                Command Openings 55
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 6 Lun 0 Settings
                Commands Queued 276928
                Commands Active 0
                Command Openings 50
                Max Tagged Openings 253
                Device Queue Frozen Count 0
Channel A Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Curr: 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
        Channel A Target 10 Lun 0 Settings
                Commands Queued 77845
                Commands Active 2
                Command Openings 251
                Max Tagged Openings 253
                Device Queue Frozen Count 0

syslog messages:
Mar 22 07:49:19 yeti kernel: scsi2:0:2:0: Attempting to queue an ABORT
message
Mar 22 07:49:19 yeti kernel: scsi2: Dumping Card State while idle, at
SEQADDR 0x9
Mar 22 07:49:19 yeti kernel: ACCUM = 0x0, SINDEX = 0xc8, DINDEX = 0xe4,
ARG_2 = 0x0
Mar 22 07:49:19 yeti kernel: HCNT = 0x0 SCBPTR = 0xc
Mar 22 07:49:19 yeti kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 22 07:49:19 yeti kernel:  DFCNTRL = 0x0, DFSTATUS = 0x89
Mar 22 07:49:19 yeti kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 =
0x80
Mar 22 07:49:19 yeti kernel: SSTAT0 = 0x0, SSTAT1 = 0x8
Mar 22 07:49:19 yeti kernel: SCSIPHASE = 0x0
Mar 22 07:49:19 yeti kernel: STACK == 0x3, 0x108, 0x160, 0x0
Mar 22 07:49:19 yeti kernel: SCB count = 254
Mar 22 07:49:19 yeti kernel: Kernel NEXTQSCB = 132
Mar 22 07:49:19 yeti kernel: Card NEXTQSCB = 132
Mar 22 07:49:19 yeti kernel: QINFIFO entries:
Mar 22 07:49:19 yeti kernel: Waiting Queue entries:
Mar 22 07:49:19 yeti kernel: Disconnected Queue entries:
Mar 22 07:49:19 yeti kernel: QOUTFIFO entries:
Mar 22 07:49:19 yeti kernel: Sequencer Free SCB List: 12 18 23 16 29 28 15
20 24 3 6 10 4 21 1 31 26 17 19 5 14 11 25 8 27 9 0 30 7 13 22 2
Mar 22 07:49:19 yeti kernel: Sequencer SCB Info: 0(c 0x60, s 0x57, l 0, t
0xff) 1(c 0x60, s 0xa7, l 0, t 0xff) 2(c 0x60, s 0x67, l 0, t 0xff) 3(c
0x60, s 0xa7, l 0, t 0xff) 4(c 0x60, s 0xa7, l 0, t 0xff) 5(c 0x60, s 0x67,
l 0, t 0xff) 6(c 0x60, s 0x27, l 0, t 0xff) 7(c 0x60, s 0x47, l 0, t 0xff)
8(c 0x60, s 0x27, l 0, t 0xff) 9(c 0x60, s 0x47, l 0, t 0xff) 10(c 0x60, s
0xa7, l 0, t 0xff) 11(c 0x60, s 0x57, l 0, t 0xff) 12(c 0x60, s 0xa7, l 0, t
0xff) 13(c 0x60, s 0x67, l 0, t 0xff) 14(c 0x60, s 0xa7, l 0, t 0xff) 15(c
0x60, s 0xa7, l 0, t 0xff) 16(c 0x60, s 0xa7, l 0, t 0xff) 17(c 0x60, s
0x57, l 0, t 0xff) 18(c 0x60, s 0xa7, l 0, t 0xff) 19(c 0x60, s 0x67, l 0, t
0xff) 20(c 0x60, s 0xa7, l 0, t 0xff) 21(c 0x60, s 0xa7, l 0, t 0xff) 22(c
0x60, s 0x57, l 0, t 0xff) 23(c 0x60, s 0xa7, l 0, t 0xff) 24(c 0x60, s
0xa7, l 0, t 0xff) 25(c 0x60, s 0x67, l 0, t 0xff) 26(c 0x60, s 0x47, l 0, t
0xff) 27(c 0x60, s 0x37, l 0, t 0xff) 28(c 0x60, s 0xa7, l 0, t 0xff) 29(c
0x60, s 0xa7, l 0, t 0xff) 30(c 0x60, s 0x37, l 0, t
Mar 22 07:49:19 yeti kernel: Pending list: 200(c 0x60, s 0xa7, l 0), 94(c
0x60, s 0x27, l 0), 239(c 0x60, s 0x37, l 0), 8(c 0x60, s 0x47, l 0), 79(c
0x60, s 0x57, l 0), 235(c 0x60, s 0x67, l 0), 25(c 0x60, s 0xa7, l 0), 249(c
0x60, s 0xa7, l 0), 230(c 0x60, s 0x27, l 0), 106(c 0x60, s 0x37, l 0),
222(c 0x60, s 0x47, l 0), 90(c 0x60, s 0x57, l 0), 188(c 0x60, s 0x67, l 0),
13(c 0x60, s 0x27, l 0), 169(c 0x60, s 0x37, l 0), 83(c 0x60, s 0x47, l 0),
147(c 0x60, s 0x57, l 0), 107(c 0x60, s 0x67, l 0), 36(c 0x60, s 0x27, l 0),
82(c 0x60, s 0x37, l 0), 52(c 0x60, s 0x47, l 0), 37(c 0x60, s 0x57, l 0),
224(c 0x60, s 0x67, l 0), 203(c 0x60, s 0x27, l 0), 202(c 0x60, s 0x47, l
0), 117(c 0x60, s 0x37, l 0), 199(c 0x60, s 0x57, l 0), 66(c 0x60, s 0x67, l
0), 125(c 0x60, s 0x27, l 0), 149(c 0x60, s 0x37, l 0), 78(c 0x60, s 0x47, l
0), 56(c 0x60, s 0x57, l 0), 131(c 0x60, s 0x67, l 0), 54(c 0x60, s 0x27, l
0), 218(c 0x60, s 0x37, l 0), 150(c 0x60, s 0x47, l 0), 18(c 0x60, s 0x57, l
0), 47(c 0x60, s 0x67, l 0), 63(c 0x60,
Mar 22 07:49:19 yeti kernel: Kernel Free SCB list: 243 166 74 22 252 21 110
139 104 92 38 231 100 148 4 89 219 194 205 145 61 135 220 39 2 65 11 250 72
73 80 27 232 44 9 137 19 142 121 133 5 192 253 155 251 16 126 153 185 161
246 186 130 70 168 157 134 3 114 26 170 10 228 64 152 84 136 240 183 208 58
214 164 57 236 30 112 86 35 191 69 48 81 1 244 138 62 198 42 173 96 102 123
212 216 95 184 154 223 87 233 189 115 247 176 24 53 241 111 162 55 6 234 76
226 238 99 159 7 23 98 108 49 0 93 187 195 71 175 172 190 151 28 174 197 182
211 40 109 34 207 41 88 43 129 146 105 215 156 248 59 51 141 213 201 45 32
91 77 103 17 229 144 158 204 119 221 46 245 237 101 178 193 60 120 15 127
179 116 217 163 206 50 167 180 85 97 29 227 12 165 210
Mar 22 07:49:19 yeti kernel: DevQ(0:1:0): 0 waiting
Mar 22 07:49:19 yeti kernel: DevQ(0:2:0): 0 waiting
Mar 22 07:49:19 yeti kernel: DevQ(0:3:0): 0 waiting
Mar 22 07:49:19 yeti kernel: DevQ(0:4:0): 0 waiting
Mar 22 07:49:19 yeti kernel: DevQ(0:5:0): 0 waiting
Mar 22 07:49:19 yeti kernel: DevQ(0:6:0): 0 waiting
Mar 22 07:49:19 yeti kernel: DevQ(0:10:0): 0 waiting
Mar 22 07:49:19 yeti kernel: (scsi2:A:2:0): Queuing a recovery SCB
Mar 22 07:49:19 yeti kernel: scsi2:0:2:0: Device is disconnected, re-queuing
SCB
Mar 22 07:49:19 yeti kernel: Recovery code sleeping
Mar 22 07:49:19 yeti kernel: (scsi2:A:2:0): Abort Tag Message Sent
Mar 22 07:49:19 yeti kernel: (scsi2:A:2:0): SCB 230 - Abort Tag Completed.
Mar 22 07:49:19 yeti kernel: Recovery SCB completes
Mar 22 07:49:19 yeti kernel: Recovery code awake
Mar 22 07:49:19 yeti kernel: aic7xxx_abort returns 0x2002
Mar 22 07:49:29 yeti kernel: scsi2:0:2:0: Attempting to queue an ABORT
message
Mar 22 07:49:29 yeti kernel: scsi2: Dumping Card State while idle, at
SEQADDR 0x9
Mar 22 07:49:29 yeti kernel: ACCUM = 0x0, SINDEX = 0x84, DINDEX = 0xe4,
ARG_2 = 0x0
Mar 22 07:49:29 yeti kernel: HCNT = 0x0 SCBPTR = 0xc
Mar 22 07:49:29 yeti kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Mar 22 07:49:29 yeti kernel:  DFCNTRL = 0x0, DFSTATUS = 0x89
Mar 22 07:49:29 yeti kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 =
0x80
Mar 22 07:49:29 yeti kernel: SSTAT0 = 0x0, SSTAT1 = 0x8
Mar 22 07:49:29 yeti kernel: SCSIPHASE = 0x0
Mar 22 07:49:29 yeti kernel: STACK == 0x3, 0x108, 0x160, 0xe7
Mar 22 07:49:29 yeti kernel: SCB count = 254
Mar 22 07:49:29 yeti kernel: Kernel NEXTQSCB = 230
Mar 22 07:49:29 yeti kernel: Card NEXTQSCB = 230
Mar 22 07:49:29 yeti kernel: QINFIFO entries:
Mar 22 07:49:29 yeti kernel: Waiting Queue entries:
Mar 22 07:49:29 yeti kernel: Disconnected Queue entries:
Mar 22 07:49:29 yeti kernel: QOUTFIFO entries:
Mar 22 07:49:29 yeti kernel: Sequencer Free SCB List: 12 18 23 16 29 28 15
20 24 3 6 10 4 21 1 31 26 17 19 5 14 11 25 8 27 9 0 30 7 13 22 2
Mar 22 07:49:29 yeti kernel: Sequencer SCB Info: 0(c 0x60, s 0x57, l 0, t
0xff) 1(c 0x60, s 0xa7, l 0, t 0xff) 2(c 0x60, s 0x67, l 0, t 0xff) 3(c
0x60, s 0xa7, l 0, t 0xff) 4(c 0x60, s 0xa7, l 0, t 0xff) 5(c 0x60, s 0x67,
l 0, t 0xff) 6(c 0x60, s 0x27, l 0, t 0xff) 7(c 0x60, s 0x47, l 0, t 0xff)
8(c 0x60, s 0x27, l 0, t 0xff) 9(c 0x60, s 0x47, l 0, t 0xff) 10(c 0x60, s
0xa7, l 0, t 0xff) 11(c 0x60, s 0x57, l 0, t 0xff) 12(c 0x60, s 0x27, l 0, t
0xff) 13(c 0x60, s 0x67, l 0, t 0xff) 14(c 0x60, s 0xa7, l 0, t 0xff) 15(c
0x60, s 0xa7, l 0, t 0xff) 16(c 0x60, s 0xa7, l 0, t 0xff) 17(c 0x60, s
0x57, l 0, t 0xff) 18(c 0x60, s 0xa7, l 0, t 0xff) 19(c 0x60, s 0x67, l 0, t
0xff) 20(c 0x60, s 0xa7, l 0, t 0xff) 21(c 0x60, s 0xa7, l 0, t 0xff) 22(c
0x60, s 0x57, l 0, t 0xff) 23(c 0x60, s 0xa7, l 0, t 0xff) 24(c 0x60, s
0xa7, l 0, t 0xff) 25(c 0x60, s 0x67, l 0, t 0xff) 26(c 0x60, s 0x47, l 0, t
0xff) 27(c 0x60, s 0x37, l 0, t 0xff) 28(c 0x60, s 0xa7, l 0, t 0xff) 29(c
0x60, s 0xa7, l 0, t 0xff) 30(c 0x60, s 0x37, l 0, t
Mar 22 07:49:29 yeti kernel: Pending list: 132(c 0x60, s 0x27, l 0), 200(c
0x60, s 0xa7, l 0), 94(c 0x60, s 0x27, l 0), 239(c 0x60, s 0x37, l 0), 8(c
0x60, s 0x47, l 0), 79(c 0x60, s 0x57, l 0), 235(c 0x60, s 0x67, l 0), 25(c
0x60, s 0xa7, l 0), 249(c 0x60, s 0xa7, l 0), 106(c 0x60, s 0x37, l 0),
222(c 0x60, s 0x47, l 0), 90(c 0x60, s 0x57, l 0), 188(c 0x60, s 0x67, l 0),
13(c 0x60, s 0x27, l 0), 169(c 0x60, s 0x37, l 0), 83(c 0x60, s 0x47, l 0),
147(c 0x60, s 0x57, l 0), 107(c 0x60, s 0x67, l 0), 36(c 0x60, s 0x27, l 0),
82(c 0x60, s 0x37, l 0), 52(c 0x60, s 0x47, l 0), 37(c 0x60, s 0x57, l 0),
224(c 0x60, s 0x67, l 0), 203(c 0x60, s 0x27, l 0), 202(c 0x60, s 0x47, l
0), 117(c 0x60, s 0x37, l 0), 199(c 0x60, s 0x57, l 0), 66(c 0x60, s 0x67, l
0), 125(c 0x60, s 0x27, l 0), 149(c 0x60, s 0x37, l 0), 78(c 0x60, s 0x47, l
0), 56(c 0x60, s 0x57, l 0), 131(c 0x60, s 0x67, l 0), 54(c 0x60, s 0x27, l
0), 218(c 0x60, s 0x37, l 0), 150(c 0x60, s 0x47, l 0), 18(c 0x60, s 0x57, l
0), 47(c 0x60, s 0x67, l 0), 63(c 0x60,
Mar 22 07:49:29 yeti kernel: Kernel Free SCB list: 243 166 74 22 252 21 110
139 104 92 38 231 100 148 4 89 219 194 205 145 61 135 220 39 2 65 11 250 72
73 80 27 232 44 9 137 19 142 121 133 5 192 253 155 251 16 126 153 185 161
246 186 130 70 168 157 134 3 114 26 170 10 228 64 152 84 136 240 183 208 58
214 164 57 236 30 112 86 35 191 69 48 81 1 244 138 62 198 42 173 96 102 123
212 216 95 184 154 223 87 233 189 115 247 176 24 53 241 111 162 55 6 234 76
226 238 99 159 7 23 98 108 49 0 93 187 195 71 175 172 190 151 28 174 197 182
211 40 109 34 207 41 88 43 129 146 105 215 156 248 59 51 141 213 201 45 32
91 77 103 17 229 144 158 204 119 221 46 245 237 101 178 193 60 120 15 127
179 116 217 163 206 50 167 180 85 97 29 227 12 165 210

messages:
Mar 22 07:49:19 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:19 yeti kernel:  0x27, l 0), 128(c 0x60, s 0x37, l 0), 140(c 0x
60, s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c
0x60, s 0x27, l 0), 196(c 0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0),
160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 14(c 0x60, s 0x27, l 0),
68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 143(c 0x60, s 0x27, l 0), 209(c 0x60, s 0x37, l
0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l
0), 242(c 0x60, s 0x27, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47,
l 0)
Mar 22 07:49:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:29 yeti kernel:  0x27, l 0), 128(c 0x60, s 0x37, l 0), 140(c
0x60, s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c
0x60, s 0x27, l 0), 196(c 0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0),
160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 14(c 0x60, s 0x27, l 0),
68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 143(c 0x60, s 0x27, l 0), 209(c 0x60, s 0x37, l
0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l
0), 242(c 0x60, s 0x27, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47,
l 0)
Mar 22 07:49:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:29 yeti kernel:  0x37, l 0), 140(c 0x60, s 0x47, l 0), 75(c
0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c 0x60, s 0x27, l 0), 196(c
0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 14(c 0x60, s 0x27, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
143(c 0x60, s 0x27, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 242(c 0x60, s 0x27, l
0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:49:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:39 yeti kernel:  0x27, l 0), 128(c 0x60, s 0x37, l 0), 140(c
0x60, s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c
0x60, s 0x27, l 0), 196(c 0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0),
160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 14(c 0x60, s 0x27, l 0),
68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 143(c 0x60, s 0x27, l 0), 209(c 0x60, s 0x37, l
0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l
0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:49:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:39 yeti kernel:  0x37, l 0), 140(c 0x60, s 0x47, l 0), 75(c
0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c 0x60, s 0x27, l 0), 196(c
0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 14(c 0x60, s 0x27, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
143(c 0x60, s 0x27, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:49:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:49 yeti kernel:  0x27, l 0), 128(c 0x60, s 0x37, l 0), 140(c
0x60, s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c
0x60, s 0x27, l 0), 196(c 0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0),
160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 14(c 0x60, s 0x27, l 0),
68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:49:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:49 yeti kernel:  0x37, l 0), 140(c 0x60, s 0x47, l 0), 75(c
0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c 0x60, s 0x27, l 0), 196(c
0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 14(c 0x60, s 0x27, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0),
181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:49:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:59 yeti kernel:  0x27, l 0), 128(c 0x60, s 0x37, l 0), 140(c
0x60, s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c
0x60, s 0x27, l 0), 196(c 0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0),
160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0),
225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l
0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l
0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47,
l 0)
Mar 22 07:49:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:49:59 yeti kernel:  0x37, l 0), 140(c 0x60, s 0x47, l 0), 75(c
0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 20(c 0x60, s 0x27, l 0), 196(c
0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:09 yeti kernel: 0x27, l 0), 128(c 0x60, s 0x37, l 0), 140(c
0x60, s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 196(c
0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:09 yeti kernel:  0x37, l 0), 140(c 0x60, s 0x47, l 0), 75(c
0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 196(c 0x60, s 0x37, l 0), 118(c
0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c
0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:19 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:19 yeti kernel:  0x37, l 0), 140(c 0x60, s 0x47, l 0), 75(c
0x60, s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 196(c 0x60, s 0x37, l 0), 118(c
0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c
0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:19 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:19 yeti kernel: s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c
0x60, s 0x67, l 0), 196(c 0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0),
160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0),
225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l
0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l
0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47,
l 0)
Mar 22 07:50:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:29 yeti kernel: s 0x47, l 0), 75(c 0x60, s 0x57, l 0), 33(c
0x60, s 0x67, l 0), 196(c 0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0),
160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0),
225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l
0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l
0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47,
l 0)
Mar 22 07:50:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:29 yeti kernel: s 0x57, l 0), 33(c 0x60, s 0x67, l 0), 196(c
0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:39 yeti kernel:  0x57, l 0), 33(c 0x60, s 0x67, l 0), 196(c
0x60, s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:39 yeti kernel:  0x67, l 0), 196(c 0x60, s 0x37, l 0), 118(c
0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c
0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:49 yeti kernel:  0x67, l 0), 196(c 0x60, s 0x37, l 0), 118(c
0x60, s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c
0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:49 yeti kernel:  0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c
0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0),
181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:59 yeti kernel: s 0x37, l 0), 118(c 0x60, s 0x47, l 0), 160(c
0x60, s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0),
181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:50:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:50:59 yeti kernel: s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:09 yeti kernel: s 0x47, l 0), 160(c 0x60, s 0x57, l 0), 31(c
0x60, s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:09 yeti kernel:  s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c
0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:19 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:19 yeti kernel:  s 0x57, l 0), 31(c 0x60, s 0x67, l 0), 68(c
0x60, s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0),
113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l
0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l
0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:19 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:19 yeti kernel:  s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0),
181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:29 yeti kernel: s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0),
181(c 0x60, s 0x67, l 0), 171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:29 yeti kernel: s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
171(c 0x60, s 0x37, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:39 yeti kernel:  s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
209(c 0x60, s 0x37, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0),
181(c 0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:39 yeti kernel: s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 209(c 0x60, s 0x37, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
122(c 0x60, s 0x47, l 0)
Mar 22 07:51:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:49 yeti kernel:  s 0x67, l 0), 68(c 0x60, s 0x37, l 0), 225(c
0x60, s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0),
177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0),
122(c 0x60, s 0x47, l 0)
Mar 22 07:51:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:49 yeti kernel: s 0x37, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 177(c 0x60, s 0x47, l 0), 67(c
0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:59 yeti kernel:  s 0x67, l 0), 225(c 0x60, s 0x47, l 0), 124(c
0x60, s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 177(c 0x60, s 0x47, l 0), 67(c
0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:51:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:51:59 yeti kernel:  s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c
0x60, s 0x67, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c
0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:09 yeti kernel: s 0x47, l 0), 124(c 0x60, s 0x57, l 0), 113(c
0x60, s 0x67, l 0), 177(c 0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c
0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:09 yeti kernel:  s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 177(c
0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c
0x60, s 0x47, l 0)
Mar 22 07:52:19 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:19 yeti kernel:  s 0x57, l 0), 113(c 0x60, s 0x67, l 0), 177(c
0x60, s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c
0x60, s 0x47, l 0)
Mar 22 07:52:19 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:19 yeti kernel:  s 0x67, l 0), 177(c 0x60, s 0x47, l 0), 67(c
0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:29 yeti kernel:  s 0x67, l 0), 177(c 0x60, s 0x47, l 0), 67(c
0x60, s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:29 yeti kernel:  s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c
0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:39 yeti kernel:  s 0x47, l 0), 67(c 0x60, s 0x57, l 0), 181(c
0x60, s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:39 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:39 yeti kernel: s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c
0x60, s 0x47, l 0)
Mar 22 07:52:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:49 yeti kernel: s 0x57, l 0), 181(c 0x60, s 0x67, l 0), 122(c
0x60, s 0x47, l 0)
Mar 22 07:52:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:49 yeti kernel: s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:59 yeti kernel:  s 0x67, l 0), 122(c 0x60, s 0x47, l 0)
Mar 22 07:52:59 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:52:59 yeti kernel:  s 0x47, l 0)
Mar 22 07:53:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:53:09 yeti kernel: s 0x47, l 0)
Mar 22 07:53:09 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:53:39 yeti last message repeated 6 times
Mar 22 07:53:49 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)
Mar 22 07:54:19 yeti last message repeated 7 times
Mar 22 07:54:29 yeti kernel: 0xff) 31(c 0x60, s 0x67, l 0, t 0xff)


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

