Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTLLRpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTLLRpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:45:41 -0500
Received: from vsmtp2.tin.it ([212.216.176.222]:25573 "EHLO vsmtp2alice.tin.it")
	by vger.kernel.org with ESMTP id S261681AbTLLRp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:45:27 -0500
Subject: oops
From: Cristiano De Michele <demichel@na.infn.it>
To: linux-kernel@vger.kernel.org
Cc: usb@in.tum.de, linux-usb-users@lists.sourceforge.net, mingo@redhat.com,
       torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Physics
Message-Id: <1071251123.1342.23.camel@cripat.acasa-tr.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Dec 2003 18:45:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
several  oops got using kernel 2.4.23 presumably turning off the usb
printer to stop an unwanted job...
 
############ OOPS#1 #############
Dec 12 17:58:28 cripat kernel: Unable to handle kernel paging request at
virtual address 5a01954c
Dec 12 17:58:28 cripat kernel: c014dd53
Dec 12 17:58:28 cripat kernel: *pde = 00000000
Dec 12 17:58:28 cripat kernel: Oops: 0002
Dec 12 17:58:28 cripat kernel: CPU:    0
Dec 12 17:58:28 cripat kernel: EIP:    0010:[dput+19/336]    Tainted: P 
Dec 12 17:58:28 cripat kernel: EFLAGS: 00010202
Dec 12 17:58:28 cripat kernel: eax: c158e354   ebx: 5a01954c   ecx:
ca97d000   edx: c158e35c
Dec 12 17:58:28 cripat kernel: esi: ca97d3f0   edi: d73e23f4   ebp:
c15adef4   esp: c15adee4
Dec 12 17:58:28 cripat kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 17:58:28 cripat kernel: Process kswapd (pid: 4,
stackpage=c15ad000)
Dec 12 17:58:28 cripat kernel: Stack: ca97d3f0 5a01954c 5a01954c
ca97d3f0 c15adf10 c014e13b 5a01954c ca97d3f0 
Dec 12 17:58:28 cripat kernel:        00000003 c11f2590 c02fdb58
c15adf1c c014e435 000000fb c15adf4c c01341ee 
Dec 12 17:58:28 cripat kernel:        00000006 000001d0 c15ac000
ffffffff 0000387a 000001d0 00000003 00000020 
Dec 12 17:58:28 cripat kernel: Call Trace:    [prune_dcache+283/336]
[shrink_dcache_memory+37/64] [shrink_cache+350/880]
[shrink_caches+60/80] [try_to_free_pages_zone+83/224]
Dec 12 17:58:28 cripat kernel: Code: ff 0b 0f 94 c0 84 c0 0f 84 bf 00 00
00 8d 73 18 39 73 18 74 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c158e354 <_end+11fca80/2051d7ac>
>>ecx; ca97d000 <_end+a5eb72c/2051d7ac>
>>edx; c158e35c <_end+11fca88/2051d7ac>
>>esi; ca97d3f0 <_end+a5ebb1c/2051d7ac>
>>edi; d73e23f4 <_end+17050b20/2051d7ac>
>>ebp; c15adef4 <_end+121c620/2051d7ac>
>>esp; c15adee4 <_end+121c610/2051d7ac>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 0b                     decl   (%ebx)
Code;  00000002 Before first symbol
   2:   0f 94 c0                  sete   %al
Code;  00000005 Before first symbol
   5:   84 c0                     test   %al,%al
Code;  00000007 Before first symbol
   7:   0f 84 bf 00 00 00         je     cc <_EIP+0xcc>
Code;  0000000d Before first symbol
   d:   8d 73 18                  lea    0x18(%ebx),%esi
Code;  00000010 Before first symbol
  10:   39 73 18                  cmp    %esi,0x18(%ebx)
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15>
################ OOPS #2 ###########################
Dec 12 14:38:14 cripat kernel: NMI Watchdog detected LOCKUP on CPU0, eip
c0118aec, registers:
Dec 12 14:38:14 cripat kernel: CPU:    0
Dec 12 14:38:14 cripat kernel: EIP:    0010:[schedule+268/832]   
Tainted: P 
Dec 12 14:38:14 cripat kernel: EFLAGS: 00200082
Dec 12 14:38:14 cripat kernel: eax: e0806038   ebx: e0806038   ecx:
e0805ffc   edx: e0806020
Dec 12 14:38:14 cripat kernel: esi: cd042000   edi: 00000017   ebp:
cedd1fbc   esp: cedd1f94
Dec 12 14:38:14 cripat kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 14:38:14 cripat kernel: Process realplay (pid: 10097,
stackpage=cedd1000)
Dec 12 14:38:14 cripat kernel: Stack: 000036d8 40321290 cedd1fbc
de559c74 cedd0000 00000000 c0361100 cedd0000 
Dec 12 14:38:14 cripat kernel:        00000002 40321290 bff7f1b0
c01090bd 00000003 bff7f250 00000002 00000002 
Dec 12 14:38:14 cripat kernel:        40321290 bff7f1b0 000036d8
0000002b 0000002b 00000092 402c237e 00000023 
Dec 12 14:38:14 cripat kernel: Call Trace:    [reschedule+5/12]
Dec 12 14:38:14 cripat kernel: Code: 89 da 89 c3 0f 0d 00 81 fa 64 c2 2f
c0 75 b5 85 ff 0f 84 42 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; e0806038 <_end+20474764/2051d7ac>
>>ebx; e0806038 <_end+20474764/2051d7ac>
>>ecx; e0805ffc <_end+20474728/2051d7ac>
>>edx; e0806020 <_end+2047474c/2051d7ac>
>>esi; cd042000 <_end+ccb072c/2051d7ac>
>>ebp; cedd1fbc <_end+ea406e8/2051d7ac>
>>esp; cedd1f94 <_end+ea406c0/2051d7ac>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 da                     mov    %ebx,%edx
Code;  00000002 Before first symbol
   2:   89 c3                     mov    %eax,%ebx
Code;  00000004 Before first symbol
   4:   0f 0d 00                  prefetch (%eax)
Code;  00000007 Before first symbol
   7:   81 fa 64 c2 2f c0         cmp    $0xc02fc264,%edx
Code;  0000000d Before first symbol
   d:   75 b5                     jne    ffffffc4 <_EIP+0xffffffc4>
Code;  0000000f Before first symbol
   f:   85 ff                     test   %edi,%edi
Code;  00000011 Before first symbol
  11:   0f 84 42 00 00 00         je     59 <_EIP+0x59>
########################## OOPS #3 #########################
Dec 12 15:22:59 cripat kernel: Unable to handle kernel paging request at
virtual address 0059003c
Dec 12 15:22:59 cripat kernel: c0118aea
Dec 12 15:22:59 cripat kernel: *pde = 00000000
Dec 12 15:22:59 cripat kernel: Oops: 0000
Dec 12 15:22:59 cripat kernel: CPU:    0
Dec 12 15:22:59 cripat kernel: EIP:    0010:[schedule+266/832]   
Tainted: P 
Dec 12 15:22:59 cripat kernel: EFLAGS: 00010003
Dec 12 15:22:59 cripat kernel: eax: 00000019   ebx: 0059003c   ecx:
c9878000   edx: de559f1c
Dec 12 15:22:59 cripat kernel: esi: c9878000   edi: 00000019   ebp:
db591fbc   esp: db591f94
Dec 12 15:22:59 cripat kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 15:22:59 cripat kernel: Process realplay (pid: 11674,
stackpage=db591000)
Dec 12 15:22:59 cripat kernel: Stack: 000036d8 40316290 db591fbc
de559e94 db590000 00000000 c0361100 db590000 
Dec 12 15:23:00 cripat kernel:        00000002 40316290 bff7f240
c01090bd 00000003 bff7f2e0 00000002 00000002 
Dec 12 15:23:00 cripat kernel:        40316290 bff7f240 000036d8
0000002b 0000002b 00000092 402b737e 00000023 
Dec 12 15:23:00 cripat kernel: Call Trace:    [reschedule+5/12]
Dec 12 15:23:00 cripat kernel: Code: 8b 03 89 da 89 c3 0f 0d 00 81 fa 64
c2 2f c0 75 b5 85 ff 0f 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; c9878000 <_end+94e672c/2051d7ac>
>>edx; de559f1c <_end+1e1c8648/2051d7ac>
>>esi; c9878000 <_end+94e672c/2051d7ac>
>>ebp; db591fbc <_end+1b2006e8/2051d7ac>
>>esp; db591f94 <_end+1b2006c0/2051d7ac>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 03                     mov    (%ebx),%eax
Code;  00000002 Before first symbol
   2:   89 da                     mov    %ebx,%edx
Code;  00000004 Before first symbol
   4:   89 c3                     mov    %eax,%ebx
Code;  00000006 Before first symbol
   6:   0f 0d 00                  prefetch (%eax)
Code;  00000009 Before first symbol
   9:   81 fa 64 c2 2f c0         cmp    $0xc02fc264,%edx
Code;  0000000f Before first symbol
   f:   75 b5                     jne    ffffffc6 <_EIP+0xffffffc6>
Code;  00000011 Before first symbol
  11:   85 ff                     test   %edi,%edi
Code;  00000013 Before first symbol
  13:   0f 00 00                  sldtl  (%eax)

and cat /proc/cpuinfo:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1700+
stepping	: 2
cpu MHz		: 1470.019
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2936.01

cat /proc/version:
Linux version 2.4.23 (root@cripat) (gcc version 3.3.2 (Debian)) #1 Sat
Nov 29 13:39:54 CET 2003

cat /proc/modules:

printer                 7264   0 (unused)
input                   3424   0 (autoclean)
audio                  41976   0 (unused)
agpgart                14000   3 (autoclean)
nvidia               1630112  11 (autoclean)
ip_nat_irc              2160   0 (unused)
ip_conntrack_irc        3120   1
ip_conntrack_ftp        3952   1 (autoclean)
ip_nat_ftp              2800   0 (unused)
ipt_unclean             6968   0 (unused)
ipt_state                568  10
ipt_REJECT              3512   0 (unused)
ipt_REDIRECT             760   0 (unused)
ipt_multiport            696   5
ipt_MIRROR              1304   0 (unused)
ipt_MASQUERADE          1368   1
ipt_LOG                 3512   0 (unused)
ipt_limit                920   0 (unused)
iptable_nat            15726   3 [ip_nat_irc ip_nat_ftp ipt_REDIRECT
ipt_MASQUERADE]
iptable_mangle          2168   0 (unused)
iptable_filter          1740   1
ip_queue                5712   0 (unused)
ip_tables              12032  14 [ipt_unclean ipt_state ipt_REJECT
ipt_REDIRECT ipt_multiport ipt_MIRROR ipt_MASQUERADE ipt_LOG ipt_limit
iptable_nat iptable_mangle iptable_filter]
parport_pc             15556   1 (autoclean)
lp                      6592   0 (autoclean)
parport                25608   1 (autoclean) [parport_pc lp]
ppp_deflate             3480   0 (autoclean)
zlib_inflate           18436   0 (autoclean) [ppp_deflate]
zlib_deflate           18040   0 (autoclean) [ppp_deflate]
bsd_comp                4120   0 (autoclean)
ppp_async               7488   1 (autoclean)
snd-seq-oss            28896   0 (unused)
snd-seq-midi-event      3296   0 [snd-seq-oss]
snd-seq                36368   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            37572   1
snd-mixer-oss          12976   1 [snd-pcm-oss]
snd-via82xx            13600   3
snd-pcm                59812   0 [snd-pcm-oss snd-via82xx]
snd-timer              14404   0 [snd-seq snd-pcm]
snd-ac97-codec         42296   0 [snd-via82xx]
snd-page-alloc          6228   0 [snd-via82xx snd-pcm]
gameport                1644   0 [snd-via82xx]
snd-mpu401-uart         3376   0 [snd-via82xx]
snd-rawmidi            13568   0 [snd-mpu401-uart]
snd-seq-device          4240   0 [snd-seq-oss snd-seq snd-rawmidi]
snd                    32644   1 [snd-seq-oss snd-seq-midi-event snd-seq
snd-pcm-oss snd-mixer-oss snd-via82xx snd-pcm snd-timer snd-ac97-codec
snd-mpu401-uart snd-rawmidi snd-seq-device]
uhci                   25340   0 (unused)
tun                     4224   0 (unused)
8139too                16168   1
mii                     2464   0 [8139too]
crc32                   2880   0 [8139too]
3c59x                  26128   1
nls_cp437               4380   0 (unused)
thermal                 6372   0 (unused)
ac                      1856   0 (unused)
fan                     1664   0 (unused)
processor               8504   0 [thermal]
quickcam              115104   0
usbcore                62092   1 [printer audio uhci quickcam]
videodev                6496   1 [quickcam]
rtc                     6824   0 (autoclean)

cat /proc/ioports:

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
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-d0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d000-d0ff : 8139too
d400-d43f : 3Com Corporation 3c900 Combo [Boomerang]
  d400-d43f : 00:0b.0
d800-d80f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
dc00-dc1f : VIA Technologies, Inc. USB
  dc00-dc1f : usb-uhci
e000-e01f : VIA Technologies, Inc. USB (#2)
  e000-e01f : usb-uhci
e800-e8ff : VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller
  e800-e8ff : VIA8233

cat /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002a7c2b : Kernel code
  002a7c2c-0033c49f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : nVidia Corporation NV10 [GeForce 256 SDR]
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : nVidia Corporation NV10 [GeForce 256 SDR]
ea000000-eaffffff : VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
ec000000-ec0000ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  ec000000-ec0000ff : 8139too
ffff0000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at ea000000 (32-bit, prefetchable) [size=16M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unex Technology Corp. ND010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235 AC97 Audio Controller (rev 30)
	Subsystem: Avance Logic Inc.: Unknown device 4710
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at e800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 256
SDR] (rev 10) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

-- 
  Cristiano De Michele,
  Department of Physics,
  University "Federico II" of Naples
