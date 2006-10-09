Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWJIXaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWJIXaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 19:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWJIXaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 19:30:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:48290 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964827AbWJIXa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 19:30:28 -0400
Subject: ext3 fsx failures on 2.6.19-rc1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org, esandeen@redhat.com, Jan Kara <jack@ucw.cz>
Cc: ext4 <linux-ext4@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 16:30:05 -0700
Message-Id: <1160436605.17103.27.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I am having fsx failures on 2.6.19-rc1.

I don't have any useful information at this time to track it down.
I am running 4 copies of fsx (+ fsstress) on a 1k filesystem and
one copy of fsx dies.

FYI.

Thanks,
Badari


fsx-linux[20667]: segfault at 00000000ffffffff rip 00002af0fe031690 rsp
00007fffacc03b88 error 4

READ BAD DATA: offset = 0xa352, size = 0x5fef
OFFSET  GOOD    BAD     RANGE
0x df90 0x48e4  0x0000  0x   70
operation# (mod 256) for the bad data unknown, check HOLE and EXTEND ops
LOG DUMP (71764 total operations):
71765(85 mod 256): TRUNCATE DOWN        from 0x2464c to 0x362a
******WWWW
71766(86 mod 256): READ 0x1b16 thru 0x3629      (0x1b14 bytes)
71767(87 mod 256): MAPWRITE 0x3ca1b thru 0x3ffff      (0x35e5 bytes)
71768(88 mod 256): MAPREAD      0x20f08 thru 0x2d401  (0xc4fa bytes)
71769(89 mod 256): MAPREAD      0x84d5 thru 0x16a99   (0xe5c5 bytes)
***RRRR***
71770(90 mod 256): WRITE        0x22dfb thru 0x26da3  (0x3fa9 bytes)
71771(91 mod 256): WRITE        0x11326 thru 0x19589  (0x8264 bytes)
71772(92 mod 256): READ 0x8db3 thru 0xc813      (0x3a61 bytes)
71773(93 mod 256): WRITE        0x33aff thru 0x3a725  (0x6c27 bytes)
71774(94 mod 256): TRUNCATE DOWN        from 0x40000 to 0x25e02
71775(95 mod 256): MAPWRITE 0x7f4 thru 0xffc0   (0xf7cd bytes)
******WWWW
71776(96 mod 256): WRITE        0xcfa8 thru 0xdba9    (0xc02 bytes)
71777(97 mod 256): READ 0x233e9 thru 0x25e01    (0x2a19 bytes)
71778(98 mod 256): TRUNCATE DOWN        from 0x25e02 to 0x1ea56
71779(99 mod 256): MAPWRITE 0x2b905 thru 0x3aaba      (0xf1b6 bytes)
71780(100 mod 256): READ        0x32e45 thru 0x3aaba  (0x7c76 bytes)
71781(101 mod 256): READ        0x229ae thru 0x31eaf  (0xf502 bytes)
71782(102 mod 256): TRUNCATE UP from 0x3aabb to 0x3b640
71783(103 mod 256): MAPREAD     0x2d2f4 thru 0x32a6d  (0x577a bytes)
71784(104 mod 256): MAPWRITE 0x38d96 thru 0x3c980     (0x3beb bytes)
71785(105 mod 256): WRITE       0x964d thru 0x9a7e    (0x432 bytes)
71786(106 mod 256): TRUNCATE DOWN       from 0x3c981 to 0x2de7
******WWWW
71787(107 mod 256): WRITE       0x5134 thru 0x81e4    (0x30b1 bytes)
HOLE
71788(108 mod 256): MAPWRITE 0xb02f thru 0x15d39      (0xad0b bytes)
******WWWW
71789(109 mod 256): MAPWRITE 0x22da2 thru 0x2c461     (0x96c0 bytes)
71790(110 mod 256): MAPREAD     0xe52e thru 0x10d99   (0x286c bytes)
71791(111 mod 256): MAPREAD     0x801e thru 0x14492   (0xc475 bytes)
***RRRR***
71792(112 mod 256): MAPWRITE 0x222e5 thru 0x2760f     (0x532b bytes)
71793(113 mod 256): MAPREAD     0xc9e3 thru 0xe947    (0x1f65 bytes)
***RRRR***
71794(114 mod 256): READ        0x15618 thru 0x20a3e  (0xb427 bytes)
71795(115 mod 256): READ        0x21fcf thru 0x27c2b  (0x5c5d bytes)
71796(116 mod 256): MAPREAD     0x4322 thru 0x13c95   (0xf974 bytes)
***RRRR***
71797(117 mod 256): MAPREAD     0x28ce6 thru 0x2c461  (0x377c bytes)
71798(118 mod 256): MAPWRITE 0x6467 thru 0xeef2 (0x8a8c bytes)
******WWWW
71799(119 mod 256): READ        0x140e4 thru 0x1a3f1  (0x630e bytes)
71800(120 mod 256): MAPWRITE 0x15fdf thru 0x2186b     (0xb88d bytes)
71801(121 mod 256): WRITE       0x22d1b thru 0x23bfb  (0xee1 bytes)
71802(122 mod 256): WRITE       0x3ada8 thru 0x3ffff  (0x5258 bytes)
HOLE
71803(123 mod 256): TRUNCATE DOWN       from 0x40000 to 0x2276c
71804(124 mod 256): READ        0x1d99c thru 0x2276b  (0x4dd0 bytes)
71805(125 mod 256): READ        0x8b7 thru 0x1189     (0x8d3 bytes)
71806(126 mod 256): MAPWRITE 0xe5ed thru 0x117b0      (0x31c4 bytes)
71807(127 mod 256): MAPWRITE 0x17121 thru 0x1d177     (0x6057 bytes)
71808(128 mod 256): READ        0x6033 thru 0x11909   (0xb8d7 bytes)
***RRRR***
71809(129 mod 256): WRITE       0x3196d thru 0x3e669  (0xccfd bytes)
HOLE
71810(130 mod 256): READ        0x217f thru 0x25ab    (0x42d bytes)
71811(131 mod 256): MAPWRITE 0x39b78 thru 0x3a677     (0xb00 bytes)
71812(132 mod 256): TRUNCATE DOWN       from 0x3e66a to 0x330dc
71813(133 mod 256): TRUNCATE DOWN       from 0x330dc to 0x2ca2d
71814(134 mod 256): TRUNCATE DOWN       from 0x2ca2d to 0x184d1
71815(135 mod 256): TRUNCATE UP from 0x184d1 to 0x3f897
71816(136 mod 256): MAPREAD     0x1dd98 thru 0x2aaa8  (0xcd11 bytes)
71817(137 mod 256): MAPREAD     0x3ad15 thru 0x3f39f  (0x468b bytes)
71818(138 mod 256): WRITE       0x323a6 thru 0x3b549  (0x91a4 bytes)
71819(139 mod 256): TRUNCATE DOWN       from 0x3f897 to 0x200a7
71820(140 mod 256): TRUNCATE DOWN       from 0x200a7 to 0x169f7
71821(141 mod 256): MAPWRITE 0x23ac9 thru 0x26308     (0x2840 bytes)
71822(142 mod 256): WRITE       0xc67d thru 0xcee6    (0x86a bytes)
71823(143 mod 256): READ        0x1e85f thru 0x26012  (0x77b4 bytes)
71824(144 mod 256): WRITE       0x12f5a thru 0x1c19a  (0x9241 bytes)
71825(145 mod 256): MAPWRITE 0x2ee03 thru 0x30fdb     (0x21d9 bytes)
71826(146 mod 256): READ        0x2a481 thru 0x2f630  (0x51b0 bytes)
71827(147 mod 256): READ        0x13e64 thru 0x1d7e6  (0x9983 bytes)
71828(148 mod 256): TRUNCATE DOWN       from 0x30fdc to 0x7c66
******WWWW
71829(149 mod 256): WRITE       0x9181 thru 0x1506e   (0xbeee bytes)
HOLE      ***WWWW
71830(150 mod 256): MAPWRITE 0x3a05 thru 0x6d77 (0x3373 bytes)
71831(151 mod 256): WRITE       0x32a6e thru 0x3ffff  (0xd592 bytes)
HOLE
71832(152 mod 256): MAPWRITE 0x18b71 thru 0x1a774     (0x1c04 bytes)
71833(153 mod 256): MAPREAD     0x3c3d0 thru 0x3ffff  (0x3c30 bytes)
71834(154 mod 256): WRITE       0x1e7c4 thru 0x29452  (0xac8f bytes)
71835(155 mod 256): READ        0x112be thru 0x19e8a  (0x8bcd bytes)
71836(156 mod 256): WRITE       0x1f61c thru 0x2674d  (0x7132 bytes)
71837(157 mod 256): READ        0x31b3b thru 0x3d434  (0xb8fa bytes)
71838(158 mod 256): MAPWRITE 0x1625c thru 0x19f8f     (0x3d34 bytes)
71839(159 mod 256): WRITE       0x3362 thru 0xb304    (0x7fa3 bytes)
71840(160 mod 256): TRUNCATE DOWN       from 0x40000 to 0x189e
******WWWW
71841(161 mod 256): READ        0x2bb thru 0x189d     (0x15e3 bytes)
71842(162 mod 256): MAPWRITE 0xe5ec thru 0x12354      (0x3d69 bytes)
71843(163 mod 256): READ        0xecba thru 0x12354   (0x369b bytes)
71844(164 mod 256): MAPREAD     0x8984 thru 0x97d2    (0xe4f bytes)
71845(165 mod 256): MAPWRITE 0x13e89 thru 0x216df     (0xd857 bytes)
71846(166 mod 256): MAPWRITE 0x3b3ff thru 0x3e81b     (0x341d bytes)
71847(167 mod 256): MAPWRITE 0x16150 thru 0x1bb35     (0x59e6 bytes)
71848(168 mod 256): READ        0x19b71 thru 0x28ca1  (0xf131 bytes)
71849(169 mod 256): TRUNCATE DOWN       from 0x3e81c to 0x13856
71850(170 mod 256): READ        0x950e thru 0x1334c   (0x9e3f bytes)
***RRRR***
71851(171 mod 256): TRUNCATE DOWN       from 0x13856 to 0x614a
******WWWW
71852(172 mod 256): MAPWRITE 0x2a051 thru 0x3886f     (0xe81f bytes)
71853(173 mod 256): MAPWRITE 0x2c016 thru 0x3049e     (0x4489 bytes)
71854(174 mod 256): TRUNCATE DOWN       from 0x38870 to 0x29d63
71855(175 mod 256): WRITE       0x13c2e thru 0x1b1fc  (0x75cf bytes)
71856(176 mod 256): MAPWRITE 0x28633 thru 0x31ddd     (0x97ab bytes)
71857(177 mod 256): MAPWRITE 0x3d317 thru 0x3ffff     (0x2ce9 bytes)
71858(178 mod 256): MAPREAD     0x1e0fb thru 0x261da  (0x80e0 bytes)
71859(179 mod 256): MAPREAD     0x274a9 thru 0x2aae6  (0x363e bytes)
71860(180 mod 256): WRITE       0x34465 thru 0x3e89b  (0xa437 bytes)
71861(181 mod 256): MAPREAD     0x2caf9 thru 0x3c68d  (0xfb95 bytes)
71862(182 mod 256): MAPREAD     0x3404d thru 0x35d6f  (0x1d23 bytes)
71863(183 mod 256): MAPREAD     0x1bc0d thru 0x264ab  (0xa89f bytes)


