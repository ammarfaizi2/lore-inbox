Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268284AbRGWQLG>; Mon, 23 Jul 2001 12:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268285AbRGWQK4>; Mon, 23 Jul 2001 12:10:56 -0400
Received: from kawoserv.kawo2.RWTH-Aachen.DE ([134.130.180.1]:19209 "EHLO
	kawoserv.kawo2.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S268284AbRGWQKp>; Mon, 23 Jul 2001 12:10:45 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jochen Siebert <siebert@kawo2.rwth-aachen.de>
Reply-To: siebert@physik.rwth-aachen.de
Organization: RWTH Aachen
Date: Mon, 23 Jul 2001 18:10:34 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072317440600.01317@siebert.kawo2.rwth-aachen.de>
Content-Transfer-Encoding: 8bit
Subject: PROBLEM: copying/creating large (>500MB) files results in sluggish behaviour.
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,                     (look at the end of email for data) 

I´ve got a problem with my linux 2.4.7 box. If I download a 
large (>500MB) file from a computer connected via 100Mbit 
LAN (i.e. with more than 2MB/s) *or* I create such a large 
file via the "dd" command (dd if=/dev/zero of=sloow)
after some time my computer gets very sluggy and reacts
veery sloow. I´ve watched the memory usage while creating 
such a big file and noticed that all memory gets filled up, 
and even swapping starts, *before* the disk starts to write 
the file. Ok, so swapping and file writing at once seems to
be not such a good idea of the kernel, even if the IBM 
IC35L040 IDE disk is a fast one. Feel free to ask my via 
email.

Adies,
Jochen

ps: plz cc me.

Now the facts:
=============================
ver_linux:
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.3
e2fsprogs              1.19
reiserfsprogs          3.x.0i
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         serial parport_pc lp parport mga 
agpgart es1371 ac97_codec 3c59x nls_iso8859-1 nls_cp850 
vfat fat
===============================
kernel 2.4.7,
ASUS A7V board,
MemTotal:       384880 kB +128MB Swap,
reiserfs
====================
cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 908.119
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep 
mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 
3dnowext 3dnow
bogomips        : 1808.79
====================
modules:
serial                 43472   0 (autoclean)
parport_pc             23632   1 (autoclean)
lp                      5520   0 (autoclean)
parport                26144   1 (autoclean) [parport_pc lp]
mga                    91312   1
agpgart                13024   3
es1371                 25872   0
ac97_codec              8464   0 [es1371]
3c59x                  25088   1 (autoclean)
nls_iso8859-1           2864   2 (autoclean)
nls_cp850               3616   2 (autoclean)
vfat                    9328   2 (autoclean)
fat                    31776   0 (autoclean) [vfat]
====================
UDMA 100 controller: 
cat /proc/ide/pdc202xx
 
                                PDC20265 Chipset.
------------------------------- General Status 
---------------------------------Burst Mode                 
          : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 8
Interrupt Check Status Polling Delay : 2
--------------- Primary Channel ---------------- Secondary 
Channel -------------                enabled                
          enabled
66 Clocking     enabled                          disabled
           Mode PCI                         Mode PCI
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 
---------- drive1 ------DMA enabled:    yes              no 
             no                no
DMA Mode:       UDMA 4           NOTSET          NOTSET     
       NOTSET
PIO Mode:       PIO 4            NOTSET           NOTSET    
        NOTSET
========================================

   
-- 
__________________________________________________________
jochen siebert  fon +49/241/89449581 mobil +49/178/5400301
siebert@physik.rwth-aachen.de                 icq #6257096
browse  to   http://www.pgp.net  to  get my public pgp key
fprint: BAD0 5B0D E645 BF63 D2E9  8BCD 9516 BAB5 D67E 6F2B
