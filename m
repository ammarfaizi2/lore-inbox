Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269941AbUJTMVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269941AbUJTMVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270313AbUJTLka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:40:30 -0400
Received: from [195.228.217.114] ([195.228.217.114]:65288 "EHLO
	mail.merkantil.hu") by vger.kernel.org with ESMTP id S270201AbUJTLfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:35:23 -0400
Message-ID: <41764E90.6080106@mail.merkantil.hu>
Date: Wed, 20 Oct 2004 13:40:00 +0200
From: =?ISO-8859-1?Q?B=E1nyai_Zsolt?= 
	<banyai.zsolt.gyorgy@mail.merkantil.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  scsi2: ahc_intr - referenced scb not valid during SELTO
 scb(0, 0)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had kernel problem.

I wanted to read  the backup  on SDLT from a remote machine, but it 
failed.  I gave the command mt -f / dev/st1 on the
local machine. I did not receive any answer. The status of the 'mt' 
process was: Duninterruptible sleep (usually IO).
The system produced a lot of messages to/var/log/messages,
and stopped with Kernel Panic message: beta kernel: Kernel panic: 
Waiting List traversal

/var/log/messages:

Oct 20 10:37:10 beta kernel: scsi2: ahc_intr - referenced scb not valid 
during SELTO scb(0, 0)
Oct 20 10:37:10 beta kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins 
<<<<<<<<<<<<<<<<<
Oct 20 10:37:10 beta kernel: scsi2: Dumping Card State while idle, at 
SEQADDR 0x18
Oct 20 10:37:10 beta kernel: Card was paused
Oct 20 10:37:10 beta kernel: ACCUM = 0xff, SINDEX = 0x48, DINDEX = 0xe4, 
ARG_2 = 0x3f
Oct 20 10:37:10 beta kernel: HCNT = 0x0 SCBPTR = 0x0
Oct 20 10:37:10 beta kernel: SCSIPHASE[0x0] SCSISIGI[0x0] ERROR[0x0] 
SCSIBUSL[0x0]
Oct 20 10:37:10 beta kernel: LASTPHASE[0x1] SCSISEQ[0x0] SBLKCTL[0x6] 
SCSIRATE[0x0]
Oct 20 10:37:10 beta kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] 
SSTAT1[0x0]
Oct 20 10:37:10 beta kernel: SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] 
SIMODE1[0xa4]
Oct 20 10:37:10 beta kernel: SXFRCTL0[0x80] DFCNTRL[0x0] DFSTATUS[0x89]
Oct 20 10:37:10 beta kernel: STACK: 0x0 0x16a 0x17f 0x17
Oct 20 10:37:10 beta kernel: SCB count = 6
Oct 20 10:37:10 beta kernel: Kernel NEXTQSCB = 5
Oct 20 10:37:10 beta kernel: Card NEXTQSCB = 0
Oct 20 10:37:10 beta kernel: QINFIFO entries:
Oct 20 10:37:10 beta kernel: Waiting Queue entries: 0:0
Oct 20 10:37:10 beta kernel: Disconnected Queue entries:
Oct 20 10:37:10 beta kernel: QOUTFIFO entries:
Oct 20 10:37:10 beta kernel: Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 
10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Oct 20 10:37:10 beta kernel: Sequencer SCB Info:
Oct 20 10:37:10 beta kernel:   0 SCB_CONTROL[0x0] SCB_SCSIID[0x0] 
SCB_LUN[0x0] SCB_TAG[0x0]
Oct 20 10:37:10 beta kernel:   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] 
SCB_LUN[0xff] SCB_TAG[0xff]
Oct 20 10:37:10 beta kernel:   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] 
SCB_LUN[0xff] SCB_TAG[0xff]
Oct 20 10:37:10 beta kernel:   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] 
SCB_LUN[0xff] SCB_TAG[0xff]
.
.
.
Oct 20 10:37:10 beta kernel:  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] 
SCB_LUN[0xff] SCB_TAG[0xff]
Oct 20 10:37:10 beta kernel: Pending list:
Oct 20 10:37:10 beta kernel:   4 SCB_CONTROL[0x40] SCB_SCSIID[0x57] 
SCB_LUN[0x0]
Oct 20 10:37:10 beta kernel: Kernel Free SCB list: 3 2 1 0
Oct 20 10:37:10 beta kernel: Untagged Q(5): 4
Oct 20 10:37:10 beta kernel: DevQ(0:5:0): 0 waiting
Oct 20 10:37:10 beta kernel:
Oct 20 10:37:10 beta kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends 
 >>>>>>>>>>>>>>>>>>
Oct 20 10:37:10 beta kernel: scsi2: ahc_intr - referenced scb not valid 
during SELTO scb(0, 0) 

Output of ver_linux program:

Linux beta 2.4.26 #3 SMP Tue May 11 20:37:23 CEST 2004 i686 unknown 
unknown GNU/
 
Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.28
jfsutils               1.1.1
xfsprogs               2.3.9
PPP                    2.4.1
isdn4k-utils           3.2p3
Linux C Library        x    1 root     root      1475331 Mar 13  2003 
/lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8
Modules Loaded         aic7xxx st sg e1000 

Our Operating system is Suse Linux 8.2 with i686 glibc-2.3.2-5.
Cat /proc/version:
Linux version 2.4.26 (root@beta) (gcc version 3.3 20030226 (prerelease) 
(SuSE Linux)) #3 SMP Tue May 11 20:37:23 CEST 2004

cat /proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88







processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88
 
processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88


processor       : 4
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88
 
processor       : 5
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88

processor       : 6
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88
 
processor       : 7
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) MP CPU 1.50GHz
stepping        : 2
cpu MHz         : 1493.620
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2981.88

cat /proc/modules:
aic7xxx               156336   1
st                     31256   1 (autoclean)
sg                     30300   0 (autoclean)
e1000                  69668   1


cat /proc/ioports0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
08b0-08bf : ServerWorks CSB5 IDE Controller
0cf8-0cff : PCI conf1
7c00-7cff : Adaptec AIC-7892A U160/m
acc0-acff : Intel Corp. 82540EM Gigabit Ethernet Controller
  acc0-acff : e1000
d000-dfff : PCI Bus #04
  dc00-dcff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor
e800-e8ff : ATI Technologies Inc Rage XL
ec00-ecff : Adaptec AIC-7892P U160/m:


cat /proc/iomem:

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c93ff : Extension ROM
000c9800-000cafff : Extension ROM
000f0000-000fffff : System ROM
00100000-dffdffff : System RAM
  00100000-00304ed3 : Kernel code
  00304ed4-00383c7f : Kernel data
dffe0000-dffefbff : ACPI Tables
dffefc00-dfffefff : reserved
ed200000-ed200fff : Adaptec AIC-7892A U160/m
  ed200000-ed200fff : aic7xxx
ee900000-ee91ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  ee900000-ee91ffff : e1000
ee920000-ee93ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  ee920000-ee93ffff : e1000
f0000000-f7ffffff : PCI Bus #04
  f0000000-f7ffffff : PCI Bus #05
    f0000000-f7ffffff : American Megatrends Inc. MegaRAID
      f0000000-f000007f : MegaRAID: LSI Logic Corporation
fcd00000-fcffffff : PCI Bus #04
  fcdff000-fcdfffff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI 
Processor
  fcf00000-fcffffff : PCI Bus #05
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe100000-fe100fff : ATI Technologies Inc Rage XL
fe101000-fe101fff : Adaptec AIC-7892P U160/m
  fe101000-fe101fff : aic7xxx
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

lspci -vvv: see the attached file
cat /proc/scsi/scsi: see the attached file


Best regards: Zsolt Banyai







