Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTARSQy>; Sat, 18 Jan 2003 13:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbTARSQy>; Sat, 18 Jan 2003 13:16:54 -0500
Received: from [200.82.34.148] ([200.82.34.148]:47803 "EHLO
	prod1.trimaxcba.com") by vger.kernel.org with ESMTP
	id <S264950AbTARSQt>; Sat, 18 Jan 2003 13:16:49 -0500
Date: Sat, 18 Jan 2003 15:25:45 -0300
From: Horacio de Oro <hgdeoro@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre3-ac4 - kernel BUG at page_alloc.c:100
Message-Id: <20030118152545.489a4446.hgdeoro@yahoo.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===========================
[1.] Summary of the problem
===========================
kernel BUG at page_alloc.c:100

========================================
[4.] Kernel version (from /proc/version)
========================================
Linux version 2.4.21-pre3-ac4 (horacio@corralito) \
    (gcc version 3.2.2 20030109 (Debian prerelease)) #1 Thu Jan 16 23:14:37 ART 2003

=============================
[5.] Output of Oops.. message
=============================

Jan 17 16:21:17 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jan 17 16:21:17 corralito kernel:  printing eip:
Jan 17 16:21:17 corralito kernel: c0130698
Jan 17 16:21:17 corralito kernel: *pde = 00000000
Jan 17 16:21:17 corralito kernel: Oops: 0002
Jan 17 16:21:17 corralito kernel: CPU:    0
Jan 17 16:21:17 corralito kernel: EIP:    0010:[__free_pages_ok+600/640]    Not tainted
Jan 17 16:21:17 corralito kernel: EFLAGS: 00210246
Jan 17 16:21:17 corralito kernel: eax: 00000000   ebx: c11d754c   ecx: ccf1e000   edx: ccf1e05c
Jan 17 16:21:17 corralito kernel: esi: 00000000   edi: 000011e0   ebp: c02a16d0   esp: ccf1fdf4
Jan 17 16:21:17 corralito kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 16:21:17 corralito kernel: Process bochs-bin (pid: 494, stackpage=ccf1f000)
Jan 17 16:21:17 corralito kernel: Stack: 00000001 00200286 c8278140 c8278140 c8278140 c11d754c c013bb15 c8278140 
Jan 17 16:21:17 corralito kernel:        ce441a28 c11d754c 000011e0 c02a16d0 c012f85f c11d754c 000001d2 ccf1e000 
Jan 17 16:21:17 corralito kernel:        000001c9 000001d2 00000020 00000020 000001d2 00000020 00000006 c012faa1 
Jan 17 16:21:17 corralito kernel: Call Trace:    [try_to_free_buffers+133/240] [shrink_cache+527/768] [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [balance_classzone+85/480]
Jan 17 16:21:17 corralito kernel:   [__alloc_pages+233/384] [do_anonymous_page+104/240] [handle_mm_fault+119/272] [do_page_fault+296/1180] [process_timeout+0/16] [wake_up_process+22/32]
Jan 17 16:21:17 corralito kernel:   [run_timer_list+238/352] [bh_action+34/64] [tasklet_hi_action+70/112] [schedule+358/624] [do_page_fault+0/1180] [error_code+52/60]
Jan 17 16:21:17 corralito kernel: 
Jan 17 16:21:17 corralito kernel: Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb c1 0f 
Jan 17 16:22:09 corralito kernel:  kernel BUG at page_alloc.c:100!
Jan 17 16:22:09 corralito kernel: invalid operand: 0000
Jan 17 16:22:09 corralito kernel: CPU:    0
Jan 17 16:22:09 corralito kernel: EIP:    0010:[__free_pages_ok+52/640]    Not tainted
Jan 17 16:22:09 corralito kernel: EFLAGS: 00013282
Jan 17 16:22:09 corralito kernel: eax: 00000000   ebx: 00000000   ecx: f0001549   edx: f000ff53
Jan 17 16:22:09 corralito kernel: esi: f000ff53   edi: 00000000   ebp: 00000000   esp: cd997e54
Jan 17 16:22:09 corralito kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 16:22:09 corralito kernel: Process XFree86 (pid: 224, stackpage=cd997000)
Jan 17 16:22:09 corralito kernel: Stack: 00000006 00000000 c02a16d0 00000006 000001d2 c02a16d0 00000000 c012fb16 
Jan 17 16:22:09 corralito kernel:        ffffffff cd99605c 00000000 00000000 c01309b2 00000001 c122cf7c c02a185c 
Jan 17 16:22:09 corralito kdm[220]: Server for display :0 terminated unexpectedly
Jan 17 16:22:09 corralito kernel:        00000120 00000010 00000000 c0130bc9 cd997eb4 c02a16d0 c02a1850 000001d2 
Jan 17 16:22:09 corralito kernel: Call Trace:    [try_to_free_pages_zone+54/96] [balance_classzone+178/480] [__alloc_pages+233/384] [do_anonymous_page+104/240] [handle_mm_fault+119/272]
Jan 17 16:22:09 corralito kernel:   [do_page_fault+296/1180] [schedule_console_callback+15/32] [batch_entropy_process+128/224] [update_process_times+63/80] [bh_action+34/64] [tasklet_hi_action+70/112]
Jan 17 16:22:09 corralito kernel:   [do_IRQ+175/224] [do_page_fault+0/1180] [error_code+52/60]
Jan 17 16:22:09 corralito kernel: 
Jan 17 16:22:09 corralito kernel: Code: 0f 0b 64 00 d0 82 26 c0 8b 53 08 85 d2 74 08 0f 0b 66 00 d0 
(...)
Jan 17 16:31:13 corralito kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jan 17 16:31:13 corralito kernel:  printing eip:
Jan 17 16:31:13 corralito kernel: c0130698
Jan 17 16:31:13 corralito kernel: *pde = 00000000
Jan 17 16:31:13 corralito kernel: Oops: 0002
Jan 17 16:31:13 corralito kernel: CPU:    0
Jan 17 16:31:13 corralito kernel: EIP:    0010:[__free_pages_ok+600/640]    Not tainted
Jan 17 16:31:13 corralito kernel: EFLAGS: 00210246
Jan 17 16:31:13 corralito kernel: eax: 00000000   ebx: c10bf400   ecx: c9776000   edx: c977605c
Jan 17 16:31:13 corralito kernel: esi: 00000000   edi: 000014bf   ebp: c02a16d0   esp: c9777e60
Jan 17 16:31:13 corralito kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 16:31:13 corralito kernel: Process dd (pid: 703, stackpage=c9777000)
Jan 17 16:31:13 corralito kernel: Stack: 00000001 00200286 c45b6ec0 c45b6ec0 c45b6ec0 c10bf400 c013bb15 c45b6ec0 
Jan 17 16:31:13 corralito kernel:        cd53d568 c10bf400 000014bf c02a16d0 c012f85f c10bf400 000001d2 c9776000 
Jan 17 16:31:13 corralito kernel:        00000200 000001d2 00000020 00000020 000001d2 00000020 00000006 c012faa1 
Jan 17 16:31:13 corralito kernel: Call Trace:    [try_to_free_buffers+133/240] [shrink_cache+527/768] [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [balance_classzone+85/480]
Jan 17 16:31:13 corralito kernel:   [__alloc_pages+233/384] [generic_file_write+852/1840] [sys_write+163/304] [system_call+51/56]
Jan 17 16:31:13 corralito kernel: 
Jan 17 16:31:13 corralito kernel: Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb c1 0f 
Jan 17 16:31:13 corralito kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jan 17 16:31:13 corralito kernel:  printing eip:
Jan 17 16:31:13 corralito kernel: c0130698
Jan 17 16:31:13 corralito kernel: *pde = 00000000
Jan 17 16:31:13 corralito kernel: Oops: 0002
Jan 17 16:31:13 corralito kernel: CPU:    0
Jan 17 16:31:13 corralito kernel: EIP:    0010:[__free_pages_ok+600/640]    Not tainted
Jan 17 16:31:13 corralito kernel: EFLAGS: 00210246
Jan 17 16:31:13 corralito kernel: eax: 00000000   ebx: c10d6034   ecx: c9776000   edx: c977605c
Jan 17 16:31:13 corralito kernel: esi: 00000000   edi: 00001000   ebp: 00000001   esp: c9777c88
Jan 17 16:31:13 corralito kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 16:31:13 corralito kernel: Process dd (pid: 703, stackpage=c9777000)
Jan 17 16:31:13 corralito kernel: Stack: c01cd789 00000006 c0116577 c02a6d60 c02f1a64 00000001 00002c45 00002c45 
Jan 17 16:31:13 corralito kernel:        00000000 c5671138 00001000 00000001 c0126b88 c10d6034 00001aab 00000003 
Jan 17 16:31:13 corralito kernel:        c02a6d60 08400000 c56e2084 0804f000 00000000 c012562b cd8756c0 c56e2080 
Jan 17 16:31:13 corralito kernel: Call Trace:    [vt_console_print+89/784] [__call_console_drivers+87/96] [zap_pte_range+232/268] [zap_page_range+139/240] [exit_mmap+185/352]
Jan 17 16:31:13 corralito kernel:   [mmput+71/160] [do_exit+135/576] [die+114/128] [do_page_fault+645/1180] [bread+32/128] [is_tree_node+109/112]
Jan 17 16:31:13 corralito kernel:   [search_by_key+1384/3776] [do_page_fault+0/1180] [error_code+52/60] [__free_pages_ok+600/640] [try_to_free_buffers+133/240] [shrink_cache+527/768]
Jan 17 16:31:13 corralito kernel:   [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [balance_classzone+85/480] [__alloc_pages+233/384] [generic_file_write+852/1840] [sys_write+163/304]
Jan 17 16:31:13 corralito kernel:   [system_call+51/56]
Jan 17 16:31:13 corralito kernel: 
Jan 17 16:31:13 corralito kernel: Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb c1 0f 
Jan 17 16:31:49 corralito kernel:  mtrr: no more MTRRs available
Jan 17 16:31:49 corralito kernel: mtrr: no more MTRRs available
Jan 17 16:31:49 corralito kernel: mtrr: no more MTRRs available
Jan 17 16:31:59 corralito init: Switching to runlevel: 6
Jan 17 16:32:24 corralito kernel: SysRq : Emergency Sync
Jan 17 16:32:25 corralito kernel: Syncing device 03:06 ... OK
Jan 17 16:32:25 corralito kernel: Syncing device 03:05 ... OK
Jan 17 16:32:25 corralito kernel: Syncing device 03:08 ... OK
Jan 17 16:32:25 corralito kernel: Syncing device 03:09 ... OK
Jan 17 16:32:25 corralito kernel: Syncing device 03:0a ... OK
Jan 17 16:32:25 corralito kernel: Syncing device 03:0b ... OK
Jan 17 16:32:25 corralito kernel: Done.

====================================================
[6.] A small shell script which triggers the problem
====================================================

I couldn't reproduce this oops.
     
[7.] Environment

================================================
[7.1.] Software (output of the ver_linux script)
================================================

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux corralito 2.4.21-pre3-ac4 #1 Thu Jan 16 23:14:37 ART 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
pcmcia-cs              3.2.2
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.4
Modules Loaded         ipt_MASQUERADE iptable_nat via82cxxx_audio soundcore ac97_codec 8139too mii

=================================================
[7.2.] Processor information (from /proc/cpuinfo)
=================================================
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 7
model name	: mobile AMD Duron(tm) Processor
stepping	: 0
cpu MHz		: 946.750
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 1887.43

==============================================
[7.3.] Module information (from /proc/modules)
==============================================
hid                     9880   0 (unused)
usbcore                62432   1 [hid]
ppp_async               7680   1 (autoclean)
ipt_MASQUERADE          1336   1 (autoclean)
iptable_nat            15544   1 (autoclean) [ipt_MASQUERADE]
via82cxxx_audio        21176   0
soundcore               3940   2 [via82cxxx_audio]
ac97_codec             11080   0 [via82cxxx_audio]
8139too                15208   1
mii                     2576   0 [8139too]

============================================
[7.4.1.] Hardware information: /proc/ioports
============================================
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
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  1000-10ff : via82cxxx_audio
1400-14ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  1400-14ff : 8139too
1800-181f : VIA Technologies, Inc. USB
1840-184f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  1840-1847 : ide0
  1848-184f : ide1
1850-1853 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  1850-1853 : via82cxxx_audio
1854-1857 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  1854-1857 : via82cxxx_audio
1858-185f : Conexant HSF 56k HSFi Modem
8100-810f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

=========================================
[7.4.2.] Hardware information /proc/iomem
=========================================
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0eeeffff : System RAM
  00100000-00255866 : Kernel code
  00255867-002aeee7 : Kernel data
0eef0000-0eefefff : ACPI Tables
0eeff000-0eefffff : ACPI Non-volatile Storage
0ef00000-0effffff : System RAM
e8000000-e800ffff : Conexant HSF 56k HSFi Modem
e8010000-e80100ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e8010000-e80100ff : 8139too
e8100000-e81fffff : PCI Bus #01
  e8100000-e817ffff : S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK)
ec000000-efffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK)
ffbfe000-ffbfefff : Texas Instruments PCI1410 PC card Cardbus Controller
fff80000-ffffffff : reserved

=====================================
[7.5.] PCI information ('lspci -vvv')
=====================================
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 80)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8100000-e81fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 42)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1840 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: Compaq Computer Corporation: Unknown device 0097
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1854 [size=4]
	Region 2: I/O ports at 1850 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 4
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at 1858 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	Memory window 0: ffbfd000-ffbfd000 (prefetchable)
	Memory window 1: fbbfd000-ffbfc000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at e8010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. VT8636A [ProSavage KN133] AGP4X VGA Controller (TwisterK) (rev 01) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 0086
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4

========================
[7.6.] Other information
========================
Distribution: Debian GNU/Linux unstable

I'm not using this kernel for everyday work, I only compiled
it this week to test it. 

The kernel I use every day without ANY problem is: 
Linux version 2.4.20-rc1-acpi_20021101-imq (horacio@corralito) \
    (gcc version 3.2.1 20021103 (Debian prerelease)) #1 Thu Nov 7 23:11:11 ART 2002
It was patched with acpi (version 20021101) + the imq patch.

If you need more information, I'll be pleased to help!!!

Horacio de Oro
