Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281815AbRKWI57>; Fri, 23 Nov 2001 03:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281814AbRKWI5v>; Fri, 23 Nov 2001 03:57:51 -0500
Received: from mailin7.bigpond.com ([139.134.6.95]:23291 "EHLO
	mailin7.bigpond.com") by vger.kernel.org with ESMTP
	id <S281815AbRKWI5j>; Fri, 23 Nov 2001 03:57:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: hari <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: Heavy disk IO stalls ftp/http downloads
Date: Fri, 23 Nov 2001 20:00:45 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011123085746Z281815-17409+14824@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I am downloading files from the internet (using ftp command, Konqueror, 
gftp etc. on 56K modem), heavy disk activity stalls the download. Stopping 
the disk activity makes it to resume the download in normal speed.

For eg, when I tried downloading patch-2.4.15-final.bz2, the moment I 
started copying a big (154 MB) directory (cp /usr/src/linux-2.4.14  
/usr/src/linux-2.4.15-final) it stalled the download. When I terminated the 
'cp' command, it resumed the download.

The output of 'vmstat 3' during the download/heavy disk activity (sampled at 
5 sec):
   procs                      memory    swap          io     system         
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  
id
 1  0  0  19576  98136 160928 150928   0   0     8    10  134   169   1   0  
99
 1  1  0  19576  78384 161012 170432   0   0  1672    28 1224   984   4  11  
85
 2  0  0  19576  60920 162880 185972   0   0  1151   761  993   803   2  10  
87
 2  0  0  19576  40984 164708 203952   0   0  1264   678  949  1362   5  12  
83
 1  1  0  19576  20580 167484 223656   0   0  1670  1089  652  1655   8  11  
81
 0  1  1  19576   3192 169800 238676   0   0  1668  1246  611   900   2   9  
89
 1  0  0  19888   3240 166100 245040   0  25  1975   794  550   798   2   8  
90
 0  1  2  20512   4116 156732 253568  40  17  2478   238  710  1493  10  10  
79
 0  1  1  20512   4360 156740 253316   0   0     6  3021  419   235   2   1  
96
 0  1  1  20508   4340 149260 260836   0   0  1839     0  470   743   2   6  
92
 1  0  0  20508   4380 147628 262416   0   0   350  2914  397   333   1   4  
95
 0  1  1  20508   3968 142580 267844   0   0  1590   954  437   672   2   8  
90
 1  1  1  20508   3908 142580 267896   0   0     5  3272  437   228   2   1  
97
 1  0  0  20508   3932 141744 268704   0   0   251  2717  538   904   5   4  
91
 0  1  0  20508   3540 131200 279608   0   0  2500   759  560  1195   5  10  
85
 1  0  2  21528   3384 123552 289588   0 256  1611   489  494  1088   6   8  
86
 2  0  0  21528   4364 119564 292792   0   0   810  2149  423   379   0   3  
97
 0  1  1  21528   3840 119612 293232   0   0  1102  1862  434   483   0   7  
92
 0  1  0  21528   3824 117780 294932   0   0  1344   605  369   494   0   7  
92
 0  1  0  21528   3300 120700 290288   0   0   715  1248  329   469   0  11  
88
 0  1  1  21528   3264 125484 285044   0   0   395  4004  412   294   0   3  
97
 0  0  0  21528   4364 124300 285168   0   0   487   982  333   360   1   8  
91
 0  0  1  21528   3344 127544 282992   0   0     0  2650  303   279   2   2  
97

Hardware configuration:
AMD Athlon 1200MHz on MSI-6341 Board
512 MB RAM
2 * 10 GB IDE Hard drives (on software RAID0, enabled DMA on both drives)
External 56K Modem on serial port

Software configuration:
Linux pengu 2.4.15-pre9 #3 Thu Nov 22 19:33:35 GMT 2001 i686 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.11b
mount                  2.11b
modutils               2.4.1
e2fsprogs              1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1382179 Jan 19  2001 
/lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         iptable_filter ip_tables ppp_async ppp_generic slhc 
serial emu10k1 ac97_codec soundcore ext2

Can someone please help me by letting me know where the problem could be? My 
apologies if this is a known problem of some kind and there are some 
workarounds.

Please cc me if you can, else I will read lkml achieves at 
marc.theaimsgroup.com.

Thanks in advance.
-- 
Hari.
harisri@bigpond.com
