Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135172AbRDZGwI>; Thu, 26 Apr 2001 02:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbRDZGvt>; Thu, 26 Apr 2001 02:51:49 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:59910 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S133120AbRDZGvo>;
	Thu, 26 Apr 2001 02:51:44 -0400
Message-ID: <3AE71CE9.3A164F75@mail.utexas.edu>
Date: Thu, 26 Apr 2001 00:52:25 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac9 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Athlon-optimized 2.4.4pre7 still won't boot.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Athlon + VIA system that would never boot an Athlon-optimized
2.4.3[-ac*], and just FYI, it will not boot an Athlon-optimized
2.4.4pre7 either.

It does compile without errors, and an otherwise identical i686 kernel
boots and appears to run fine.

With the Athlon kernel I get a flood of boot-time error messages that
streams off the screen, so I do not know exactly what the trigger is; it
ultimately hangs without completing the boot.

I have tried a couple of times with different compilers, and I notice
that sometimes it gets past the point of mounting the disks, and other
times it does not get that far.

The tail of the message on my most recent try is:

    Kernel panic: Aiee, killing interrupt handler!
    In interrupt handler - not syncing

The most basic poop follows.  If this is news, I'll be happy to provide
however much more detail you require.

Thanks,

Bobby Bryant
Austin, Texas


% cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1202.732
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2398.61

% cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
3).
      Master Capable.  Latency=8.
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xe000 [0xe00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 22).
      IRQ 9.
      Master Capable.  Latency=32.
      I/O at 0xe400 [0xe41f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
64).
  Bus  0, device   8, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
[Millennium] (rev 1).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4003fff].
      Prefetchable 32 bit memory at 0xd5000000 [0xd57fffff].
  Bus  0, device  12, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd70000ff].

% gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.0)
 =
% rpm -q gcc
gcc-2.96-71

(That's from a Red Hat "Rawhide" RPM of a few weeks back.)

Also, the "kgcc" hack gives the same result:

%  kgcc -v
Reading specs from
/usr/lib/gcc-lib/i386-glibc21-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)


