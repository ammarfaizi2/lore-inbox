Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132936AbRDRDle>; Tue, 17 Apr 2001 23:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132995AbRDRDlZ>; Tue, 17 Apr 2001 23:41:25 -0400
Received: from fe6.southeast.rr.com ([24.93.67.53]:27922 "EHLO
	Mail6.triad.rr.com") by vger.kernel.org with ESMTP
	id <S132936AbRDRDlL>; Tue, 17 Apr 2001 23:41:11 -0400
Message-ID: <3ADD0DB3.9020409@triad.rr.com>
Date: Tue, 17 Apr 2001 23:44:51 -0400
From: Ghadi Shayban <ghad@triad.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac9 i686; en-US; rv:0.8.1+) Gecko/20010417
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IDE performance degradation on -ac tree
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently on the -ac tree, hdparm -t has been telling me about 29MB/s,
while on the main tree even since 2.4.0 and through 2.4.4-pre4, it
tells
me about 35MB/s.  I do use a VIA chipset, but I don't recall it (686a)
was afflicted by the hardware bug.  Furthermore, I believe performance
was poor even before Alan Cox merged the VIA fixes, i.e., somewhere
   before 2.4.3-ac7.Forgive me if this has been already reported.


Linux ghadbox 2.4.3-ac9 #1 Tue Apr 17 22:51:27 EDT 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11
util-linux             2.10s
mount                  2.10s
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0j
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.59
Kbd                    command
Sh-utils               2.0.11
Modules Loaded         es1371 ac97_codec soundcore tdfx tulip reiserfs


processor
: 0
vendor_id
: AuthenticAMD
cpu family	: 6
model
	: 4
model name	: AMD Athlon(tm) Processor
stepping
: 2
cpu MHz		: 900.069
cache size	: 256 KB
fdiv_bug
: no
hlt_bug
	: no
f00f_bug
: no
coma_bug
: no
fpu
	: yes
fpu_exception
: yes
cpuid level	: 1
wp
	: yes
flags
	: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
mmx
fxsr syscall mmxext 3dnowext 3dnow
bogomips
: 1795.68


/proc/ide/hpt366:

                                  HPT370 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------DMA enabled:    yes              yes             yes
          yes
UDMA
DMA
PIO


/proc/ide/via:----------VIA BusMastering IDE
Configuration----------------
Driver Version:                     3.23
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xa000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:      120ns     120ns      30ns     120ns
Cmd Active:         480ns     480ns      90ns      90ns
Cmd Recovery:       480ns     480ns      30ns      30ns
Data Active:        330ns     330ns      90ns     330ns
Data Recovery:      270ns     270ns      30ns     270ns
Cycle Time:         600ns     600ns     120ns     600ns
Transfer Rate:    3.3MB/s   3.3MB/s  16.5MB/s   3.3MB/s

Ghadi Shayban


Pianist at the NC School of the Arts

