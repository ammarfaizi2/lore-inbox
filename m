Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbRDHIxU>; Sun, 8 Apr 2001 04:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132527AbRDHIxL>; Sun, 8 Apr 2001 04:53:11 -0400
Received: from www7.networkshosting.com ([209.12.212.210]:51680 "HELO
	www7.networkshosting.com") by vger.kernel.org with SMTP
	id <S132521AbRDHIw7>; Sun, 8 Apr 2001 04:52:59 -0400
Message-ID: <3ACFA8DB.A0A21AB7@boosthardware.com>
Date: Sun, 08 Apr 2001 08:55:07 +0900
From: Patrick Shirkey <pshirkey@boosthardware.com>
Organization: Boost Hardware
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: ko, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible bug for Kernel 2.4.3 -> make modules_install
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having trouble installing modules. The command hangs at the
following point in the install...

-------------------
  Finished dependencies of target file `_modinst_post'.
  Must remake target `_modinst_post'.
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.3; fi
Putting child 0x08088a88 PID 01056 on the chain.
Live child 0x08088a88 PID 1056
/sbin/depmod: invalid option -- F
Usage: depmod [-e -s -v ] -a [FORCED_KERNEL_VER]
       depmod [-e -s -v ] MODULE_1.o MODULE_2.o ...
Create module-dependency information for modprobe.
 
  -a, --all                  visit all modules
  -d, --debug                run in debug mode
  -e                         output unresolved symbols
  -i                         ignore symbol versions
  -m, --system-map <file>    use the symbols in <file>
  -s, --system-log           use the system log for error reporting
      --help                 display this help and exit
  -v, --verbose              run in verbose mode
  -V, --version              output version information and exit
Got a SIGCHLD; 1 unreaped children.
Reaping losing child 0x08088a88 PID 1056
make: *** [_modinst_post] Error 1
Removing child 0x08088a88 PID 1056 from chain.
-----------

Can anyone tell me how to fix this prob?

My system is:

Mandrake 7.0
kernel 2.4.3 nee 2.2.14-15mdk

[root@localhost linux]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 501.143
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 999.42  

[root@localhost linux]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-100f : Intel Corporation 82371AB PIIX4 IDE
  1000-1007 : ide0
  1008-100f : ide1
1010-1017 : Lucent Microelectronics 56k WinModem
1020-103f : Intel Corporation 82371AB PIIX4 USB
  1020-103f : usb-uhci
1400-14ff : ESS Technology ES1978 Maestro 2E
1800-18ff : Lucent Microelectronics 56k WinModem
1c00-1fff : PCI CardBus #02
  1c00-1cff : PCI device 10ec:8138
    1c00-1cff : 8139too
2180-219f : Intel Corporation 82371AB PIIX4 ACPI
2400-2fff : PCI CardBus #06
8000-803f : Intel Corporation 82371AB PIIX4 ACPI
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc 3D Rage LT Pro AGP-133
[root@localhost linux]#         

[root@localhost linux]# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001fb27b : Kernel code
  001fb27c-0027f8bf : Kernel data
10000000-10000fff : Texas Instruments PCI1251B
10001000-10001fff : Texas Instruments PCI1251B (#2)
10800000-10bfffff : PCI CardBus #02
  10800000-108001ff : PCI device 10ec:8138
    10800000-108001ff : 8139too
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
60000000-60000fff : PCI CardBus #02
f4000000-f40000ff : Lucent Microelectronics 56k WinModem
f4100000-f41fffff : PCI Bus #01
  f4100000-f4100fff : ATI Technologies Inc 3D Rage LT Pro AGP-133
f5000000-f5ffffff : PCI Bus #01
  f5000000-f5ffffff : ATI Technologies Inc 3D Rage LT Pro AGP-133
f8000000-fbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
fff80000-ffffffff : reserved
[root@localhost linux]#       


Thanks.

Patrick Shirkey.

               
-- 
Boost Hardware.
Importing Korean Computer Hardware to New Zealand.

Http://www.boosthardware.com for latest stock and prices.
