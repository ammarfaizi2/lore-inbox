Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129824AbRBRSZD>; Sun, 18 Feb 2001 13:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130025AbRBRSYy>; Sun, 18 Feb 2001 13:24:54 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:30734 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129824AbRBRSYm>;
	Sun, 18 Feb 2001 13:24:42 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Message-ID: <3A9011E1.8A122306@robleathley.uklinux.net>
Date: Sun, 18 Feb 2001 18:18:09 +0000
From: Rob Leathley <mail@robleathley.uklinux.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: page_alloc 2.4.1 kernel BUG running java 1.3.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a bug report in the format requested by linux/REPORTING-BUGS:

[1] page_alloc 2.4.1 kernel BUG running java 1.3.0
[2] Running java 1.3.0 e.g. 'java -jar SwingSet2.jar' etc. causes system
crashes and on other occasions, problems running other programs (e.g.
umount) subsequently.  This does not happen every time but is likely
after ~30 minutes of runnning a java application.
[3] kernel page_alloc free_pages memory
[4] Linux version 2.4.1 (gcc version egcs-2.91.66)
[5]
Feb 15 22:38:02 susy kernel: kernel BUG at page_alloc.c:75!
Feb 15 22:38:02 susy kernel: invalid operand: 0000
Feb 15 22:38:02 susy kernel: CPU:    0
Feb 15 22:38:02 susy kernel: EIP:    0010:[__free_pages_ok+62/840]
Feb 15 22:38:02 susy kernel: EFLAGS: 00210296
Feb 15 22:38:02 susy kernel: eax: 0000001f   ebx: c10b6fc8   ecx:
00000000   edx
Feb 15 22:38:02 susy kernel: esi: c10b6fc8   edi: 00000000   ebp:
0000000b   esp
Feb 15 22:38:02 susy kernel: ds: 0018   es: 0018   ss: 0018
Feb 15 22:38:02 susy kernel: Process bdflush (pid: 6,
stackpage=c5ff1000)
Feb 15 22:38:02 susy kernel: Stack: c01d3d51 c01d3eff 0000004b c10b6ff0
c10b6fc8
Feb 15 22:38:02 susy kernel:        00000018 00000018 ffffff0e c0128748
c0129dde
Feb 15 22:38:02 susy kernel:        00000000 0008e000 00000000 00000000
00000004
Feb 15 22:38:02 susy kernel: Call Trace: [page_launder+1220/2072]
[__free_pages+
Feb 15 22:38:02 susy kernel: 
Feb 15 22:38:02 susy kernel: Code: 0f 0b 83 c4 0c 89 da 2b 15 b8 b9 25
c0 89 d0 
Feb 15 22:38:02 susy kernel: kernel BUG at exit.c:457!
Feb 15 22:38:02 susy kernel: invalid operand: 0000
Feb 15 22:38:02 susy kernel: CPU:    0
Feb 15 22:38:02 susy kernel: EIP:    0010:[do_exit+523/536]
Feb 15 22:38:02 susy kernel: EFLAGS: 00013282
Feb 15 22:38:02 susy kernel: eax: 0000001a   ebx: c0205cc0   ecx:
00000000   edx
Feb 15 22:38:02 susy kernel: esi: c5ff0000   edi: 0000000b   ebp:
0000000b   esp
Feb 15 22:38:02 susy kernel: ds: 0018   es: 0018   ss: 0018
Feb 15 22:38:02 susy kernel: Process bdflush (pid: 6,
stackpage=c5ff1000)
Feb 15 22:38:02 susy kernel: Stack: c01d0831 c01d0968 000001c9 c5ff1f44
00000000
Feb 15 22:38:02 susy kernel:        c01095a3 c01ca95a c5ff1f44 00000000
c5ff0000
Feb 15 22:38:02 susy kernel:        00030002 c012943e c5ff1f04 000001c0
0000000e
Feb 15 22:38:02 susy kernel: Call Trace: [do_invalid_op+0/136]
[die+66/68] [do_i
Feb 15 22:38:02 susy kernel:        [ret_from_intr+0/32]
[do_invalid_op+0/136] [
Feb 15 22:38:02 susy kernel:        [bdflush+134/208]
[kernel_thread+35/48] 
Feb 15 22:38:02 susy kernel: 
Feb 15 22:38:02 susy kernel: Code: 0f 0b 83 c4 0c e9 45 fe ff ff 8d 76
00 8b 4c 
Feb 15 22:38:02 susy kernel: kernel BUG at exit.c:457!
...
Feb 17 18:41:18 susy kernel: kernel BUG at page_alloc.c:73!
Feb 17 18:41:19 susy kernel: invalid operand: 0000
Feb 17 18:41:19 susy kernel: CPU:    0
Feb 17 18:41:19 susy kernel: EIP:    0010:[__free_pages_ok+34/840]
Feb 17 18:41:19 susy kernel: EFLAGS: 00210282
Feb 17 18:41:19 susy kernel: eax: 0000001f   ebx: c10ceba0   ecx:
00000000   edx
Feb 17 18:41:19 susy kernel: esi: 030a4067   edi: 00000000   ebp:
0004d000   esp
Feb 17 18:41:19 susy kernel: ds: 0018   es: 0018   ss: 0018
Feb 17 18:41:19 susy kernel: Process java (pid: 3043,
stackpage=c0fa7000)
Feb 17 18:41:19 susy kernel: Stack: c01d3d51 c01d3eff 00000049 c10ceba0
030a4067
Feb 17 18:41:19 susy kernel:        c1044010 c0208f60 00200213 00001052
c0129dde
Feb 17 18:41:19 susy kernel:        c011ed60 c10ceba0 c4c1f7a0 c40b1640
0804d000
Feb 17 18:41:19 susy kernel: Call Trace: [__free_pages+26/28]
[free_page_and_swa
Feb 17 18:41:19 susy kernel:        [system_call+51/64] 
Feb 17 18:41:19 susy kernel: 
Feb 17 18:41:19 susy kernel: Code: 0f 0b 83 c4 0c 83 7b 08 00 74 16 6a
4b 68 ff

[6] see[2]
[7.1]
 sh scripts/ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux susy 2.4.1 #1 Sat Feb 3 16:46:27 GMT 2001 i586 unknown
Kernel modules         2.4.1
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4070406 Aug  5  2000
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         usbcore serial isa-pnp

C libs: /usr/i386-glibc21-linux /usr/lib/libstdc++-3-libc6.2-2-2.10.0.so
[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 132.956
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 265.42
[7.3]
usbcore                28688   0 (autoclean) (unused)
serial                 42736   0 (autoclean)
isa-pnp                28720   0 (autoclean) [serial]
[7.4]
 more /proc/ioports 
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
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
fc00-fcff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
ff80-ff9f : Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II]
ffa0-ffaf : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
more /proc/iomem 
00000000-0009fbff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-05ffffff : System RAM
  00100000-001c98b9 : Kernel code
  001c98ba-002144bb : Kernel data
fb000000-fbffffff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
ffbef000-ffbeffff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
fff80000-ffffffff : reserved
[7.5]
lspci -vvv
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II]
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort - <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev  01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Step ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort - <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II] (p rog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort - <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB
[Natoma/Triton II] ( rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort - <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at ff80 [size=32]

00:0f.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II
215GT [Mach 64 GT] (rev 41) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step ping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort - <MAbort- >SERR- <PERR-
        Latency: 72 (2000ns min), cache line size 08
        Region 0: Memory at fb000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: I/O ports at fc00 [size=256]
        Region 2: Memory at ffbef000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
[7.6] no scsi
[7.7]
/proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  97247232 92991488  4255744        0  5152768 56184832
Swap: 260620288        0 260620288

The system is based on SuSE 7.0

[X] I have been suffering a lot of memory paging related Oops' on the
above PC since upgrading to the 2.2.16 kernel.  Most of these problems
are fixed in 2.4.1 appart from the above.  These problems don't appear
on a faster machine (e.g. P3 733MHz) so could be related to race
conditions?  I appreciate that there is probably a bug in java 1.3.0 but
it would be nice if it didn't kill the whole machine!

Hope you can help!  I would be glad to provide any more info that may
help.

regards,

Rob

