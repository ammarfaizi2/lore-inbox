Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269100AbRHFWpy>; Mon, 6 Aug 2001 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRHFWpr>; Mon, 6 Aug 2001 18:45:47 -0400
Received: from mail22.bigmailbox.com ([209.132.220.199]:2831 "EHLO
	mail22.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S269100AbRHFWpa>; Mon, 6 Aug 2001 18:45:30 -0400
Date: Mon, 6 Aug 2001 15:45:18 -0700
Message-Id: <200108062245.PAA26951@mail22.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [195.92.194.14]
From: "Sitsofe Wheeler" <sitsofe@my-deja.com>
To: linux-kernel@vger.kernel.org
Subject: Virtual memory error when restarting X
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please could you CC replies to this mail to me. Thank you.

[1]
Virtual memory error when restarting X

[2]
Often after restarting X I see the messages similar to "NV0: still have vm que at nv_close(): 0x4023b000 to 0x40245000" in the logs. I presume that these are being caused by the properitry nvidia drivers that I use with X. However I have also noticed that "Unable to handle kernel paging request at virtual address 6b336b50" and the like have also been turning up. I'm wondering whether the graphics drivers problems could be being caused by a vm problem. The oops that
is enclosed does not appear to be readily repeatable...  but leaving X causes sometimes the system to lock solid with only SysRq getting through. 

[4] Kernel version
Linux version 2.4.7 (root@galvatron.localdomain) (gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.48mdk)) #1 Sun Aug 5 13:59:44 BST 2001

[5] Output of Oops.. message
ksymoops 2.3.7 on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /boot/System.map-2.4.7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says cfd92fe4, /lib/modules/2.4.7/kernel/drivers/scsi/sr_mod.o says cfd92d40.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/sr_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says c8c6077c, /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o says c8c60220.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says c8c607a8, /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o says c8c6024c.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says c8c607a4, /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o says c8c60248.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says c8c607ac, /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o says c8c60250.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/scsi_mod.o entry
Aug  5 14:27:40 galvatron kernel: c01b851c
Aug  5 14:27:40 galvatron kernel: Oops: 0000
Aug  5 14:27:40 galvatron kernel: CPU:    0
Aug  5 14:27:40 galvatron kernel: EIP:    0010:[sock_poll+28/48]
Aug  5 14:27:40 galvatron kernel: EIP:    0010:[<c01b851c>]
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  5 14:27:40 galvatron kernel: EFLAGS: 00013286
Aug  5 14:27:40 galvatron kernel: eax: 6b336b54   ebx: 00000000   ecx: c4dc80c0   edx: c2efc44c
Aug  5 14:27:40 galvatron kernel: esi: c4dc80c0   edi: 00000000   ebp: 00000145   esp: c5c35f20
Aug  5 14:27:40 galvatron kernel: ds: 0018   es: 0018   ss: 0018
Aug  5 14:27:40 galvatron kernel: Process X (pid: 1452, stackpage=c5c35000)
Aug  5 14:27:40 galvatron kernel: Stack: c4dc80c0 c2efc44c c5c35f54 c013ee6b c4dc80c0 c5c35f54 c5c35f54 00000800 
Aug  5 14:27:40 galvatron kernel:        c5c34000 0000e99e 0000000b c5c35f54 0000000e 00000000 c4001000 00000008 
Aug  5 14:27:40 galvatron kernel:        00000000 c2578740 00000000 c013f2dc 00000100 c5c35f90 c5c35f8c c3ce3440 
Aug  5 14:27:40 galvatron kernel: Call Trace: [do_select+283/560] [sys_select+812/1152] [system_call+51/56] 
Aug  5 14:27:40 galvatron kernel: Call Trace: [<c013ee6b>] [<c013f2dc>] [<c0106cc7>] 
Aug  5 14:27:40 galvatron kernel: Code: ff 50 1c 83 c4 0c c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 

>>EIP; c01b851c <sock_poll+1c/30> <=====
Trace; c013ee6b <do_select+11b/230>
Trace; c013f2dc <sys_select+32c/480>
Trace; c0106cc7 <system_call+33/38>
Code;  c01b851c <sock_poll+1c/30>
00000000 <_EIP>:
Code;  c01b851c <sock_poll+1c/30> <=====
   0:   ff 50 1c                  call   *0x1c(%eax)   <=====
Code;  c01b851f <sock_poll+1f/30>
3:   83 c4 0c                  add    $0xc,%esp
Code;  c01b8522 <sock_poll+22/30>
6:   c3                        ret    
Code;  c01b8523 <sock_poll+23/30>
7:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c01b8529 <sock_poll+29/30>
d:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi

Aug  5 14:27:40 galvatron kernel: c0141c00
Aug  5 14:27:40 galvatron kernel: Oops: 0000
Aug  5 14:27:40 galvatron kernel: CPU:    0
Aug  5 14:27:40 galvatron kernel: EIP:    0010:[locks_remove_posix+48/128]
Aug  5 14:27:40 galvatron kernel: EIP:    0010:[<c0141c00>]
Aug  5 14:27:40 galvatron kernel: EFLAGS: 00010202
Aug  5 14:27:40 galvatron kernel: eax: 6b336b54   ebx: c2efc3dc   ecx: 00000000   edx: 6b336b54
Aug  5 14:27:40 galvatron kernel: esi: c7c41e40   edi: 00000001   ebp: 0000000b   esp: c5c35dac
Aug  5 14:27:40 galvatron kernel: ds: 0018   es: 0018   ss: 0018
Aug  5 14:27:40 galvatron kernel: Process X (pid: 1452, stackpage=c5c35000)
Aug  5 14:27:40 galvatron kernel: Stack: c4dc80c0 00000000 c0130beb c4dc80c0 c7c41e40 00000000 c4dc80c0 00000000 
Aug  5 14:27:40 galvatron kernel:        00030007 c7c41e40 c01172dc c4dc80c0 c7c41e40 c13f0e00 c5c34000 0000000b 
Aug  5 14:27:40 galvatron kernel:        6b336b70 c01178bb c7c41e40 c011511e 00003086 00000001 c0281bc4 00000001 
Aug  5 14:27:40 galvatron kernel: Call Trace: [filp_close+75/96] [put_files_struct+76/192] [do_exit+187/480] [printk+366/384] [die+57/80] [do_page_fault+868/1136] [__generic_copy_to_user+48/64] 
Aug  5 14:27:40 galvatron kernel: Call Trace: [<c0130beb>] [<c01172dc>] [<c01178bb>] [<c011511e>] [<c01071c9>] [<c0112174>] [<c01f0a10>] 
Aug  5 14:27:40 galvatron kernel:        [<c01ba291>] [<c01bb09b>] [<c01bb20c>] [<c01ee9d5>] [<c012ba14>] [<c0111e10>] [<c0106db8>] [<c01b851c>] 
Aug  5 14:27:40 galvatron kernel:        [<c013ee6b>] [<c013f2dc>] [<c0106cc7>] 
Aug  5 14:27:40 galvatron kernel: Code: f6 40 2c 01 74 3a 39 70 14 75 35 8b 13 8b 42 28 8b 40 10 85 

>>EIP; c0141c00 <locks_remove_posix+30/80> <=====
Trace; c0130beb <filp_close+4b/60>
Trace; c01172dc <put_files_struct+4c/c0>
Trace; c01178bb <do_exit+bb/1e0>
Trace; c011511e <printk+16e/180>
Trace; c01071c9 <die+39/50>
Trace; c0112174 <do_page_fault+364/470>
Trace; c01f0a10 <__generic_copy_to_user+30/40>
Trace; c01ba291 <sock_wfree+21/40>
Trace; c01bb09b <kfree_skbmem+b/60>
Trace; c01bb20c <__kfree_skb+11c/120>
Trace; c01ee9d5 <unix_stream_recvmsg+305/390>
Trace; c012ba14 <__alloc_pages+74/270>
Trace; c0111e10 <do_page_fault+0/470>
Trace; c0106db8 <error_code+34/3c>
Trace; c01b851c <sock_poll+1c/30>
Trace; c013ee6b <do_select+11b/230>
Trace; c013f2dc <sys_select+32c/480>
Trace; c0106cc7 <system_call+33/38>
Code;  c0141c00 <locks_remove_posix+30/80>
00000000 <_EIP>:
Code;  c0141c00 <locks_remove_posix+30/80> <=====
   0:   f6 40 2c 01               testb  $0x1,0x2c(%eax)   <=====
Code;  c0141c04 <locks_remove_posix+34/80>
4:   74 3a                     je     40 <_EIP+0x40> c0141c40 <locks_remove_posix+70/80>
Code;  c0141c06 <locks_remove_posix+36/80>
6:   39 70 14                  cmp    %esi,0x14(%eax)
Code;  c0141c09 <locks_remove_posix+39/80>
9:   75 35                     jne    40 <_EIP+0x40> c0141c40 <locks_remove_posix+70/80>
Code;  c0141c0b <locks_remove_posix+3b/80>
b:   8b 13                     mov    (%ebx),%edx
Code;  c0141c0d <locks_remove_posix+3d/80>
d:   8b 42 28                  mov    0x28(%edx),%eax
Code;  c0141c10 <locks_remove_posix+40/80>
10:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c0141c13 <locks_remove_posix+43/80>
13:   85 00                     test   %eax,(%eax)

Aug  5 14:27:40 galvatron kernel: c0112bb3
Aug  5 14:27:40 galvatron kernel: Oops: 0000
Aug  5 14:27:40 galvatron kernel: CPU:    0
Aug  5 14:27:40 galvatron kernel: EIP:    0010:[__wake_up+51/160]
Aug  5 14:27:40 galvatron kernel: EIP:    0010:[<c0112bb3>]
Aug  5 14:27:40 galvatron kernel: EFLAGS: 00010897
Aug  5 14:27:40 galvatron kernel: eax: c2efc468   ebx: 6b336b54   ecx: 00000000   edx: c2efc46c
Aug  5 14:27:40 galvatron kernel: esi: c1226140   edi: 6b336b4c   ebp: c5acbe10   esp: c5acbdf4
Aug  5 14:27:40 galvatron kernel: ds: 0018   es: 0018   ss: 0018
Aug  5 14:27:40 galvatron kernel: Process kdm (pid: 2012, stackpage=c5acb000)
Aug  5 14:27:40 galvatron kernel: Stack: c2efc46c 00000000 00000282 00000001 c319eb00 c1226140 c319e7c0 00000000 
Aug  5 14:27:40 galvatron kernel:        c01ecd5f c319eb00 00000001 00000000 00000000 c0120d94 c105ee1c 00000008 
Aug  5 14:27:40 galvatron kernel:        c352eb4c c1226140 c352ea40 c3debac0 c01ed06f c319e7c0 00000000 c01b8070 
Aug  5 14:27:40 galvatron kernel: Call Trace: [unix_release_sock+207/448] [zap_page_range+420/592] [unix_release+31/48] [sock_release+16/80] [sock_close+47/64] [fput+57/192] [filp_close+82/96] 
Aug  5 14:27:40 galvatron kernel: Call Trace: [<c01ecd5f>] [<c0120d94>] [<c01ed06f>] [<c01b8070>] [<c01b858f>] [<c0131aa9>] [<c0130bf2>] 
Aug  5 14:27:40 galvatron kernel:        [<c01172dc>] [<c01178bb>] [<c011c66b>] [<c0106b73>] [<c0112a44>] [<c0117db6>] [<c0106d00>] 
Aug  5 14:27:40 galvatron kernel: Code: 8b 4f 04 8b 1b 8b 01 85 45 f0 74 4f 31 c0 9c 5e fa c7 01 00 

>>EIP; c0112bb3 <__wake_up+33/a0> <=====
Trace; c01ecd5f <unix_release_sock+cf/1c0>
Trace; c0120d94 <zap_page_range+1a4/250>
Trace; c01ed06f <unix_release+1f/30>
Trace; c01b8070 <sock_release+10/50>
Trace; c01b858f <sock_close+2f/40>
Trace; c0131aa9 <fput+39/c0>
Trace; c0130bf2 <filp_close+52/60>
Trace; c01172dc <put_files_struct+4c/c0>
Trace; c01178bb <do_exit+bb/1e0>
Trace; c011c66b <dequeue_signal+6b/b0>
Trace; c0106b73 <do_signal+223/28c>
Trace; c0112a44 <schedule+254/390>
Trace; c0117db6 <sys_wait4+396/3a0>
Trace; c0106d00 <signal_return+14/18>
Code;  c0112bb3 <__wake_up+33/a0>
00000000 <_EIP>:
Code;  c0112bb3 <__wake_up+33/a0> <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0112bb6 <__wake_up+36/a0>
3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0112bb8 <__wake_up+38/a0>
5:   8b 01                     mov    (%ecx),%eax
Code;  c0112bba <__wake_up+3a/a0>
7:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c0112bbd <__wake_up+3d/a0>
a:   74 4f                     je     5b <_EIP+0x5b> c0112c0e <__wake_up+8e/a0>
Code;  c0112bbf <__wake_up+3f/a0>
c:   31 c0                     xor    %eax,%eax
Code;  c0112bc1 <__wake_up+41/a0>
e:   9c                        pushf  
Code;  c0112bc2 <__wake_up+42/a0>
f:   5e                        pop    %esi
Code;  c0112bc3 <__wake_up+43/a0>
10:   fa                        cli    
Code;  c0112bc4 <__wake_up+44/a0>
11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)


6 warnings issued.  Results may not be reliable.

[7.1] Software
Linux galvatron.localdomain 2.4.7 #1 Sun Aug 5 13:59:44 BST 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.3
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         sr_mod isofs NVdriver emu10k1 ac97_codec soundcore ne2k-pci 8390 ipt_REJECT ipt_limit ipt_state ipt_LOG ip_conntrack_ftp iptable_mangle ide-scsi scsi_mod ide-cd cdrom iptable_filter ipt_MASQUERADE iptable_nat ip_tables ip_conntrack nls_iso8859-1 nls_cp850 vfat fat

[7.2] Processor information
processor     : 0
vendor_id     : AuthenticAMD
cpu family     : 6
model     : 4
model name     : AMD Athlon(tm) Processor
stepping     : 2
cpu MHz     : 850.047
cache size     : 256 KB
fdiv_bug     : no
hlt_bug     : no
f00f_bug     : no
coma_bug     : no
fpu     : yes
fpu_exception     : yes
cpuid level     : 1
wp     : yes
flags     : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips     : 1697.38

[7.3] Module information
sr_mod                 12512   1 (autoclean)
isofs                  18176   1 (autoclean)
NVdriver              630608  12 (autoclean)
emu10k1                48416   0
ac97_codec              8496   0 [emu10k1]
soundcore               4080   4 [emu10k1]
ne2k-pci                5408   1 (autoclean)
8390                    6288   0 (autoclean) [ne2k-pci]
ipt_REJECT              3232   2 (autoclean)
ipt_limit               1296  11 (autoclean)
ipt_state                960  13 (autoclean)
ipt_LOG                 3696  11
ip_conntrack_ftp        3792   0 (unused)
iptable_mangle          2048   0 (autoclean) (unused)
ide-scsi                8048   1
scsi_mod               55232   2 [sr_mod ide-scsi]
ide-cd                 26448   0
cdrom                  27552   0 [sr_mod ide-cd]
iptable_filter          2016   0 (autoclean) (unused)
ipt_MASQUERADE          1584   1 (autoclean)
iptable_nat            16080   0 [ipt_MASQUERADE]
ip_tables              11008  10 [ipt_REJECT ipt_limit ipt_state ipt_LOG iptable_mangle iptable_filter ipt_MASQUERADE iptable_nat]
ip_conntrack           15392   3 [ipt_state ip_conntrack_ftp ipt_MASQUERADE iptable_nat]
nls_iso8859-1           2864   2 (autoclean)
nls_cp850               3616   1 (autoclean)
vfat                    9424   1 (autoclean)
fat                    32032   0 (autoclean) [vfat]

[7.4] Loaded driver and hardware information
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-001f57ab : Kernel code
  001f57ac-00242fb3 : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
cdc00000-ddcfffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation GeForce 256 DDR
    d0000000-d03fffff : vesafb
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation GeForce 256 DDR
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved
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
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0800-08ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0c00-0c7f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
cc00-cc1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  cc00-cc1f : ne2k-pci
d000-d01f : Creative Labs SB Live! EMU10000
  d000-d01f : EMU10K1
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
dc00-dc07 : Creative Labs SB Live!
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

[7.5] PCI information
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
     Latency: 8
     Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
     Capabilities: [a0] AGP version 2.0
     Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
     Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>
Capabilities: [c0] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
     Latency: 0
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 0000a000-0000afff
     Memory behind bridge: dde00000-dfefffff
     Prefetchable memory behind bridge: cdc00000-ddcfffff
     BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
     Capabilities: [80] Power Management version 2
     Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
     Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Latency: 32
     Region 4: I/O ports at ffa0 [size=16]
     Capabilities: [c0] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
     Subsystem: Unknown device 0925:1234
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Latency: 64, cache line size 08
     Interrupt: pin D routed to IRQ 10
     Region 4: I/O ports at d400 [size=32]
     Capabilities: [80] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
     Subsystem: Unknown device 0925:1234
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Latency: 64, cache line size 08
     Interrupt: pin D routed to IRQ 10
     Region 4: I/O ports at d800 [size=32]
     Capabilities: [80] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Capabilities: [68] Power Management version 2
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
     Subsystem: Creative Labs CT4832 SBLive! Value
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Latency: 64 (500ns min, 5000ns max)
     Interrupt: pin A routed to IRQ 9
     Region 0: I/O ports at d000 [size=32]
     Capabilities: [dc] Power Management version 1
     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 07)
     Subsystem: Creative Labs Gameport Joystick
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Latency: 64
     Region 0: I/O ports at dc00 [size=8]
     Capabilities: [dc] Power Management version 1
     Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
     Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Interrupt: pin A routed to IRQ 10
     Region 0: I/O ports at cc00 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 10) (prog-if 00 [VGA])
     Subsystem: Creative Labs CT6971 GeForce 256 DDR
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
     Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
     Latency: 248 (1250ns min, 250ns max)
     Interrupt: pin A routed to IRQ 11
     Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
     Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
     Expansion ROM at dfef0000 [disabled] [size=64K]
     Capabilities: [60] Power Management version 1
     Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
     Status: D0 PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [44] AGP version 2.0
     Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
     Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>

[7.6] SCSI information
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: RICOH    Model: DVD/CDRW MP9060  Rev: 1.90
  Type:   CD-ROM                           ANSI SCSI revision: 02



------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/
