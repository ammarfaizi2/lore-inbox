Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSEBSBS>; Thu, 2 May 2002 14:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315219AbSEBSBR>; Thu, 2 May 2002 14:01:17 -0400
Received: from web10205.mail.yahoo.com ([216.136.130.69]:29455 "HELO
	web10205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315214AbSEBSBE>; Thu, 2 May 2002 14:01:04 -0400
Message-ID: <20020502180104.64414.qmail@web10205.mail.yahoo.com>
Date: Thu, 2 May 2002 11:01:04 -0700 (PDT)
From: Drew Lewis <lag_face@yahoo.com>
Subject: Kernel Bug dcache.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I came home from school and on my first console was
this Kernel Bug information for dcache.c. I think i
had 2 bash processes running and the rest of my
ordinary services. 
The file dcache.c is in the directory 'fs/' ; line 837
has a function BUG() which calls this bug report.

I am not a great C program, so I can only try the
steps recommended by Linux for oops reports, I will
email them later if I can figure this out.


This is the message:
---------START MESSAGE -------------

kernel BUG at dcache.c:837!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014370b>]
EFLAGS: 00010286
eax: 0000001c   ebx: c0fb6c78   ecx: 0000002e   edx:
c2146000
esi: c11319e8   edi: c0fb6c60   ebp: c0fb6c60   esp:
c2147ee8
ds: 0018   es: 0018   ss: 0018
Process find (pid: 2854, stackpage=c2147000)
Stack: c0255cc6 c0255d45 00000345 00072c17 c0fb6c60
c2e4bbc0 c01553fe 
c0fb6c60
       c0fb6c60 c322bde0 fffffff4 c2146000 c2e4bbc0
c2e2a580 c013a87e 
c2e4bbc0
       c0fb6c60 c2147f68 00000000 c2e4bbc0 c2147fa4
c013b069 c1f28a40 
c2147f68
Call Trace: [<c01553fe>] [<c013a87e>] [<c013b069>]
[<c013a54b>] 
[<c013b7a8>] [<c0138396>] [<c0106ca7>]

Code: 0f 0b 83 c4 0c f0 fe 0d 18 b9 2a c0 0f 88 31 fb
0f 00 8b 06

-------- END MESSAGE --------
I ran  ksymoops on it, and this is what i recieved.

---------- START KSYMOOPS ----------

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is
/proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol
EISA_bus_R__ver_EISA_bus not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
ip_ct_attach_R__ver_ip_ct_attach not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_getsockopt_R__ver_nf_getsockopt not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_hook_slow_R__ver_nf_hook_slow not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_hooks_R__ver_nf_hooks not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_hook_R__ver_nf_register_hook not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_queue_handler_R__ver_nf_register_queue_handler
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_register_sockopt_R__ver_nf_register_sockopt not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_reinject_R__ver_nf_reinject not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_setsockopt_R__ver_nf_setsockopt not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_hook_R__ver_nf_unregister_hook not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_queue_handler_R__ver_nf_unregister_queue_handler
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
nf_unregister_sockopt_R__ver_nf_unregister_sockopt not
found in System.map.  Ignoring ksyms_base entry

kernel BUG at dcache.c:837!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014370b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: c0fb6c78   ecx: 0000002e   edx:
c2146000
esi: c11319e8   edi: c0fb6c60   ebp: c0fb6c60   esp:
c2147ee8
ds: 0018   es: 0018   ss: 0018
Process find (pid: 2854, stackpage=c2147000)
Stack: c0255cc6 c0255d45 00000345 00072c17 c0fb6c60
c2e4bbc0 c01553fe 
c0fb6c60
       c0fb6c60 c322bde0 fffffff4 c2146000 c2e4bbc0
c2e2a580 c013a87e 
c2e4bbc0
       c0fb6c60 c2147f68 00000000 c2e4bbc0 c2147fa4
c013b069 c1f28a40 
c2147f68
Call Trace: [<c01553fe>] [<c013a87e>] [<c013b069>]
[<c013a54b>] 
[<c013b7a8>] [<c0138396>] [<c0106ca7>]
Code: 0f 0b 83 c4 0c f0 fe 0d 18 b9 2a c0 0f 88 31 fb
0f 00 8b 06


>>EIP; c014370b <d_rehash+47/74>   <=====

>>ebx; c0fb6c78 <END_OF_CODE+c74520/????>
>>edx; c2146000 <END_OF_CODE+1e038a8/????>
>>esi; c11319e8 <END_OF_CODE+def290/????>
>>edi; c0fb6c60 <END_OF_CODE+c74508/????>
>>ebp; c0fb6c60 <END_OF_CODE+c74508/????>
>>esp; c2147ee8 <END_OF_CODE+1e05790/????>

Trace; c01553fe <ext2_lookup+76/80>
Trace; c013a87e <real_lookup+7a/11c>
Trace; c013b069 <path_walk+5fd/844>
Trace; c013a54b <getname+5b/98>
Trace; c013b7a8 <__user_walk+3c/58>
Trace; c0138396 <sys_lstat64+16/70>
Trace; c0106ca7 <system_call+37/40>

Code;  c014370b <d_rehash+47/74>
00000000 <_EIP>:
Code;  c014370b <d_rehash+47/74>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014370d <d_rehash+49/74>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0143710 <d_rehash+4c/74>
   5:   f0 fe 0d 18 b9 2a c0      lock decb 0xc02ab918
Code;  c0143717 <d_rehash+53/74>
   c:   0f 88 31 fb 0f 00         js     ffb43
<_EIP+0xffb43> c024324e <stext_lock+296e/7517>
Code;  c014371d <d_rehash+59/74>
  12:   8b 06                     mov    (%esi),%eax


16 warnings issued.  Results may not be reliable.


--------- END DUMP ------------------


###############################

now output from ver_linux

---------- START OUTPUT -----------
Linux lagbox.org 2.4.5 #25 SMP Sat Aug 4 16:02:25 EDT
2001 i586 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              tune2fs
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         

----------- END OUTPUT ---------------

#########################3
/proc/cpuinfo

--------- START -----------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 166.404
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 331.77

------------- END -------------

########################
 cat /proc/ioports

------------- START -------------
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
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
6100-611f : Creative Labs SB Live! EMU10000
  6100-611f : EMU10K1
6200-6207 : Creative Labs SB Live!
6300-633f : 3Com Corporation 3c905 100BaseTX
[Boomerang]
  6300-633f : eth0
6400-643f : 3Com Corporation 3c905 100BaseTX
[Boomerang] (#2)
  6400-643f : eth1
f000-f00f : Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II]


------------- END ---------------

###################################

 cat /proc/iomem

-------------- START ---------------

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-00247df6 : Kernel code
  00247df7-002c0d3f : Kernel data
e0000000-e3ffffff : S3 Inc. Trio 64V2/DX or /GX
ffff0000-ffffffff : reserved


-------------- END -----------------

#######################################

 lspci -vvv


------------------- START ----------------

00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX
[Triton VX] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA
[Natoma/Triton II] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0


00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE
[Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:08.0 VGA compatible controller: S3 Inc. Trio
64V2/DX or /GX (rev 04) (prog-if 00 [VGA])
        Subsystem: S3 Inc. 86C775 Trio64V2/DX, 86C785
Trio64V2/GX
        Control: I/O+ Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e0000000 (32-bit,
non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled]
[size=64K]

00:09.0 Multimedia audio controller: Creative Labs SB
Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6100 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:09.1 Input device controller: Creative Labs SB
Live! (rev 06)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at 6200 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905
100BaseTX [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 6300 [size=64]
        Expansion ROM at <unassigned> [disabled]
[size=64K]

00:0b.0 Ethernet controller: 3Com Corporation 3c905
100BaseTX [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 6400 [size=64]
        Expansion ROM at <unassigned> [disabled]
[size=64K]


------------------ END ----------------


#####################################################


That is all the information I can think of giving to
you.
I hope that all helps, and it isn't to much. I will
see if I can figure out any of this myself.


Thank You,
Drew Lewis
lag_man@bigfoot.com





__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com
