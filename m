Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317330AbSFLXku>; Wed, 12 Jun 2002 19:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317336AbSFLXkt>; Wed, 12 Jun 2002 19:40:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:12237 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317330AbSFLXkf>;
	Wed, 12 Jun 2002 19:40:35 -0400
Date: Wed, 12 Jun 2002 19:48:42 -0400
From: James Drabb <JDrabb@cfl.rr.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:
Message-ID: <20020612234842.GA11613@james.cfl.rr.com>
Reply-To: JDrabb@cfl.rr.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Problem compiling linux-2.5.21
Below is the output when trying to compile kernel 2.5.21

gcc -Wp,-MD,.isapnp_proc.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include
  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=isapnp_proc
  -c -o isapnp_proc.o isapnp_proc.c
gcc -Wp,-MD,.pnpbios_core.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include
  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=pnpbios_core
  -DEXPORT_SYMTAB  -c -o pnpbios_core.o pnpbios_core.c
gcc -Wp,-MD,.pnpbios_proc.o.d -D__KERNEL__ -I/usr/src/linux-2.5.21/include
  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=pnpbios_proc
  -c -o pnpbios_proc.o pnpbios_proc.c
pnpbios_proc.c:193: parse error before `pnpbios_proc_init'
pnpbios_proc.c:194: warning: return-type defaults to `int'
pnpbios_proc.c:248: parse error before `pnpbios_proc_exit'
pnpbios_proc.c:249: warning: return-type defaults to `int'
pnpbios_proc.c:249: conflicting types for `pnpbios_proc_exit'
/usr/src/linux-2.5.21/include/linux/pnpbios.h:147: previous declaration of `pnpbios_proc_exit'
pnpbios_proc.c: In function `pnpbios_proc_exit':
pnpbios_proc.c:253: warning: `return' with no value, in function returning non-void
pnpbios_proc.c:269: warning: `return' with no value, in function returning non-void
make[2]: *** [pnpbios_proc.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.21/drivers/pnp'
make[1]: *** [_subdir_pnp] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.21/drivers'
make: *** [drivers] Error 2


root# gcc -v
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)


root# sh scripts/ver_linux
if some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux james 2.4.19-pre9 #2 Sun Jun 9 20:19:09 EDT 2002 i686 unknown
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11o
mount                  2.11o
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         ipt_state ip_conntrack iptable_filter ip_tables analog
                       joydev es1370 tulip vfat fat

root# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 801.433
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
                  pse36 mmx fxsr sse
bogomips        : 1599.07


root# cat /proc/ioports
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
0200-0207 : es1370
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0540-054f : Intel Corp. 82801AA SMBus
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
c800-c8ff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
c800-c8ff : tulip
cc00-cc3f : Ensoniq ES1370 [AudioPCI]
cc00-cc3f : es1370
dc00-dc1f : Intel Corp. 82801AA USB
dc00-dc1f : usb-uhci
ffa0-ffaf : Intel Corp. 82801AA IDE
ffa0-ffa7 : ide0
ffa8-ffaf : ide1


root# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fedffff : System RAM
00100000-00248fed : Kernel code
00248fee-002aa45f : Kernel data
0fee0000-0feeffff : ACPI Tables
0fef0000-0fefffff : ACPI Non-volatile Storage
0ff00000-0fffffff : reserved
e3b00000-e5bfffff : PCI Bus #01
e4000000-e4ffffff : nVidia Corporation Riva TnT [NV04]
e4000000-e43fffff : vesafb
e8000000-ebffffff : Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller]
edd00000-efdfffff : PCI Bus #01
ee000000-eeffffff : nVidia Corporation Riva TnT [NV04]
efdeff00-efdeffff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
efdeff00-efdeffff : tulip
eff80000-efffffff : Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller]
fff80000-ffffffff : reserved


-- 
James Drabb JR - Programmer Analyst - Orlando, FL - JDrabb@cfl.rr.com
---------------------------------------------------------------------

--+HP7ph2BbKc20aGI
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--+HP7ph2BbKc20aGI--

