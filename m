Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTLVDL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 22:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTLVDL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 22:11:29 -0500
Received: from mail2.thewrittenword.com ([67.95.107.111]:13061 "EHLO
	spuckler.il.thewrittenword.com") by vger.kernel.org with ESMTP
	id S264324AbTLVDLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 22:11:23 -0500
From: Albert Chin-A-Young <china@thewrittenword.com>
Date: Sun, 21 Dec 2003 21:11:22 -0600
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: <i386 2.4.22 OOPS running Mozilla>
Message-ID: <20031222031122.GA1994@spuckler.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: All output below is from the system after I rebooted it.

  1. i386 2.4.22 OOPS running Mozilla
  2. i386 2.4.22 OOPS running Mozilla
  3. kernel
  4. $ cat /proc/version
     Linux version 2.4.22 (china@slab) (gcc version 2.95.4 (Debian prerelease)) #1 Wed Aug 27 00:18:11 CDT 2003
  5. $ ksymoops < /tmp/a (/tmp/a contained Oops snippet from kern.log)
     ksymoops 2.4.9 on i686 2.4.22.  Options used
          -V (default)
          -k /proc/ksyms (default)
          -l /proc/modules (default)
          -o /lib/modules/2.4.22/ (default)
          -m /boot/System.map-2.4.22 (default)

     Warning: You did not tell me where to find symbol information.  I will
     assume that the log matches the kernel and modules that are running
     right now and I'll use the default options above for symbol resolution.
     If the current kernel and/or modules do not match the log, you can get
     more accurate output by telling me the kernel version and where to find
     map, modules, ksyms etc.  ksymoops -h explains the options.

     Dec 21 20:35:17 songoku kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000001d
     Dec 21 20:35:17 songoku kernel: c01b9a7a
     Dec 21 20:35:17 songoku kernel: *pde = 00000000
     Dec 21 20:35:17 songoku kernel: Oops: 0000
     Dec 21 20:35:17 songoku kernel: CPU:    0
     Dec 21 20:35:17 songoku kernel: EIP:    0010:[sock_poll+30/40]    Tainted: PF
     Dec 21 20:35:17 songoku kernel: EFLAGS: 00013286
     Dec 21 20:35:17 songoku kernel: eax: 00000001   ebx: d98cea80   ecx: 00000000   edx: d3df47d4
     Dec 21 20:35:17 songoku kernel: esi: 00000145   edi: d8f6a008   ebp: 00000001   esp: c3375f04
     Dec 21 20:35:17 songoku kernel: ds: 0018   es: 0018   ss: 0018
     Dec 21 20:35:17 songoku kernel: Process mozilla-bin (pid: 9274, stackpage=c3375000)
     Dec 21 20:35:17 songoku kernel: Stack: d98cea80 d3df47d4 00000000 d98cea80 c013ad95 d98cea80 00000000 00000000 
     Dec 21 20:35:17 songoku kernel:        00000000 404d6290 7fffffff c013ae59 00000002 d8f6a000 c3375f58 c3375f5c 
     Dec 21 20:35:17 songoku kernel:        00000002 00000000 404d6290 c3375fbc c3374000 00000000 00000000 c013b09d 
     Dec 21 20:35:17 songoku kernel: Call Trace:    [do_pollfd+73/136] [do_poll+133/220] [sys_poll+493/768] [do_softirq+90/164] [system_call+51/56]
     Dec 21 20:35:17 songoku kernel: Code: 8b 40 1c ff d0 83 c4 0c 5b c3 53 8b 5c 24 08 8b 43 08 8b 40 
     Using defaults from ksymoops -t elf32-i386 -a i386


     >>ebx; d98cea80 <_end+1961e1c8/385657a8>
     >>edx; d3df47d4 <_end+13b43f1c/385657a8>
     >>edi; d8f6a008 <_end+18cb9750/385657a8>
     >>esp; c3375f04 <_end+30c564c/385657a8>

     Code;  00000000 Before first symbol
     00000000 <_EIP>:
     Code;  00000000 Before first symbol
        0:   8b 40 1c                  mov    0x1c(%eax),%eax
     Code;  00000003 Before first symbol
        3:   ff d0                     call   *%eax
     Code;  00000005 Before first symbol
        5:   83 c4 0c                  add    $0xc,%esp
     Code;  00000008 Before first symbol
        8:   5b                        pop    %ebx
     Code;  00000009 Before first symbol
        9:   c3                        ret    
     Code;  0000000a Before first symbol
        a:   53                        push   %ebx
     Code;  0000000b Before first symbol
        b:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
     Code;  0000000f Before first symbol
        f:   8b 43 08                  mov    0x8(%ebx),%eax
     Code;  00000012 Before first symbol
       12:   8b 40 00                  mov    0x0(%eax),%eax


     1 warning issued.  Results may not be reliable.
  6. N/A
  7. N/A
7.1. $ sh scripts/ver_linux
     Gnu C                  2.95.4
     Gnu make               3.79.1
     util-linux             2.11n
     mount                  2.12
     modutils               2.4.19
     e2fsprogs              1.35-WIP
     PPP                    2.4.1
     Linux C Library        2.3.2
     Dynamic linker (ldd)   2.3.2
     Procps                 2.0.7
     Net-tools              1.60
     Console-tools          0.2.3
     Sh-utils               5.0
     Modules Loaded         vmnet vmmon snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-page-alloc snd-mpu401-uart snd-rawmidi snd-seq-device snd parport_pc lp parport msdos fat mga_vid usbmouse hid usb-uhci mousedev input 3c59x unix
7.2. $ cat /proc/cpuinfo
     processor       : 0
     vendor_id       : GenuineIntel
     cpu family      : 15
     model           : 2
     model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
     stepping        : 4
     cpu MHz         : 2009.990
     cache size      : 512 KB
     fdiv_bug        : no
     hlt_bug         : no
     f00f_bug        : no
     coma_bug        : no
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 2
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
     bogomips        : 4010.80
7.3. $ cat /proc/modules
     vmnet                  21152   3
     vmmon                  19572   0 (unused)
     snd-intel8x0           15588   0
     snd-pcm                54592   0 [snd-intel8x0]
     snd-timer              13892   0 [snd-pcm]
     snd-ac97-codec         33624   0 [snd-intel8x0]
     snd-page-alloc          5488   0 [snd-intel8x0 snd-pcm]
     snd-mpu401-uart         2816   0 [snd-intel8x0]
     snd-rawmidi            12384   0 [snd-mpu401-uart]
     snd-seq-device          3780   0 [snd-rawmidi]
     snd                    27300   0 [snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
     parport_pc             11812   1 (autoclean)
     lp                      6016   0 (autoclean)
     parport                13824   1 (autoclean) [parport_pc lp]
     msdos                   4876   0 (unused)
     fat                    29336   0 [msdos]
     mga_vid                 8384   0 (unused)
     usbmouse                1820   0 (unused)
     hid                    21252   0 (unused)
     usb-uhci               21100   0 (unused)
     mousedev                3800   1
     input                   3296   0 [usbmouse hid mousedev]
     3c59x                  25104   1
     unix                   13864 135 (autoclean)
7.4. $ cat /proc/ioports
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
     0378-037a : parport0
     03c0-03df : vga+
     03f6-03f6 : ide0
     03f8-03ff : serial(set)
     0500-051f : Intel Corp. 82801DB/DBM SMBus Controller
     0cf8-0cff : PCI conf1
     c000-c07f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
       c000-c07f : 02:01.0
     d000-d01f : Intel Corp. 82801DB USB (Hub #2)
       d000-d01f : usb-uhci
     d400-d41f : Intel Corp. 82801DB USB (Hub #3)
       d400-d41f : usb-uhci
     d800-d81f : Intel Corp. 82801DB USB (Hub #1)
       d800-d81f : usb-uhci
     e000-e0ff : Intel Corp. 82801DB AC'97 Audio Controller
     e400-e43f : Intel Corp. 82801DB AC'97 Audio Controller
     f000-f00f : Intel Corp. 82801DB Ultra ATA Storage Controller
       f000-f007 : ide0
       f008-f00f : ide1

     $ cat /proc/iomem
     00000000-0009ffff : System RAM
     000a0000-000bffff : Video RAM area
     000c0000-000c7fff : Video ROM
     000f0000-000fffff : System ROM
     00100000-3ffeffff : System RAM
       00100000-001f9f81 : Kernel code
       001f9f82-0024415f : Kernel data
     3fff0000-3fff2fff : ACPI Non-volatile Storage
     3fff3000-3fffffff : ACPI Tables
     40000000-400003ff : Intel Corp. 82801DB Ultra ATA Storage Controller
     e0000000-e3ffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
     e4000000-e5ffffff : PCI Bus #01
       e4000000-e5ffffff : Matrox Graphics, Inc. MGA G550 AGP
     e6000000-e8ffffff : PCI Bus #01
       e6000000-e6003fff : Matrox Graphics, Inc. MGA G550 AGP
       e7000000-e77fffff : Matrox Graphics, Inc. MGA G550 AGP
     ea000000-ea00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
     eb000000-eb0003ff : Intel Corp. 82801DB USB2
     eb001000-eb0011ff : Intel Corp. 82801DB AC'97 Audio Controller
       eb001000-eb0011ff : Intel 82801DB-ICH4 - AC'97
     eb002000-eb0020ff : Intel Corp. 82801DB AC'97 Audio Controller
       eb002000-eb0020ff : Intel 82801DB-ICH4 - Controller
     fec00000-fec00fff : reserved
     fee00000-fee00fff : reserved
     ffb00000-ffffffff : reserved

-- 
albert chin (china@thewrittenword.com)
