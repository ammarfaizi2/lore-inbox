Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRCHTH0>; Thu, 8 Mar 2001 14:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129456AbRCHTHQ>; Thu, 8 Mar 2001 14:07:16 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:43026 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129453AbRCHTHK>; Thu, 8 Mar 2001 14:07:10 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: kernel BUG doing sysrq-t on 2.4.2-ac14
Date: Thu, 8 Mar 2001 11:06:08 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHCEEBFEAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While testing to see if SYSRQ-T would print the entire tasklist, a kernel
bug popped up.  All I have is the tasklist up to the point where the bug
showed up.

-Vibol

-- snip --
01e03b1>] [<c01547e9>]
       [<c0124c99>] [<c01e1b4c>] [<c0109557>] [<c010002b>]
httpd     S 7FFFFFFF     0  2442    380        (NOTLB)    2446  2437
Call Trace: [<c01156e3>] [<c01fd016>] [<c01fd247>] [<c0215494>] [<c01e1126>]
[<c
01e03b1>] [<c01547e9>]
       [<c011db71>] [<c011dcbc>] [<c01e1b4c>] [<c0109557>] [<c010002b>]
httpd     S 7FFFFFFF     0  2446    380        (NOTLB)    2452  2442
Call Trace: [<c01156e3>] [<c01fd016>] [<c01fd247>] [<c0215494>] [<c01e1126>]
[<c
01e03b1>] [<c01547e9>]
       [<c0124c99>] [<c01e1b4c>] [<c0109557>] [<c010002b>]
httpd     S 7FFFFFFF     0  2452    380        (NOTLB)    2453  2446
Call Trace: [<c010ac41>] [<c01156e3>] [<c01fd016>] [<c01fd247>] [<c0215494>]
[<c
01e1126>] [<c01547e9>]
       [<c012a70e>] [<c012ac18>] [<c01e1b4c>] [<c0109557>]
httpd     S 7FFFFFFF  2420  2453    380        (NOTLB)    2456  2452
Call Trace: [<c01156e3>] [<c01fd016>] [<c01fd247>] [<c0215494>] [<c01e1126>]
[<c
01547e9>] [<c012a70e>]
       [<c012ac18>] [<c01e1b4c>] [<c0109557>] [<c010002b>]
httpd     S 7FFFFFFF     4  2456    380        (NOTLB)    2457  2453
Call Trace: [<c01156e3>] [<c01f909a>] [<c01fab4b>] [<c020ab9c>] [<c02157d6>]
[<c
01e0355>] [<c01e057e>]
       [<c013cbf6>] [<c0109557>] [<c010002b>]
httpd     R DA0EE000  1668  2457    380        (NOTLB)    2489  2456
Call Trace: [<c01133dd>] [<c0109645>]
httpd     S EEEDFF28     0  2489    380        (NOTLB)    2502  2457
Call Trace: [<c011573f>] [<c0115604>] [<c0150dce>] [<c0151172>] [<c0109557>]
[<c
010002b>]
httpd     S 7FFFFFFF     0  2502    380        (NOTLB)    2507  2489
Call Trace: [<c01156e3>] [<c01fd016>] [<c01fd247>] [<c0215494>] [<c01e1126>]
[<c
01e03b1>] [<c01547e9>]
       [<c0124c99>] [<c01e1b4c>] [<c0109557>] [<c010002b>]
httpd     S 7FFFFFFF     0  2507    380        (NOTLB)    2509  2502
Call Trace: [<c01156e3>] [<c01fd016>] [<c01fd247>] [<c0215494>] [<c01e1126>]
[<c
01f1eba>] [<c01e728e>]
       [<c011e61c>] [<c01e1b4c>] [<c0109557>] [<c010002b>]
httpd     S EA86FF28  3452  2509    380        (NOTLB)    2512  2507
Call Trace: [<c011573f>] [<c0115604>] [<c0150dce>] [<c0151172>] [<c0109557>]
[<c
010002b>]
httpd     S 7FFFFFFF     0  2512    380        (NOTLB)    2516  2509
Call Trace: [<c01156e3>] [<c01fd016>] [<c01fd247>] [<c0215494>] [<c01e1126>]
[<c
01547e9>] [<c012a70e>]
       [<c012ac18>] [<c01e1b4c>] [<c0109557>]
httpd     S 7FFFFFFF     0  2516    380        (NOTLB)    2524  2512
Call Trace: [<c01156e3>] [<c01f909a>] [<c01fab4b>] [<c0114c17>] [<c0114acc>]
[<c
02157d6>] [<c01e0355>]
       [<c01e071d>] [<c01e079b>] [<c013cd93>] [<c013NceMIf5 W>]a tch<4d>og[<
cde
01t0ec95t5ed7> L]O CK
UPh ottnp Cd PU  0 ,  reSg is7FteFFrsF:FF
F  C P  U0:    2 5 02
   E IP38: 0    <40>01 0  : [ <c 01 0(N81OTd9LB>])
 E  FL25AG3S4:  0 200510060
87C
lel aTxr: acc0e2: d1[4<20c0 1  15e6bxe:3> c] 02[d1<c42001f  d0 e16cx>:]
0[0<0c0
00104f6d2  47 e>]dx :[ 0<c00020100540094
>] es[<i:c0 1c1e1fd12806>00]    [<ecdi01: e0e38ab168>]00 0[ <  c0eb1p36:
e7f3f>b
5]6 0
     e  sp  :  e[8a<c609f1386c
1>]ds :[ 0<0c10181  d9 e7s0>: ] 00[1<8 c 01 se1s:b4 c00>]18
[<c0Pr10oc95es5s7> t] op[si<ct0e1s0.c0g02i b>(p] id:
 3h38tt7,pd  s ta c k pSag e7=Fe8FFa6FF90F0F 0)
 S0 ta 2c5k:34   c0  2238200e d    c1  f db3 (a4NO TLe8B)a6 80  00 2 5e358a6
8 2
658824
<4>C0al00l0 T00ra00c e:c 0[2d<1c0421015 6ce03>1]1 d51[<dc 0e1f8ad068106>00]
[< c0  1f  d 2 474>]01 67[<ac30c 21504090400>]00 0 [<bc0f1ffe1f1a2e64 >]c
01[<1d
c50166e0 3b0100>]00 0[00<c 0c15014709e955>7]  0
0 00  0 0   0 0[00<1c0010024 c9                00
9>]    [  <c  01e401b164c7c>]d 8 [<40c0161079a53c5 7>]00 00[<00c0001
000bf2bff>]
f ae
<h4>tt00pd0 00  0 0 1 S0 0700F0FF02FFb FF0 0 00  00 20b   25003500 0  00 31
80
 C  al l   T r(aNceO:TL B)[< c 02  22205e42d>]   25[3<c4
1Cda51lld> T] rac[e<c:0 11[<dc50616>15]6 e[3><c]0 10[<9c50517>fd] 016
>]
[C<cod01e:f d24775 >]f 8 [<cf002 15841 94>28]  00[< c0010 e110026 >0]1
[7<c5 01
e5847 e9c3>]  8[d <c07612 a0700 e>f]0
f   0 0    8 3[ <3c08 12a              f
c18co>]ns ol<4e >[sh<cut01s eu1pb 4c..>].
[< c0109557>] kernel BUG at printk.c:327!

