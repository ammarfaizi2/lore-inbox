Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279700AbRJ0CIY>; Fri, 26 Oct 2001 22:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279708AbRJ0CIQ>; Fri, 26 Oct 2001 22:08:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:2394 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S279700AbRJ0CIB>;
	Fri, 26 Oct 2001 22:08:01 -0400
Date: Sat, 27 Oct 2001 03:53:00 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Oops with 2.4.13
Message-ID: <20011027035300.A19415@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.3.19i
X-Operating-System: Linux 2.4.13 i686
X-Editor: VIM - Vi IMproved 6.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] One line summary of the problem:
     
     Oops with 2.4.13

[2.] Full description of the problem/report:
     
     While trying to build a RPM of imlib, I got an oops in process sh.

[3.] Keywords (i.e., modules, networking, kernel):

     kernel, sh

[4.] Kernel version (from /proc/version):

     marvin:~ # cat /proc/version
     Linux version 2.4.13 (root@marvin) (gcc version 2.95.2 19991024
     (release)) #1 Fri Oct 26 11:32:16 CEST 2001

[5.] Output of Oops.. message:

ksymoops 2.4.0 on i686 2.4.13.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m save.map (specified)

Oct 27 03:24:08 marvin kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 27 03:24:08 marvin kernel: c013d8d8
Oct 27 03:24:08 marvin kernel: *pde = 00000000
Oct 27 03:24:08 marvin kernel: Oops: 0000
Oct 27 03:24:08 marvin kernel: CPU:    0
Oct 27 03:24:08 marvin kernel: EIP:    0010:[d_lookup+92/244]    Not tainted
Oct 27 03:24:08 marvin kernel: EFLAGS: 00010207
Oct 27 03:24:08 marvin kernel: eax: c1220070   ebx: fffffff0   ecx: 0000000e   edx: 0003aca1
Oct 27 03:24:08 marvin kernel: esi: 00000000   edi: c2723fa4   ebp: 00000000   esp: c2723f14
Oct 27 03:24:08 marvin kernel: ds: 0018   es: 0018   ss: 0018
Oct 27 03:24:08 marvin kernel: Process sh (pid: 19171, stackpage=c2723000)
Oct 27 03:24:08 marvin kernel: Stack: c2723f74 00000000 c2723fa4 c5f2a7e0 c1220070 c49ac00a 0003aca1 00000002 
Oct 27 03:24:08 marvin kernel:        c0135f24 c7b58d40 c2723f74 c2723f74 c01365a8 c7b58d40 c2723f74 00000000 
Oct 27 03:24:08 marvin kernel:        c49ac000 00000000 c2723fa4 00000009 c0135d3e 00000009 c49ac00c 00000000 
Oct 27 03:24:08 marvin kernel: Call Trace: [cached_lookup+16/84] [link_path_walk+1184/1752] [getname+94/156] [path_walk+26/28] [__user_walk+53/80] 
Oct 27 03:24:08 marvin kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 74                     jne    80 <_EIP+0x80> 00000080 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Oct 27 03:26:30 marvin kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 27 03:26:30 marvin kernel: c013d8d8
Oct 27 03:26:30 marvin kernel: *pde = 00000000
Oct 27 03:26:30 marvin kernel: Oops: 0000
Oct 27 03:26:30 marvin kernel: CPU:    0
Oct 27 03:26:30 marvin kernel: EIP:    0010:[d_lookup+92/244]    Not tainted
Oct 27 03:26:30 marvin kernel: EFLAGS: 00010207
Oct 27 03:26:30 marvin kernel: eax: c1220070   ebx: fffffff0   ecx: 0000000e   edx: 0003aca1
Oct 27 03:26:30 marvin kernel: esi: 00000000   edi: c27b3fa4   ebp: 00000000   esp: c27b3f14
Oct 27 03:26:30 marvin kernel: ds: 0018   es: 0018   ss: 0018
Oct 27 03:26:30 marvin kernel: Process sh (pid: 19183, stackpage=c27b3000)
Oct 27 03:26:30 marvin kernel: Stack: c27b3f74 00000000 c27b3fa4 c5f2a7e0 c1220070 c48cd00a 0003aca1 00000002 
Oct 27 03:26:30 marvin kernel:        c0135f24 c7b58d40 c27b3f74 c27b3f74 c01365a8 c7b58d40 c27b3f74 00000000 
Oct 27 03:26:30 marvin kernel:        c48cd000 00000000 c27b3fa4 00000009 c0135d3e 00000009 c48cd00c 00000000 
Oct 27 03:26:30 marvin kernel: Call Trace: [cached_lookup+16/84] [link_path_walk+1184/1752] [getname+94/156] [path_walk+26/28] [__user_walk+53/80] 
Oct 27 03:26:30 marvin kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 74                     jne    80 <_EIP+0x80> 00000080 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Oct 27 03:27:04 marvin kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 27 03:27:04 marvin kernel: c013d8d8
Oct 27 03:27:04 marvin kernel: *pde = 00000000
Oct 27 03:27:04 marvin kernel: Oops: 0000
Oct 27 03:27:04 marvin kernel: CPU:    0
Oct 27 03:27:04 marvin kernel: EIP:    0010:[d_lookup+92/244]    Not tainted
Oct 27 03:27:04 marvin kernel: EFLAGS: 00010207
Oct 27 03:27:04 marvin kernel: eax: c1220070   ebx: fffffff0   ecx: 0000000e   edx: 0003aca1
Oct 27 03:27:04 marvin kernel: esi: 00000000   edi: c27b3fa4   ebp: 00000000   esp: c27b3f14
Oct 27 03:27:04 marvin kernel: ds: 0018   es: 0018   ss: 0018
Oct 27 03:27:04 marvin kernel: Process sh (pid: 19190, stackpage=c27b3000)
Oct 27 03:27:04 marvin kernel: Stack: c27b3f74 00000000 c27b3fa4 c5f2a7e0 c1220070 c55cb00a 0003aca1 00000002 
Oct 27 03:27:04 marvin kernel:        c0135f24 c7b58d40 c27b3f74 c27b3f74 c01365a8 c7b58d40 c27b3f74 00000000 
Oct 27 03:27:04 marvin kernel:        c55cb000 00000000 c27b3fa4 00000009 c0135d3e 00000009 c55cb00c 00000000 
Oct 27 03:27:04 marvin kernel: Call Trace: [cached_lookup+16/84] [link_path_walk+1184/1752] [getname+94/156] [path_walk+26/28] [__user_walk+53/80] 
Oct 27 03:27:04 marvin kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 74                     jne    80 <_EIP+0x80> 00000080 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Oct 27 03:27:27 marvin kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 27 03:27:27 marvin kernel: c013d8d8
Oct 27 03:27:27 marvin kernel: *pde = 00000000
Oct 27 03:27:27 marvin kernel: Oops: 0000
Oct 27 03:27:27 marvin kernel: CPU:    0
Oct 27 03:27:27 marvin kernel: EIP:    0010:[d_lookup+92/244]    Not tainted
Oct 27 03:27:27 marvin kernel: EFLAGS: 00010207
Oct 27 03:27:27 marvin kernel: eax: c1220070   ebx: fffffff0   ecx: 0000000e   edx: 0003aca1
Oct 27 03:27:27 marvin kernel: esi: 00000000   edi: c27b3fa4   ebp: 00000000   esp: c27b3f14
Oct 27 03:27:27 marvin kernel: ds: 0018   es: 0018   ss: 0018
Oct 27 03:27:27 marvin kernel: Process sh (pid: 19196, stackpage=c27b3000)
Oct 27 03:27:27 marvin kernel: Stack: c27b3f74 00000000 c27b3fa4 c5f2a7e0 c1220070 c2cbd00a 0003aca1 00000002 
Oct 27 03:27:27 marvin kernel:        c0135f24 c7b58d40 c27b3f74 c27b3f74 c01365a8 c7b58d40 c27b3f74 00000000 
Oct 27 03:27:27 marvin kernel:        c2cbd000 00000000 c27b3fa4 00000009 c0135d3e 00000009 c2cbd00c 00000000 
Oct 27 03:27:27 marvin kernel: Call Trace: [cached_lookup+16/84] [link_path_walk+1184/1752] [getname+94/156] [path_walk+26/28] [__user_walk+53/80] 
Oct 27 03:27:27 marvin kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 74                     jne    80 <_EIP+0x80> 00000080 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol

Oct 27 03:27:39 marvin kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 27 03:27:39 marvin kernel: c013d8d8
Oct 27 03:27:39 marvin kernel: *pde = 00000000
Oct 27 03:27:39 marvin kernel: Oops: 0000
Oct 27 03:27:39 marvin kernel: CPU:    0
Oct 27 03:27:39 marvin kernel: EIP:    0010:[d_lookup+92/244]    Not tainted
Oct 27 03:27:39 marvin kernel: EFLAGS: 00010207
Oct 27 03:27:39 marvin kernel: eax: c1220070   ebx: fffffff0   ecx: 0000000e   edx: 0003aca1
Oct 27 03:27:39 marvin kernel: esi: 00000000   edi: c27b3fa4   ebp: 00000000   esp: c27b3f14
Oct 27 03:27:39 marvin kernel: ds: 0018   es: 0018   ss: 0018
Oct 27 03:27:39 marvin kernel: Process sh (pid: 19200, stackpage=c27b3000)
Oct 27 03:27:39 marvin kernel: Stack: c27b3f74 00000000 c27b3fa4 c5f2a7e0 c1220070 c451c00a 0003aca1 00000002 
Oct 27 03:27:39 marvin kernel:        c0135f24 c7b58d40 c27b3f74 c27b3f74 c01365a8 c7b58d40 c27b3f74 00000000 
Oct 27 03:27:39 marvin kernel:        c451c000 00000000 c27b3fa4 00000009 c0135d3e 00000009 c451c00c 00000000 
Oct 27 03:27:39 marvin kernel: Call Trace: [cached_lookup+16/84] [link_path_walk+1184/1752] [getname+94/156] [path_walk+26/28] [__user_walk+53/80] 
Oct 27 03:27:39 marvin kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 74                     jne    80 <_EIP+0x80> 00000080 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol


[7.] Environment
[7.1.] Software

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux marvin 2.4.13 #1 Fri Oct 26 11:32:16 CEST 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10s
mount                  2.10s
modutils               2.4.6
e2fsprogs              1.19
reiserfsprogs          3.x.0k-pre10
PPP                    2.4.1
Linux C Library        x    1 root     root      1382179 Jan 19  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         nls_iso8859-1 isofs sr_mod cdrom ide-scsi scsi_mod opl3 sound soundcore af_packet khttpd autofs4 8139too unix

[7.2.] Processor information (from /proc/cpuinfo):

     marvin:~ # cat /proc/cpuinfo
     processor       : 0
     vendor_id       : CyrixInstead
     cpu family      : 6
     model           : 2
     model name      : 6x86MX 2.5x Core/Bus Clock
     stepping        : 6
     cpu MHz         : 167.049
     fdiv_bug        : no
     hlt_bug         : no
     f00f_bug        : no
     coma_bug        : yes
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 1
     wp              : yes
     flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
     bogomips        : 333.41

[7.3.] Module information (from /proc/modules):

     marvin:~ # cat /proc/modules
     nls_iso8859-1           2848   1 (autoclean)
     isofs                  16848   1 (autoclean)
     sr_mod                 12256   1 (autoclean)
     cdrom                  26880   0 (autoclean) [sr_mod]
     ide-scsi                7472   1
     scsi_mod               83872   2 (autoclean) [sr_mod ide-scsi]
     opl3                   11056   0 (autoclean) (unused)
     sound                  51808   0 (autoclean) [opl3]
     soundcore               3280   2 (autoclean) [sound]
     af_packet              11104   1 (autoclean)
     khttpd                 21392   3
     autofs4                 8032   1 (autoclean)
     8139too                12800   1 (autoclean)
     unix                   13632  75 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports,
       /proc/iomem)

     marvin:~ # cat /proc/ioports
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
     0376-0376 : ide1
     0388-038b : Yamaha OPL3
     03c0-03df : vga+
     03f6-03f6 : ide0
     0cf8-0cff : PCI conf1
     6000-60ff : Adaptec AIC-7861
     6500-65ff : Realtek Semiconductor Co., Ltd. RTL-8139
       6500-65ff : 8139too
     f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
       f000-f007 : ide0
       f008-f00f : ide1

     marvin:~ # cat /proc/iomem
     00000000-0009fbff : System RAM
     0009fc00-0009ffff : reserved
     000a0000-000bffff : Video RAM area
     000c0000-000c7fff : Video ROM
     000cc000-000cc7ff : Extension ROM
     000f0000-000fffff : System ROM
     00100000-07ffffff : System RAM
       00100000-001ce445 : Kernel code
       001ce446-001fd293 : Kernel data
     e0000000-e1ffffff : nVidia Corporation Vanta [NV6]
     e2000000-e2ffffff : nVidia Corporation Vanta [NV6]
     e3000000-e3000fff : Adaptec AIC-7861
     e3001000-e30010ff : Realtek Semiconductor Co., Ltd. RTL-8139
       e3001000-e30010ff : 8139too
     ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:08.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6000 [size=256]
	Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Allied Telesyn International: Unknown device 2503
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6500 [size=256]
	Region 1: Memory at e3001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Subsystem: Creative Labs: Unknown device 1039
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

    marvin:~ # cat /proc/scsi/scsi
    Attached devices:
    Host: scsi0 Channel: 00 Id: 00 Lun: 00
      Vendor: TEAC     Model: CD-W54E          Rev: 1.1Y
      Type:   CD-ROM                           ANSI SCSI revision: 02


Please CC me, as I'm not subscribed to the LKML.

Tell me, if I should provide more information.

Bye,

Manfred
- -- 
 /"\                        |  *  AIM: mahowi42  *  ICQ: 61597169  *
 \ /  ASCII ribbon campaign | PGP-Key available at Public Key Servers
  X   against HTML mail     | or "http://www.mahowi.de/pgp/mahowi.asc"
 / \  and postings          |  * RSA: 0xC05BC0F5 * DSS: 0x4613B5CA *
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE72hN7Y61sikYTtcoRAtWPAJ900QutSrYbVwkdX+Z+v+qo0jK7JgCgjTyN
riz9fFFT30MJkUv8RDnvj3I=
=q6MR
-----END PGP SIGNATURE-----
