Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275583AbRJBQpj>; Tue, 2 Oct 2001 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275641AbRJBQp3>; Tue, 2 Oct 2001 12:45:29 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:53912 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP
	id <S275583AbRJBQpT>; Tue, 2 Oct 2001 12:45:19 -0400
Date: Tue, 2 Oct 2001 18:45:45 +0200 (MEST)
From: Lars Christensen <larsch@cs.auc.dk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.10 hangs on console switch
Message-ID: <Pine.GSO.4.33.0110021836001.15489-100000@peta.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Problem: Kernel 2.4.10 hangs when console is switched from X to text mode,
either using C-A-Fn or when shutting down or reboot from X (with a black
screen). 2.4.9 does not have this problem.

There is nothing about the hang in the log files. Kernel is configured for
Athlon/K7 processor.

# scripts/ver_linux

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.31
util-linux             2.11h
mount                  2.11h
modutils               2.4.9
e2fsprogs              tune2fs
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1333.391
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2660.76

# cat /proc/ioports
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
a000-a0ff : Realtek Semiconductor Co., Ltd. RTL-8139
  a000-a0ff : 8139too
a400-a4ff : C-Media Electronics Inc CM8738
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e000-e003 : Advanced Micro Devices [AMD] AMD-760 [Irongate] System
Controller
e300-e37f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
  00100000-00200293 : Kernel code
  00200294-0025507f : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
dd800000-dd8000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  dd800000-dd8000ff : 8139too
de000000-dfdfffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV11
dff00000-ef7fffff : PCI Bus #01
  e0000000-e7ffffff : nVidia Corporation NV11
ef800000-ef800fff : Advanced Micro Devices [AMD] AMD-760 [Irongate] System
Controller
f0000000-f7ffffff : Advanced Micro Devices [AMD] AMD-760 [Irongate] System
Controller
ffff0000-ffffffff : reserved



-- 
Lars Christensen, larsch@cs.auc.dk

