Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131203AbRACWY2>; Wed, 3 Jan 2001 17:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbRACWX6>; Wed, 3 Jan 2001 17:23:58 -0500
Received: from hall.mail.mindspring.net ([207.69.200.60]:57860 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131549AbRACWXt>; Wed, 3 Jan 2001 17:23:49 -0500
Date: Wed, 3 Jan 2001 17:23:34 -0500 (EST)
From: Jon Eisenstein <jon@dominia.dyn.dhs.org>
Reply-To: jeisen@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: System crash killing idle task
Message-ID: <Pine.LNX.4.21.0101031704010.254-100000@dominia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] System crash killing idle task

[2.] I returned home after 8 hours of disuse to find the system crashed
with various jibberish on the screen. As I could get no response, I could
not copy all of the information I saw, but wrote down the final lines
after the screenfull of jibberish:

Code: 89 10 b8 01 00 00 00 c7 43 04 00 00 00 00 c7 03 00 00 00 00
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
Interrupt killer - not syncing


[3.] kernel crash killing idle task

[4.] Linux version 2.4.0-test12 (root@dominia) (gcc version 2.95.3
20001229 (prerelease)) #2 Mon Jan 1 13:43:25 EST 2001

[5.] I did not see an oops message. I have logged the output of ksymoops
anyway, so if you need this information please notify me.

[6.] No sequence of events identified


[7.1.] 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux dominia 2.4.0-test12 #2 Mon Jan 1 13:43:25 EST 2001 i586 unknown
Kernel modules         2.3.23
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_async ppp_generic slhc rtc

[7.2.] 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 5
cpu MHz         : 120.275
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 240.03

[7.3.]
ppp_async               6320   1 (autoclean)
ppp_generic            12928   3 (autoclean) [ppp_async]
slhc                    4720   1 (autoclean) [ppp_generic]
rtc                     5408   0 (autoclean)

[7.4.]
(/proc/iomem)
00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-02ffffff : System RAM
  00100000-00209e1f : Kernel code
  00209e20-0021b003 : Kernel data
f0000000-f01fffff : Trident Microsystems TGUI 9440
f0200000-f020ffff : Trident Microsystems TGUI 9440
ffff0000-ffffffff : reserved

(/proc/ioports)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
3000-300f : Intel Corporation 82371FB PIIX IDE [Triton I]
  3000-3007 : ide0
  3008-300f : ide1

[7.5.]
lspci command not found, here is output of 'scanpci -vvv'

pci bus 0x0 cardnum 0x00 function 0x0000: vendor 0x8086 device 0x122d
 Intel 82437 Triton
  STATUS    0x2200  COMMAND 0x0006
  CLASS     0x06 0x00 0x00  REVISION 0x01
  HEADER    0x00  LATENCY 0x20

pci bus 0x0 cardnum 0x07 function 0x0000: vendor 0x8086 device 0x122e
 Intel 82471 Triton
  STATUS    0x0280  COMMAND 0x000f
  CLASS     0x06 0x01 0x00  REVISION 0x02
  HEADER    0x80  LATENCY 0x00

pci bus 0x0 cardnum 0x07 function 0x0001: vendor 0x8086 device 0x1230
 Intel 82371 bus-master IDE controller
  STATUS    0x0280  COMMAND 0x0005
  CLASS     0x01 0x01 0x80  REVISION 0x02
  BIST      0x00  HEADER 0x00  LATENCY 0x20  CACHE 0x00
  BASE4     0x00003001  addr 0x00003000  I/O
  BYTE_0    0x8000a377  BYTE_1  0x00  BYTE_2  0x806aee0  BYTE_3 0xffffffff

pci bus 0x0 cardnum 0x09 function 0x0000: vendor 0x1023 device 0x9440
 Trident TGUI 9440
  STATUS    0x0200  COMMAND 0x0003
  CLASS     0x03 0x00 0x00  REVISION 0xe3
  BASE0     0xf0000000  addr 0xf0000000  MEM
  BASE1     0xf0200000  addr 0xf0200000  MEM
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x01  INT_LINE 0x0c


[7.6.] No SCSI in system

[7.7.] I am unaware of any further information to look for.



As you can see by the kernel information, I have compiled this kernel only
a few days ago, but have been running 2.2.4-test12 for a little while
longer than that. I had recompiled in an attempt to get sound working
properly. This is the first time I have seen anything of this magnitude
happen.

Thank you,
Jon Eisenstein

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
