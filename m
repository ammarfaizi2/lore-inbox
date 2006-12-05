Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968487AbWLERZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968487AbWLERZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968489AbWLERZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:25:29 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:33070 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968487AbWLERZ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:25:27 -0500
Date: Tue, 5 Dec 2006 19:25:13 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 2.6.19 + highmem = BUG at do_wp_page
Message-ID: <20061205172512.GA5518@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] PROBLEM: 2.6.19 + highmem = BUG at do_wp_page 
[2.] Without HIGHMEM 2.6.19 boots OK.
     But I could have some use for that unused 103MB.

     Bugging seems to start near e1000 initialization
    (ADDRCONF(NETDEV_CHANGE))
    (means e1000 may or may not be causing this)
[3.] e1000 SMP highmem
[4.] Linux version 2.6.19 (safari@safari.finland.fbi) (gcc version 3.4.6) #1 SMP Sat Dec 2 19:23:17 EET 2006
[5.] 2.6.19 without HIGHMEM works
[7.] A small shell script or example program which triggers the
     problem (if possible)
[8.] Environment
[8.1.]
Gnu C                  4.0.3
Gnu make               3.81
binutils               2.17.50.0.6-3
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.39
jfsutils               1.1.7
reiserfsprogs          3.6.19
xfsprogs               2.8.11
quota-tools            3.12.
PPP                    2.4.4
Linux C Library        2.4.90
Dynamic linker (ldd)   2.4.90
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   095
Modules Loaded         xt_CLASSIFY xt_CONNMARK ipt_connlimit ipt_TARPIT xt_length xt_multiport ip_set_iphash ip_set_nethash ip_set_portmap ipt_REJECT ip6t_LOG xt_limit ipt_LOG tcp_highspeed tcp_htcp tcp_hybla tcp_scalable tcp_vegas tcp_westwood ipt_hashlimit ip_set sch_netem sch_hfsc ip6table_mangle sch_htb iptable_mangle sch_sfq cls_fw cls_u32 cls_route iptable_nat sch_ingress sch_red ip_nat sch_tbf ipt_owner sch_teql xt_state sch_prio ip_conntrack sch_gred cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables iptable_filter i2c_algo_bit ip_tables i810 lp usb_storage parport_pc parport i2c_dev eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm e1000 iTCO_wdt ehci_hcd snd_timer snd ohci1394 ieee1394 uhci_hcd i2c_i801 pcspkr i2c_core soundcore snd_page_alloc
[8.2.]
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) D CPU 2.80GHz
stepping	: 7
cpu MHz		: 2797.360
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl cid cx16 xtpr lahf_lm
bogomips	: 5597.41

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) D CPU 2.80GHz
stepping	: 7
cpu MHz		: 2797.360
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc pni monitor ds_cpl cid cx16 xtpr lahf_lm
bogomips	: 5593.70

[8.3.]
xt_CLASSIFY 2816 5 - Live 0xf8caf000
xt_CONNMARK 3200 3 - Live 0xf8cad000
ipt_connlimit 4096 8 - Live 0xf8def000
ipt_TARPIT 4736 3 - Live 0xf8cf5000
xt_length 2944 4 - Live 0xf8ce6000
xt_multiport 4480 4 - Live 0xf8cee000
ip_set_iphash 8452 3 - Live 0xf8d01000
ip_set_nethash 9732 6 - Live 0xf8cf8000
ip_set_portmap 5632 1 - Live 0xf8ce8000
ipt_REJECT 4736 8 - Live 0xf8cf2000
ip6t_LOG 8064 2 - Live 0xf8ce3000
xt_limit 3456 8 - Live 0xf8cff000
ipt_LOG 7552 6 - Live 0xf8d0f000
tcp_highspeed 4352 0 - Live 0xf8d0c000
tcp_htcp 5120 0 - Live 0xf8d09000
tcp_hybla 3968 0 - Live 0xf8cc2000
tcp_scalable 3072 0 - Live 0xf8cc0000
tcp_vegas 4480 0 - Live 0xf8cbd000
tcp_westwood 3968 0 - Live 0xf8ca2000
ipt_hashlimit 8712 19 - Live 0xf8ca9000
ip_set 20252 6 ip_set_iphash,ip_set_nethash,ip_set_portmap, Live 0xf8c9c000
sch_netem 9472 0 - Live 0xf8c0c000
sch_hfsc 20224 0 - Live 0xf8cc5000
ip6table_mangle 3328 0 - Live 0xf8bff000
sch_htb 16896 1 - Live 0xf8ccb000
iptable_mangle 3456 1 - Live 0xf8bce000
sch_sfq 6528 8 - Live 0xf8bfc000
cls_fw 5504 0 - Live 0xf8bf9000
cls_u32 8324 7 - Live 0xf8bf5000
cls_route 7296 0 - Live 0xf8bf2000
iptable_nat 7428 0 - Live 0xf8bef000
sch_ingress 5124 1 - Live 0xf8bcb000
sch_red 7040 0 - Live 0xf8bc8000
ip_nat 16172 1 iptable_nat, Live 0xf8bc3000
sch_tbf 6656 0 - Live 0xf8bc0000
ipt_owner 2944 138 - Live 0xf8bbe000
sch_teql 6400 0 - Live 0xf8bbb000
xt_state 3072 122 - Live 0xf8b97000
sch_prio 5888 0 - Live 0xf8bb8000
ip_conntrack 43960 5 xt_CONNMARK,ipt_connlimit,iptable_nat,ip_nat,xt_state, Live 0xf8bac000
sch_gred 8960 0 - Live 0xf8ba8000
cls_rsvp 7040 0 - Live 0xf8bdd000
cls_rsvp6 7168 0 - Live 0xf8bd3000
cls_tcindex 7552 0 - Live 0xf8bd0000
sch_cbq 18048 0 - Live 0xf8bd7000
sch_dsmark 6784 0 - Live 0xf8b94000
ip6table_filter 3328 1 - Live 0xf8b92000
intelfb 35876 0 - Live 0xf8c02000
ip6_tables 13812 3 ip6t_LOG,ip6table_mangle,ip6table_filter, Live 0xf8b85000
iptable_filter 3456 1 - Live 0xf8b3f000
i2c_algo_bit 8712 1 intelfb, Live 0xf8b81000
ip_tables 12788 3 iptable_mangle,iptable_nat,iptable_filter, Live 0xf8b7c000
i810 20224 0 - Live 0xf8b76000
lp 11560 0 - Live 0xf8b72000
usb_storage 86720 0 - Live 0xf8b5b000
parport_pc 27076 1 - Live 0xf8b8a000
parport 33736 2 lp,parport_pc, Live 0xf8b51000
i2c_dev 7172 0 - Live 0xf8b4b000
eeprom 6800 0 - Live 0xf8b3c000
ohci_hcd 20996 0 - Live 0xf8b44000
binfmt_misc 10376 1 - Live 0xf8b38000
loop 57228 4 - Live 0xf8b99000
dm_mod 57112 0 - Live 0xf8c11000
video 17540 0 - Live 0xf8b32000
button 6544 0 - Live 0xf8b2f000
battery 9860 0 - Live 0xf8b2b000
asus_acpi 16792 0 - Live 0xf8b25000
ac 5124 0 - Live 0xf8b41000
tcp_cubic 6416 0 - Live 0xf8b4e000
irlan 26640 0 - Live 0xf8afc000
irda 125624 1 irlan, Live 0xf8d23000
crc_ccitt 3072 1 irda, Live 0xf8979000
8139too 24576 0 - Live 0xf8af5000
mii 6016 1 8139too, Live 0xf8aed000
snd_hda_intel 18328 0 - Live 0xf8ae7000
snd_hda_codec 170928 1 snd_hda_intel, Live 0xf8abc000
snd_seq_dummy 4100 0 - Live 0xf8aa7000
snd_seq_oss 34048 0 - Live 0xf8a7c000
snd_seq_midi_event 7680 1 snd_seq_oss, Live 0xf8a3d000
snd_seq 52048 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xf8a6e000
snd_seq_device 7820 3 snd_seq_dummy,snd_seq_oss,snd_seq, Live 0xf8a30000
snd_pcm_oss 45472 0 - Live 0xf8a61000
snd_mixer_oss 16768 1 snd_pcm_oss, Live 0xf8a86000
snd_pcm 77316 3 snd_hda_intel,snd_hda_codec,snd_pcm_oss, Live 0xf8a1c000
e1000 126528 0 - Live 0xf8b05000
iTCO_wdt 10404 0 - Live 0xf897b000
ehci_hcd 31880 0 - Live 0xf8a34000
snd_timer 22020 2 snd_seq,snd_pcm, Live 0xf8972000
snd 49252 9 snd_hda_intel,snd_hda_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live 0xf8964000
ohci1394 33840 0 - Live 0xf895a000
ieee1394 292152 1 ohci1394, Live 0xf8901000
uhci_hcd 23564 0 - Live 0xf8871000
i2c_i801 8076 0 - Live 0xf886e000
pcspkr 3712 0 - Live 0xf8806000
i2c_core 19584 4 i2c_algo_bit,i2c_dev,eeprom,i2c_i801, Live 0xf8868000
soundcore 7520 1 snd, Live 0xf8865000
snd_page_alloc 9352 2 snd_hda_intel,snd_pcm, Live 0xf8861000
[8.4.]
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00e1-00e1 : #ENUM hotswap signal register
00f0-00ff : fpu
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial
0400-047f : 0000:00:1f.0
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-0420 : ACPI PM2_CNT_BLK
  0428-042f : ACPI GPE0_BLK
  0460-047f : iTCO_wdt
0500-053f : 0000:00:1f.0
  0500-053f : pnp 00:06
0680-06ff : pnp 00:06
0cf8-0cff : PCI conf1
1000-1fff : PCI Bus #02
  1000-100f : 0000:02:00.0
    1000-1007 : ide2
    1008-100f : ide3
  1010-1017 : 0000:02:00.0
  1018-101f : 0000:02:00.0
    1018-101f : ide2
  1020-1023 : 0000:02:00.0
  1024-1027 : 0000:02:00.0
    1026-1026 : ide2
2000-201f : 0000:00:1f.3
  2000-201f : i801_smbus
2020-203f : 0000:00:1f.2
  2020-203f : ahci
2040-205f : 0000:00:1d.2
  2040-205f : uhci_hcd
2060-207f : 0000:00:1d.1
  2060-207f : uhci_hcd
2080-209f : 0000:00:1d.0
  2080-209f : uhci_hcd
20a0-20bf : 0000:00:1a.1
  20a0-20bf : uhci_hcd
20c0-20df : 0000:00:1a.0
  20c0-20df : uhci_hcd
20e0-20ff : 0000:00:19.0
  20e0-20ff : e1000
2100-210f : 0000:00:03.2
  2100-2107 : ide0
  2108-210f : ide1
2110-2117 : 0000:00:1f.2
  2110-2117 : ahci
2118-211f : 0000:00:1f.2
  2118-211f : ahci
2120-2127 : 0000:00:03.3
  2120-2127 : serial
2128-212f : 0000:00:03.2
2130-2137 : 0000:00:03.2
2138-213f : 0000:00:02.0
2140-2143 : 0000:00:1f.2
  2140-2143 : ahci
2144-2147 : 0000:00:1f.2
  2144-2147 : ahci
2148-214b : 0000:00:03.2
214c-214f : 0000:00:03.2

00000000-0008efff : System RAM
0008f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3e583fff : System RAM
  00100000-004af34a : Kernel code
  004af34b-005e8693 : Kernel data
3e584000-3e590fff : reserved
3e591000-3e64afff : System RAM
3e64b000-3e6f1fff : ACPI Non-volatile Storage
3e6f2000-3e6f2fff : System RAM
3e6f3000-3e6fefff : ACPI Tables
3e6ff000-3e6fffff : System RAM
3e700000-3effffff : reserved
40000000-4fffffff : 0000:00:02.0
50000000-500fffff : PCI Bus #06
  50000000-50003fff : 0000:06:03.0
  50004000-500047ff : 0000:06:03.0
    50004000-500047ff : ohci1394
50100000-501fffff : PCI Bus #02
  50100000-501001ff : 0000:02:00.0
50200000-502fffff : 0000:00:02.0
50300000-5031ffff : 0000:00:19.0
  50300000-5031ffff : e1000
50320000-50323fff : 0000:00:1b.0
  50320000-50323fff : ICH HD audio
50324000-50324fff : 0000:00:19.0
  50324000-50324fff : e1000
50325000-50325fff : 0000:00:03.3
50326000-503267ff : 0000:00:1f.2
  50326000-503267ff : ahci
50326800-50326bff : 0000:00:1d.7
  50326800-50326bff : ehci_hcd
50326c00-50326fff : 0000:00:1a.7
  50326c00-50326fff : ehci_hcd
50327000-503270ff : 0000:00:1f.3
50327100-5032710f : 0000:00:03.0
50400000-504fffff : PCI Bus #01
50500000-505fffff : PCI Bus #03
50600000-506fffff : PCI Bus #04
50700000-507fffff : PCI Bus #05
ffe00000-ffffffff : reserved

[8.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 82Q963/Q965 Memory Controller Hub (rev 02)
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation 82Q963/Q965 Integrated Graphics Controller (rev 02) (prog-if 00 [VGA])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50200000 (32-bit, non-prefetchable) [size=1M]
	Region 2: Memory at 40000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 2138 [size=8]
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 Communication controller: Intel Corporation 82Q963/Q965 HECI Controller (rev 02)
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 50327100 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

00:03.2 IDE interface: Intel Corporation 82Q963/Q965 PT IDER Controller (rev 02) (prog-if 85 [Master SecO PriO])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at 2130 [size=8]
	Region 1: I/O ports at 214c [size=4]
	Region 2: I/O ports at 2128 [size=8]
	Region 3: I/O ports at 2148 [size=4]
	Region 4: I/O ports at 2100 [size=16]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

00:03.3 Serial controller: Intel Corporation 82Q963/Q965 KT Controller (rev 02) (prog-if 02 [16550])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 16
	Region 0: I/O ports at 2120 [size=8]
	Region 1: Memory at 50325000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

00:19.0 Ethernet controller: Intel Corporation 82566DM Gigabit Network Connection (rev 02)
	Subsystem: Intel Corporation Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 50300000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at 50324000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 20e0 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 4: I/O ports at 20c0 [size=32]

00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #5 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 20
	Region 4: I/O ports at 20a0 [size=32]

00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at 50326c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 02)
	Subsystem: Intel Corporation Unknown device 2008
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 50320000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 50400000-504fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 1, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 50100000-501fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 2, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 50500000-505fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 3, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 50600000-506fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 4, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 50700000-507fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 5
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 5, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at 2080 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 2060 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 2040 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at 50326800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 50000000-500fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801HO (ICH8DO) LPC Interface Controller (rev 02)
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 SATA controller: Intel Corporation 82801HR/HO/HH (ICH8R/DO/DH) 6 port SATA AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 2118 [size=8]
	Region 1: I/O ports at 2144 [size=4]
	Region 2: I/O ports at 2110 [size=8]
	Region 3: I/O ports at 2140 [size=4]
	Region 4: I/O ports at 2020 [size=32]
	Region 5: Memory at 50326000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/4 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] #12 [0010]

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 02)
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 20
	Region 0: Memory at 50327000 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 2000 [size=32]

02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Marvell Technology Group Ltd. Unknown device 6101
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 1018 [size=8]
	Region 1: I/O ports at 1024 [size=4]
	Region 2: I/O ports at 1010 [size=8]
	Region 3: I/O ports at 1020 [size=4]
	Region 4: I/O ports at 1000 [size=16]
	Region 5: Memory at 50100000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1

06:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Intel Corporation Unknown device 4f43
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 50004000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at 50000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+


[8.6.]
[8.7.] I can login haven't tried to run the HIGHMEM kernel for a longer time
[X.] Other notes, patches, fixes, workarounds:
Motherboard is Intel DQ965GF (version CO96510J.86A.5493.2006.1102.1728)
with no additional PCI cards installed.

dmesg diff between 2.6.19 and 2.6.19-highmem

--- dmesg-2.6.19-1024MB	2006-12-05 16:29:42.366053454 +0200
+++ dmesg-2.6.19-1024MB-highmem	2006-12-05 17:54:29.388221988 +0200
@@ -1,4 +1,4 @@
-Linux version 2.6.19 (safari@safari.finland.fbi) (gcc version 3.4.6) #1 SMP Sat Dec 2 19:23:17 EET 2006
+Linux version 2.6.19-highmem (safari@safari.finland.fbi) (gcc version 3.4.6) #2 SMP Tue Dec 5 17:13:14 EET 2006
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
  BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
@@ -12,22 +12,24 @@
  BIOS-e820: 000000003e6ff000 - 000000003e700000 (usable)
  BIOS-e820: 000000003e700000 - 000000003f000000 (reserved)
  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
-Warning only 896MB will be used.
-Use a HIGHMEM enabled kernel.
+103MB HIGHMEM available.
 896MB LOWMEM available.
 found SMP MP-table at 000fe200
-Entering add_active_range(0, 0, 229376) 0 entries of 256 used
+Entering add_active_range(0, 0, 255744) 0 entries of 256 used
 Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->   229376
+  HighMem    229376 ->   255744
 early_node_map[1] active PFN ranges
-    0:        0 ->   229376
-On node 0 totalpages: 229376
+    0:        0 ->   255744
+On node 0 totalpages: 255744
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4064 pages, LIFO batch:0
   Normal zone: 1760 pages used for memmap
   Normal zone: 223520 pages, LIFO batch:31
+  HighMem zone: 206 pages used for memmap
+  HighMem zone: 26162 pages, LIFO batch:7
 DMI 2.4 present.
 ACPI: RSDP (v000 INTEL                                 ) @ 0x000fe020
 ACPI: RSDT (v001 INTEL  DQ965GF  0x00001575      0x01000013) @ 0x3e6fd038
@@ -58,8 +60,8 @@
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 40000000 (gap: 3f000000:c0e00000)
-Detected 2797.425 MHz processor.
-Built 1 zonelists.  Total pages: 227584
+Detected 2797.363 MHz processor.
+Built 1 zonelists.  Total pages: 253746
 Kernel command line: ro root=/dev/hdf1 all-generic-ide
 IDE generic will claim all unknown PCI IDE storage controllers.
 mapped APIC to ffffd000 (fee00000)
@@ -71,16 +73,17 @@
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 902496k/917504k available (3772k kernel code, 14432k reserved, 1252k data, 252k init, 0k highmem)
+Memory: 1006228k/1022976k available (3778k kernel code, 15320k reserved, 1259k data, 256k init, 104704k highmem)
 virtual kernel memory layout:
-    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
-    vmalloc : 0xf8800000 - 0xfffb5000   ( 119 MB)
+    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
+    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
+    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
-      .init : 0xc067f000 - 0xc06be000   ( 252 kB)
-      .data : 0xc04af34b - 0xc05e8694   (1252 kB)
-      .text : 0xc0100000 - 0xc04af34b   (3772 kB)
+      .init : 0xc0681000 - 0xc06c1000   ( 256 kB)
+      .data : 0xc04b0aa3 - 0xc05eb734   (1259 kB)
+      .text : 0xc0100000 - 0xc04b0aa3   (3778 kB)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 5597.40 BogoMIPS (lpj=2798703)
+Calibrating delay using timer specific routine.. 5597.38 BogoMIPS (lpj=2798693)
 Security Framework v1.0.0 initialized
 SELinux:  Initializing.
 SELinux:  Starting in permissive mode
@@ -98,13 +101,14 @@
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
+CPU0: Thermal monitoring enabled
 Checking 'hlt' instruction... OK.
 Freeing SMP alternatives: 20k freed
 ACPI: Core revision 20060707
 CPU0: Intel(R) Pentium(R) D CPU 2.80GHz stepping 07
 Booting processor 1/1 eip 2000
 Initializing CPU#1
-Calibrating delay using timer specific routine.. 5593.69 BogoMIPS (lpj=2796845)
+Calibrating delay using timer specific routine.. 5593.71 BogoMIPS (lpj=2796855)
 CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000001
 monitor/mwait feature present.
 CPU: Trace cache: 12K uops, L1 D cache: 16K
@@ -115,13 +119,14 @@
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#1.
 CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
+CPU1: Thermal monitoring enabled
 CPU1: Intel(R) Pentium(R) D CPU 2.80GHz stepping 07
 Total of 2 processors activated (11191.09 BogoMIPS).
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
 checking TSC synchronization across 2 CPUs: passed.
 Brought up 2 CPUs
-migration_cost=491
+migration_cost=429
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
@@ -208,9 +213,11 @@
 TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
 TCP: Hash tables configured (established 131072 bind 65536)
 TCP reno registered
+Machine check exception polling timer started.
 IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
 audit: initializing netlink socket (disabled)
-audit(1165328778.619:1): initialized
+audit(1165333893.665:1): initialized
+highmem bounce pool size: 64 pages
 Total HugeTLB memory allocated, 0
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
@@ -312,7 +319,7 @@
 hdf: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
 hdf: cache flushes supported
  hdf: hdf1 hdf2 < hdf5 hdf6 hdf7 hdf8 hdf9 >
-hde: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
+hde: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 ide-floppy driver 0.99.newide
 aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2 loaded
@@ -350,10 +357,10 @@
 serio: i8042 KBD port at 0x60,0x64 irq 1
 serio: i8042 AUX port at 0x60,0x64 irq 12
 mice: PS/2 mouse device common for all mice
-EDAC MC: Ver: 2.0.1 Dec  2 2006
+EDAC MC: Ver: 2.0.1 Dec  5 2006
 perfctr/x86.c: CPU 1: cpuid_ebx(1) 0x01020800, cpuid_edx(1) 0xbfebfbff, cpuid_eax(4) 0x04000121, cpuid_maxlev 5, max_cores_per_package 2, SMT_ID 0
 perfctr/x86.c: CPU 0: cpuid_ebx(1) 0x00020800, cpuid_edx(1) 0xbfebfbff, cpuid_eax(4) 0x04000121, cpuid_maxlev 5, max_cores_per_package 2, SMT_ID 0
-perfctr: driver 2.6.25, cpu type Intel P4 at 2797425 kHz
+perfctr: driver 2.6.25, cpu type Intel P4 at 2797363 kHz
 Netfilter messages via NETLINK v0.30.
 TCP bic registered
 Initializing XFRM netlink socket
@@ -364,17 +371,18 @@
 NET: Registered protocol family 17
 Starting balanced_irq
 Using IPI Shortcut mode
-random: rekey_late entropy_count=31
+random: rekey_late entropy_count=34
 drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
 Time: tsc clocksource has been installed.
 md: Autodetecting RAID arrays.
 md: autorun ...
 md: ... autorun DONE.
 XFS mounting filesystem hdf1
-Ending clean XFS mount for filesystem: hdf1
+Starting XFS recovery on filesystem: hdf1 (logdev: internal)
+Ending XFS recovery on filesystem: hdf1 (logdev: internal)
 VFS: Mounted root (xfs filesystem) readonly.
-Freeing unused kernel memory: 252k freed
-Write protecting the kernel read-only data: 671k
+Freeing unused kernel memory: 256k freed
+Write protecting the kernel read-only data: 672k
 security:  3 users, 6 roles, 1124 types, 128 bools, 16 sens, 256 cats
 security:  55 classes, 34457 rules
 SELinux:  Completing initialization.

.....................................

2.6.19-highmem dmesg

Linux version 2.6.19-highmem (safari@safari.finland.fbi) (gcc version 3.4.6) #2 SMP Tue Dec 5 17:13:14 EET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
 BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003e584000 (usable)
 BIOS-e820: 000000003e584000 - 000000003e591000 (reserved)
 BIOS-e820: 000000003e591000 - 000000003e64b000 (usable)
 BIOS-e820: 000000003e64b000 - 000000003e6f2000 (ACPI NVS)
 BIOS-e820: 000000003e6f2000 - 000000003e6f3000 (usable)
 BIOS-e820: 000000003e6f3000 - 000000003e6ff000 (ACPI data)
 BIOS-e820: 000000003e6ff000 - 000000003e700000 (usable)
 BIOS-e820: 000000003e700000 - 000000003f000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
103MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe200
Entering add_active_range(0, 0, 255744) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   255744
early_node_map[1] active PFN ranges
    0:        0 ->   255744
On node 0 totalpages: 255744
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 206 pages used for memmap
  HighMem zone: 26162 pages, LIFO batch:7
DMI 2.4 present.
ACPI: RSDP (v000 INTEL                                 ) @ 0x000fe020
ACPI: RSDT (v001 INTEL  DQ965GF  0x00001575      0x01000013) @ 0x3e6fd038
ACPI: FADT (v001 INTEL  DQ965GF  0x00001575 MSFT 0x01000013) @ 0x3e6fc000
ACPI: MADT (v001 INTEL  DQ965GF  0x00001575 MSFT 0x01000013) @ 0x3e6f6000
ACPI: WDDT (v001 INTEL  DQ965GF  0x00001575 MSFT 0x01000013) @ 0x3e6f5000
ACPI: MCFG (v001 INTEL  DQ965GF  0x00001575 MSFT 0x01000013) @ 0x3e6f4000
ACPI: ASF! (v032 INTEL  DQ965GF  0x00001575 MSFT 0x01000013) @ 0x3e6f3000
ACPI: TCPA (v001 INTEL  TIANO    0x00000002 MSFT 0x01000013) @ 0x3e64b000
ACPI: DSDT (v001 INTEL  DQ965GF  0x00001575 MSFT 0x01000013) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f000000:c0e00000)
Detected 2797.405 MHz processor.
Built 1 zonelists.  Total pages: 253746
Kernel command line: ro root=/dev/hdf1 all-generic-ide
IDE generic will claim all unknown PCI IDE storage controllers.
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1006228k/1022976k available (3778k kernel code, 15320k reserved, 1259k data, 256k init, 104704k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0681000 - 0xc06c1000   ( 256 kB)
      .data : 0xc04b0aa3 - 0xc05eb734   (1259 kB)
      .text : 0xc0100000 - 0xc04b0aa3   (3778 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5597.37 BogoMIPS (lpj=2798689)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 20k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Pentium(R) D CPU 2.80GHz stepping 07
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5593.69 BogoMIPS (lpj=2796846)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000001
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) D CPU 2.80GHz stepping 07
Total of 2 processors activated (11191.07 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=480
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:02.0
PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:06: ioport range 0x500-0x53f has been reserved
pnp: 00:06: ioport range 0x400-0x47f could not be reserved
pnp: 00:06: ioport range 0x680-0x6ff has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: 50400000-504fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 1000-1fff
  MEM window: 50100000-501fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: 50500000-505fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
  IO window: disabled.
  MEM window: 50600000-506fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: 50700000-507fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: 50000000-500fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
random: extract_entropy called before initializing
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1165334700.594:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, security attributes, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
cpcihp_generic: not configured, disabling.
pciehp: HPC vendor_id 8086 device_id 283f ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.0
pciehp: HPC vendor_id 8086 device_id 2841 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.1
pciehp: HPC vendor_id 8086 device_id 2843 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.2
pciehp: HPC vendor_id 8086 device_id 2845 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.3
pciehp: HPC vendor_id 8086 device_id 2847 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.4
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
random: create_entropy_store() finished digestsize=32 keysize=32
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 965Q Chipset.
agpgart: Detected 7676K stolen memory.
agpgart: AGP aperture is 512M @ 0x40000000
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:00:03.3[B] -> GSI 17 (level, low) -> IRQ 16
0000:00:03.3: ttyS1 at I/O 0x2120 (irq = 16) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Unknown: IDE controller at PCI slot 0000:00:03.2
ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 18 (level, low) -> IRQ 18
Unknown: chipset revision 2
Unknown: 100% native mode on irq 18
    ide0: BM-DMA at 0x2100-0x2107, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2108-0x210f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
Unknown: IDE controller at PCI slot 0000:02:00.0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 16
Unknown: chipset revision 177
Unknown: 100% native mode on irq 16
    ide2: BM-DMA at 0x1000-0x1007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x1008-0x100f, BIOS settings: hdg:DMA, hdh:DMA
Probing IDE interface ide2...
hde: LITE-ON LTR-52246S, ATAPI CD/DVD-ROM drive
hdf: ST3160023A, ATA DISK drive
ide2 at 0x1018-0x101f,0x1026 on irq 16
Probing IDE interface ide3...
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide3...
hdf: max request size: 512KiB
hdf: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
hdf: cache flushes supported
 hdf: hdf1 hdf2 < hdf5 hdf6 hdf7 hdf8 hdf9 >
hde: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2 loaded
stex: Promise SuperTrak EX Driver version: 3.0.0.1
st: Version 20050830, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xF8804100 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF8804180 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF8804200 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF8804280 ctl 0x0 bmdma 0x0 irq 19
ata5: SATA max UDMA/133 cmd 0xF8804300 ctl 0x0 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xF8804380 ctl 0x0 bmdma 0x0 irq 19
scsi0 : ahci
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi4 : ahci
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : ahci
ata6: SATA link down (SStatus 0 SControl 300)
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.1 Dec  5 2006
perfctr/x86.c: CPU 1: cpuid_ebx(1) 0x01020800, cpuid_edx(1) 0xbfebfbff, cpuid_eax(4) 0x04000121, cpuid_maxlev 5, max_cores_per_package 2, SMT_ID 0
perfctr/x86.c: CPU 0: cpuid_ebx(1) 0x00020800, cpuid_edx(1) 0xbfebfbff, cpuid_eax(4) 0x04000121, cpuid_maxlev 5, max_cores_per_package 2, SMT_ID 0
perfctr: driver 2.6.25, cpu type Intel P4 at 2797405 kHz
Netfilter messages via NETLINK v0.30.
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
random: rekey_late entropy_count=31
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
XFS mounting filesystem hdf1
Ending clean XFS mount for filesystem: hdf1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 256k freed
Write protecting the kernel read-only data: 672k
security:  3 users, 6 roles, 1124 types, 128 bools, 16 sens, 256 cats
security:  55 classes, 34457 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hdf1, type xfs), uses xattr
SELinux: initialized (dev vperfctrfs, type vperfctrfs), not configured for labeling
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1165334711.972:2): policy loaded auid=4294967295
audit(1165334711.973:3): avc:  granted  { load_policy } for  pid=1 comm="init" scontext=system_u:system_r:kernel_t:s0-s9:c0.c127 tcontext=system_u:object_r:security_t:s0 tclass=security
audit(1165334711.974:4): avc:  denied  { transition } for  pid=1 comm="init" name="init" dev=hdf1 ino=21030898 scontext=system_u:system_r:kernel_t:s0-s9:c0.c127 tcontext=system_u:system_r:init_t:s0-s15:c0.c255 tclass=process
audit(1165334712.351:5): avc:  denied  { read write } for  pid=483 comm="hostname" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:hostname_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334712.484:6): avc:  denied  { read write } for  pid=486 comm="mount" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:mount_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
audit(1165334714.903:7): avc:  denied  { search } for  pid=873 comm="pam_console_app" name="var" dev=hdf1 ino=4194432 scontext=system_u:system_r:pam_console_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=dir
audit(1165334714.906:8): avc:  denied  { read } for  pid=873 comm="pam_console_app" name="/" dev=tmpfs ino=909 scontext=system_u:system_r:pam_console_t:s0-s15:c0.c255 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
audit(1165334714.907:9): avc:  denied  { getattr } for  pid=873 comm="pam_console_app" name="/" dev=tmpfs ino=909 scontext=system_u:system_r:pam_console_t:s0-s15:c0.c255 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
audit(1165334714.907:10): avc:  denied  { search } for  pid=873 comm="pam_console_app" name="/" dev=tmpfs ino=909 scontext=system_u:system_r:pam_console_t:s0-s15:c0.c255 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0x50326c00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0x50326800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 17, io base 0x000020c0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x000020a0
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (08-Oct-2006)
iTCO_wdt: Found a ICH8DO TCO device (Version=2, TCOBASE=0x0460)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00002080
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
input: PC Speaker as /class/input/input0
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00002060
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00002040
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 20 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:19.0 to 64
usb 5-1: new low speed USB device using uhci_hcd and address 2
e1000: 0000:00:19.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:19:d1:00:5f:01
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 19 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[50004000-500047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 21 (level, low) -> IRQ 21
usb 5-1: configuration #1 chosen from 1 choice
input: Chicony Saitek Eclipse II Keyboard as /class/input/input1
input: USB HID v1.11 Keyboard [Chicony Saitek Eclipse II Keyboard] on usb-0000:00:1d.0-1
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1b.0 to 64
input: Chicony Saitek Eclipse II Keyboard as /class/input/input2
input,hiddev96: USB HID v1.11 Device [Chicony Saitek Eclipse II Keyboard] on usb-0000:00:1d.0-1
usb 5-2: new full speed USB device using uhci_hcd and address 3
usb 5-2: configuration #1 chosen from 1 choice
input: Tempest Habu Mouse as /class/input/input3
input: USB HID v1.00 Mouse [Tempest Habu Mouse] on usb-0000:00:1d.0-2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0090270001b66bbe]
floppy0: no floppy controllers found
8139too Fast Ethernet driver 0.9.28
NET: Registered protocol family 23
TCP cubic registered
audit(1165334720.988:11): avc:  denied  { read write } for  pid=1631 comm="hwclock" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:hwclock_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334720.989:12): avc:  denied  { search } for  pid=1631 comm="hwclock" name="/" dev=tmpfs ino=909 scontext=system_u:system_r:hwclock_t:s0-s15:c0.c255 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
audit(1165334722.615:13): avc:  denied  { read write } for  pid=1709 comm="restorecon" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:restorecon_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
loop: loaded (max 8 devices)
audit(1165334724.328:22): avc:  denied  { read write } for  pid=1759 comm="fsck" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:fsadm_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334724.407:23): avc:  denied  { read write } for  pid=1759 comm="fsck" name="control" dev=tmpfs ino=6148 scontext=system_u:system_r:fsadm_t:s0-s15:c0.c255 tcontext=system_u:object_r:lvm_control_t:s0 tclass=chr_file
audit(1165334724.407:24): avc:  denied  { ioctl } for  pid=1759 comm="fsck" name="control" dev=tmpfs ino=6148 scontext=system_u:system_r:fsadm_t:s0-s15:c0.c255 tcontext=system_u:object_r:lvm_control_t:s0 tclass=chr_file
XFS mounting filesystem hdf7
Ending clean XFS mount for filesystem: hdf7
SELinux: initialized (dev hdf7, type xfs), uses xattr
XFS mounting filesystem hdf8
Ending clean XFS mount for filesystem: hdf8
SELinux: initialized (dev hdf8, type xfs), uses xattr
XFS mounting filesystem hdf9
Ending clean XFS mount for filesystem: hdf9
SELinux: initialized (dev hdf9, type xfs), uses xattr
audit(1165334725.746:25): avc:  denied  { read write } for  pid=1785 comm="quotaon" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:quota_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334727.291:26): avc:  denied  { read write } for  pid=1832 comm="pam_console_app" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:pam_console_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334727.647:27): avc:  denied  { read write } for  pid=1842 comm="restorecon" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:restorecon_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334727.649:28): avc:  denied  { read } for  pid=1842 comm="restorecon" name="tmp" dev=hdf1 ino=143208 scontext=system_u:system_r:restorecon_t:s0-s15:c0.c255 tcontext=system_u:object_r:tmp_t:s0 tclass=lnk_file
audit(1165334727.814:29): avc:  denied  { read write } for  pid=1843 comm="swapon" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:fsadm_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334728.259:30): avc:  denied  { getattr } for  pid=1845 comm="mkswap" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:fsadm_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
audit(1165334728.259:31): avc:  denied  { ioctl } for  pid=1845 comm="mkswap" name="console" dev=hdf1 ino=58720608 scontext=system_u:system_r:fsadm_t:s0-s15:c0.c255 tcontext=root:object_r:file_t:s0 tclass=chr_file
Adding 1004016k swap on /dev/loop7.  Priority:5 extents:1 across:1004016k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.base_reachable_time; Use net.ipv6.neigh.lo.base_reachable_time_ms instead.
audit(1165334731.364:32): avc:  denied  { search } for  pid=2006 comm="ifconfig" name="/" dev=hdf7 ino=128 scontext=system_u:system_r:ifconfig_t:s0-s15:c0.c255 tcontext=system_u:object_r:var_t:s0 tclass=dir
audit(1165334731.364:33): avc:  denied  { search } for  pid=2006 comm="ifconfig" name="run" dev=hdf7 ino=12691733 scontext=system_u:system_r:ifconfig_t:s0-s15:c0.c255 tcontext=system_u:object_r:var_run_t:s0 tclass=dir
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
audit(1165334734.345:34): avc:  denied  { search } for  pid=2186 comm="irqbalance" name="/" dev=tmpfs ino=909 scontext=system_u:system_r:irqbalance_t:s0-s15:c0.c255 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
e1000: eth0: e1000_reset: Hardware Error
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
ip_tables: (C) 2000-2006 Netfilter Core Team
lp0: using parport0 (interrupt-driven).
lp0: console ready
ip6_tables: (C) 2000-2006 Netfilter Core Team
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
ip_conntrack version 2.4 (7992 buckets, 63936 max) - 232 bytes per conntrack
u32 classifier
    Performance counters on
    OLD policer on 
netem: version 1.2
TCP westwood registered
TCP vegas registered
TCP scalable registered
TCP hybla registered
TCP htcp registered
TCP highspeed registered
ADDRCONF(NETDEV_UP): eth0: link is not ready
audit(1165334737.150:39): avc:  denied  { search } for  pid=2608 comm="mii-tool" name="/" dev=hdf7 ino=128 scontext=system_u:system_r:ifconfig_t:s0-s15:c0.c255 tcontext=system_u:object_r:var_t:s0 tclass=dir
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
BUG: unable to handle kernel paging request at virtual address fffb9dc0
 printing eip:
c01591b2
*pde = 00003067
*pte = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c01591b2>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at do_wp_page+0xe5/0x388
eax: fffb8000   ebx: fffb9000   ecx: 00000090   edx: 00000000
esi: fffb9dc0   edi: fffb8dc0   ebp: f6f89f24   esp: f6f89ef0
ds: 007b   es: 007b   ss: 0068
Process udevd (pid: 2672, ti=f6f88000 task=c1975550 task.ti=f6f88000)
Stack: fffb8000 00000000 00000000 00000000 00000002 c1766f20 c17baf60 800af3b8 
       f74a04c4 f740f040 3dd7b045 f778c800 f6f2b2bc f6f89f5c c015a385 f6f2b2bc 
       f778c800 c16de56c 3dd7b045 c16de56c 3dd7b045 800af3b8 f74a04c4 f740f040 
Call Trace:
 [<c015a385>] __handle_mm_fault+0x1e3/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<b7dc1cc1>] 0xb7dc1cc1
 =======================
Code: 01 00 00 ba 03 00 00 00 8b 45 e4 e8 31 d7 fb ff ba 04 00 00 00 89 c3 8b 45 e0 e8 22 d7 fb ff 89 de b9 00 04 00 00 89 45 cc 89 c7 <f3> a5 ba 03 00 00 00 89 d8 e8 91 d7 fb ff ba 04 00 00 00 8b 45 
EIP: [<c01591b2>] do_wp_page+0xe5/0x388 SS:ESP 0068:f6f89ef0
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1
 [<c0103b64>] dump_trace+0x215/0x21a
 [<c0103c0c>] show_trace_log_lvl+0x1a/0x30
 [<c0103c34>] show_trace+0x12/0x14
 [<c0103d31>] dump_stack+0x19/0x1b
 [<c011efff>] __might_sleep+0xa3/0xab
 [<c0138175>] down_read+0x15/0x29
 [<c012ed57>] blocking_notifier_call_chain+0x1c/0x42
 [<c0122bf9>] profile_task_exit+0x11/0x13
 [<c01244da>] do_exit+0x1c/0x43b
 [<c0104243>] do_trap+0x0/0xbd
 [<c01159e6>] do_page_fault+0x34b/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<c01591b2>] do_wp_page+0xe5/0x388
 [<c015a385>] __handle_mm_fault+0x1e3/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<b7dc1cc1>] 0xb7dc1cc1
 =======================
note: udevd[2672] exited with preempt_count 2
audit(1165334740.754:40): avc:  denied  { write } for  pid=2732 comm="ip" name="dhclient-ip-addr.txt" dev=hdf1 ino=41992565 scontext=system_u:system_r:ifconfig_t:s0-s15:c0.c255 tcontext=system_u:object_r:etc_t:s0 tclass=file
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
BUG: unable to handle kernel paging request at virtual address fffb9e80
 printing eip:
c01591b2
*pde = 00003067
*pte = 00000000
Oops: 0000 [#2]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c01591b2>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at do_wp_page+0xe5/0x388
eax: fffb8000   ebx: fffb9000   ecx: 00000060   edx: 00000000
esi: fffb9e80   edi: fffb8e80   ebp: f6b27f24   esp: f6b27ef0
ds: 007b   es: 007b   ss: 0068
Process chain-flush (pid: 2816, ti=f6b26000 task=f7405030 task.ti=f6b26000)
Stack: fffb8000 00000000 00000000 00000000 00000002 c17525c0 c17550e0 4144b0c4 
       f70a41d0 f7d5d040 3aa87045 f6519414 f660412c f6b27f5c c015a385 f660412c 
       f6519414 c16cc08c 3aa87045 c16cc08c 3aa87045 4144b0c4 f70a41d0 f7d5d040 
Call Trace:
 [<c015a385>] __handle_mm_fault+0x1e3/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<413a56b9>] 0x413a56b9
 =======================
Code: 01 00 00 ba 03 00 00 00 8b 45 e4 e8 31 d7 fb ff ba 04 00 00 00 89 c3 8b 45 e0 e8 22 d7 fb ff 89 de b9 00 04 00 00 89 45 cc 89 c7 <f3> a5 ba 03 00 00 00 89 d8 e8 91 d7 fb ff ba 04 00 00 00 8b 45 
EIP: [<c01591b2>] do_wp_page+0xe5/0x388 SS:ESP 0068:f6b27ef0
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1
 [<c0103b64>] dump_trace+0x215/0x21a
 [<c0103c0c>] show_trace_log_lvl+0x1a/0x30
 [<c0103c34>] show_trace+0x12/0x14
 [<c0103d31>] dump_stack+0x19/0x1b
 [<c011efff>] __might_sleep+0xa3/0xab
 [<c0138175>] down_read+0x15/0x29
 [<c012ed57>] blocking_notifier_call_chain+0x1c/0x42
 [<c0122bf9>] profile_task_exit+0x11/0x13
 [<c01244da>] do_exit+0x1c/0x43b
 [<c0104243>] do_trap+0x0/0xbd
 [<c01159e6>] do_page_fault+0x34b/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<c01591b2>] do_wp_page+0xe5/0x388
 [<c015a385>] __handle_mm_fault+0x1e3/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<413a56b9>] 0x413a56b9
 =======================
note: chain-flush[2816] exited with preempt_count 2
------------[ cut here ]------------
kernel BUG at arch/i386/mm/highmem.c:42!
invalid opcode: 0000 [#3]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c0116926>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at kmap_atomic+0x5e/0x89
eax: c0003ee0   ebx: fffb8000   ecx: c1754140   edx: 3a92e163
esi: f76be1d0   edi: f76be1d0   ebp: f659dedc   esp: f659ded8
ds: 007b   es: 007b   ss: 0068
Process chain-flush (pid: 2813, ti=f659c000 task=f7bf1030 task.ti=f659c000)
Stack: c1754140 f659df24 c0159f52 00000001 fffb9000 00000000 00000001 00000000 
       00000000 00000000 f7b7774c c178ab00 b7efb010 f76be1d0 f770c040 00000002 
       00000000 f753bb7c f6bb8bec f659df5c c015a348 f6bb8bec f753bb7c 00000001 
Call Trace:
 [<c0159f52>] do_no_page+0x1cf/0x2cb
 [<c015a348>] __handle_mm_fault+0x1a6/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<41015377>] 0x41015377
 =======================
Code: ff ff 8b 40 10 8d 14 40 8d 14 90 01 da 8b 1d b0 e5 55 c0 8d 42 43 c1 e2 02 c1 e0 0c 29 c3 a1 b4 dd 6c c0 29 d0 8b 10 85 d2 74 08 <0f> 0b 2a 00 23 d8 4e c0 2b 0d 00 f8 6f c0 c1 f9 05 c1 e1 0c 0b 
EIP: [<c0116926>] kmap_atomic+0x5e/0x89 SS:ESP 0068:f659ded8
 <6>note: chain-flush[2813] exited with preempt_count 2
------------[ cut here ]------------
kernel BUG at arch/i386/mm/highmem.c:42!
invalid opcode: 0000 [#4]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c0116926>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at kmap_atomic+0x5e/0x89
eax: c0003ee0   ebx: fffb8000   ecx: c17a2a60   edx: 3a92e163
esi: f64e7e40   edi: c16c9cec   ebp: f6b27e98   esp: f6b27e94
ds: 007b   es: 007b   ss: 0068
Process run (pid: 2817, ti=f6b26000 task=f7405030 task.ti=f6b26000)
Stack: fffb9000 f6b27ed4 c01591a6 00000800 c05e0e00 fffb9000 00000000 00000002 
       c17a2a60 c1752f80 b7f90918 f70a45c0 f764a3c0 3a97c045 f658cb7c f64e7e40 
       f6b27f0c c015a385 f64e7e40 f658cb7c c16c9cec 3a97c045 c16c9cec 3a97c045 
Call Trace:
 [<c01591a6>] do_wp_page+0xd9/0x388
 [<c015a385>] __handle_mm_fault+0x1e3/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<c02bbfe6>] __put_user_4+0x12/0x18
DWARF2 unwinder stuck at __put_user_4+0x12/0x18

Leftover inexact backtrace:

 [<c0102bbe>] ret_from_fork+0x6/0x1c
 =======================
Code: ff ff 8b 40 10 8d 14 40 8d 14 90 01 da 8b 1d b0 e5 55 c0 8d 42 43 c1 e2 02 c1 e0 0c 29 c3 a1 b4 dd 6c c0 29 d0 8b 10 85 d2 74 08 <0f> 0b 2a 00 23 d8 4e c0 2b 0d 00 f8 6f c0 c1 f9 05 c1 e1 0c 0b 
EIP: [<c0116926>] kmap_atomic+0x5e/0x89 SS:ESP 0068:f6b27e94
 <6>note: run[2817] exited with preempt_count 2
------------[ cut here ]------------
kernel BUG at arch/i386/mm/highmem.c:42!
invalid opcode: 0000 [#5]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c0116926>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at kmap_atomic+0x5e/0x89
eax: c0003ee0   ebx: fffb8000   ecx: c1752c60   edx: 3a92e163
esi: f64e7e40   edi: c16c9cec   ebp: f6f69e98   esp: f6f69e94
ds: 007b   es: 007b   ss: 0068
Process run (pid: 2818, ti=f6f68000 task=f7405550 task.ti=f6f68000)
Stack: fffb9000 f6f69ed4 c01591a6 00000001 f7405550 f7bb1ac0 00000000 00000002 
       c1752c60 c1752f80 b7f90918 f74dea58 f764a3c0 3a97c045 f658cb7c f64e7e40 
       f6f69f0c c015a385 f64e7e40 f658cb7c c16c9cec 3a97c045 c16c9cec 3a97c045 
Call Trace:
 [<c01591a6>] do_wp_page+0xd9/0x388
 [<c015a385>] __handle_mm_fault+0x1e3/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<c02bbfe6>] __put_user_4+0x12/0x18
DWARF2 unwinder stuck at __put_user_4+0x12/0x18

Leftover inexact backtrace:

 [<c0102bbe>] ret_from_fork+0x6/0x1c
 =======================
Code: ff ff 8b 40 10 8d 14 40 8d 14 90 01 da 8b 1d b0 e5 55 c0 8d 42 43 c1 e2 02 c1 e0 0c 29 c3 a1 b4 dd 6c c0 29 d0 8b 10 85 d2 74 08 <0f> 0b 2a 00 23 d8 4e c0 2b 0d 00 f8 6f c0 c1 f9 05 c1 e1 0c 0b 
EIP: [<c0116926>] kmap_atomic+0x5e/0x89 SS:ESP 0068:f6f69e94
 <6>note: run[2818] exited with preempt_count 2
eth0: no IPv6 routers present
BUG: unable to handle kernel paging request at virtual address fffb9f40
 printing eip:
c01505af
*pde = 00003067
*pte = 00000000
Oops: 0002 [#6]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c01505af>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at prep_new_page+0xb5/0x106
eax: 00000000   ebx: c175eb80   ecx: 00000030   edx: 00000000
esi: 00000000   edi: fffb9f40   ebp: f6989e68   esp: f6989e40
ds: 007b   es: 007b   ss: 0068
Process dnscache-epoll- (pid: 2778, ti=f6988000 task=f76da550 task.ti=f6988000)
Stack: fffb9000 00000006 00000001 00000000 000280d2 00000000 c175eb80 00000001 
       00000246 c0561b80 f6989e94 c0150add c0561c0c 00000002 c0561c00 00000000 
       c175eb80 00000000 c0561b80 c0562220 00000044 f6989ec4 c0150cb6 000280d2 
Call Trace:
 [<c0150add>] buffered_rmqueue+0x93/0x134
 [<c0150cb6>] get_page_from_freelist+0xa2/0xb9
 [<c0150d1b>] __alloc_pages+0x4e/0x2b0
 [<c0159c69>] do_anonymous_page+0x43/0x15d
 [<c015a274>] __handle_mm_fault+0xd2/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<0805417d>] 0x805417d
 =======================
Code: e4 00 00 00 00 d3 e0 83 f8 00 7e 3d 31 f6 89 45 e0 89 fb ba 03 00 00 00 89 d8 e8 25 63 fc ff b9 00 04 00 00 89 45 d8 89 c7 89 f0 <f3> ab ba 03 00 00 00 8b 45 d8 e8 93 63 fc ff 83 45 e4 01 83 c3 
EIP: [<c01505af>] prep_new_page+0xb5/0x106 SS:ESP 0068:f6989e40
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1
 [<c0103b64>] dump_trace+0x215/0x21a
 [<c0103c0c>] show_trace_log_lvl+0x1a/0x30
 [<c0103c34>] show_trace+0x12/0x14
 [<c0103d31>] dump_stack+0x19/0x1b
 [<c011efff>] __might_sleep+0xa3/0xab
 [<c0138175>] down_read+0x15/0x29
 [<c012ed57>] blocking_notifier_call_chain+0x1c/0x42
 [<c0122bf9>] profile_task_exit+0x11/0x13
 [<c01244da>] do_exit+0x1c/0x43b
 [<c0104243>] do_trap+0x0/0xbd
 [<c01159e6>] do_page_fault+0x34b/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<c01505af>] prep_new_page+0xb5/0x106
 [<c0150add>] buffered_rmqueue+0x93/0x134
 [<c0150cb6>] get_page_from_freelist+0xa2/0xb9
 [<c0150d1b>] __alloc_pages+0x4e/0x2b0
 [<c0159c69>] do_anonymous_page+0x43/0x15d
 [<c015a274>] __handle_mm_fault+0xd2/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<0805417d>] 0x805417d
 =======================
note: dnscache-epoll-[2778] exited with preempt_count 1
BUG: unable to handle kernel paging request at virtual address fffac380
 printing eip:
c01505af
*pde = 00003067
*pte = 00000000
Oops: 0002 [#7]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    1
EIP:    0060:[<c01505af>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at prep_new_page+0xb5/0x106
eax: 00000000   ebx: c174ad20   ecx: 00000320   edx: 00000000
esi: 00000000   edi: fffac380   ebp: f6fb1e68   esp: f6fb1e40
ds: 007b   es: 007b   ss: 0068
Process dnscache-epoll- (pid: 2904, ti=f6fb0000 task=f67c9030 task.ti=f6fb0000)
Stack: fffac000 00000006 00000001 00000000 000280d2 00000000 c174ad20 00000001 
       00000246 c0561b80 f6fb1e94 c0150add c0561c8c 00000002 c0561c80 00000000 
       c174ad20 00000000 c0561b80 c0562220 00000044 f6fb1ec4 c0150cb6 000280d2 
Call Trace:
 [<c0150add>] buffered_rmqueue+0x93/0x134
 [<c0150cb6>] get_page_from_freelist+0xa2/0xb9
 [<c0150d1b>] __alloc_pages+0x4e/0x2b0
 [<c0159c69>] do_anonymous_page+0x43/0x15d
 [<c015a274>] __handle_mm_fault+0xd2/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<0805417d>] 0x805417d
 =======================
Code: e4 00 00 00 00 d3 e0 83 f8 00 7e 3d 31 f6 89 45 e0 89 fb ba 03 00 00 00 89 d8 e8 25 63 fc ff b9 00 04 00 00 89 45 d8 89 c7 89 f0 <f3> ab ba 03 00 00 00 8b 45 d8 e8 93 63 fc ff 83 45 e4 01 83 c3 
EIP: [<c01505af>] prep_new_page+0xb5/0x106 SS:ESP 0068:f6fb1e40
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1
 [<c0103b64>] dump_trace+0x215/0x21a
 [<c0103c0c>] show_trace_log_lvl+0x1a/0x30
 [<c0103c34>] show_trace+0x12/0x14
 [<c0103d31>] dump_stack+0x19/0x1b
 [<c011efff>] __might_sleep+0xa3/0xab
 [<c0138175>] down_read+0x15/0x29
 [<c012ed57>] blocking_notifier_call_chain+0x1c/0x42
 [<c0122bf9>] profile_task_exit+0x11/0x13
 [<c01244da>] do_exit+0x1c/0x43b
 [<c0104243>] do_trap+0x0/0xbd
 [<c01159e6>] do_page_fault+0x34b/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<c01505af>] prep_new_page+0xb5/0x106
 [<c0150add>] buffered_rmqueue+0x93/0x134
 [<c0150cb6>] get_page_from_freelist+0xa2/0xb9
 [<c0150d1b>] __alloc_pages+0x4e/0x2b0
 [<c0159c69>] do_anonymous_page+0x43/0x15d
 [<c015a274>] __handle_mm_fault+0xd2/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<0805417d>] 0x805417d
 =======================
note: dnscache-epoll-[2904] exited with preempt_count 1
BUG: unable to handle kernel paging request at virtual address fffac500
 printing eip:
c01505af
*pde = 00003067
*pte = 00000000
Oops: 0002 [#8]
SMP 
Modules linked in: ipt_REJECT ip6t_LOG tcp_highspeed tcp_htcp tcp_hybla xt_limit tcp_scalable tcp_vegas ipt_LOG tcp_westwood sch_netem ipt_hashlimit sch_hfsc sch_htb ip6table_mangle sch_sfq cls_fw iptable_mangle cls_u32 cls_route sch_ingress sch_red sch_tbf iptable_nat sch_teql ip_nat sch_prio ipt_owner sch_gred cls_rsvp xt_state cls_rsvp6 cls_tcindex ip_conntrack sch_cbq sch_dsmark ip6table_filter intelfb ip6_tables i2c_algo_bit i810 iptable_filter lp ip_tables parport_pc parport i2c_dev usb_storage eeprom ohci_hcd binfmt_misc loop dm_mod video button battery asus_acpi ac tcp_cubic irlan irda crc_ccitt 8139too mii snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss pcspkr i2c_i801 i2c_core iTCO_wdt ohci1394 e1000 snd_pcm ieee1394 uhci_hcd snd_timer ehci_hcd snd soundcore snd_page_alloc
CPU:    1
EIP:    0060:[<c01505af>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-highmem #2)
EIP is at prep_new_page+0xb5/0x106
eax: 00000000   ebx: c1732c40   ecx: 000002c0   edx: 00000000
esi: 00000000   edi: fffac500   ebp: f6023e68   esp: f6023e40
ds: 007b   es: 007b   ss: 0068
Process dnscache-epoll- (pid: 2935, ti=f6022000 task=f7562a70 task.ti=f6022000)
Stack: fffac000 00000006 00000001 00000000 000280d2 00000000 c1732c40 00000001 
       00000246 c0561b80 f6023e94 c0150add c0561c8c 00000002 c0561c80 00000000 
       c1732c40 00000000 c0561b80 c0562220 00000044 f6023ec4 c0150cb6 000280d2 
Call Trace:
 [<c0150add>] buffered_rmqueue+0x93/0x134
 [<c0150cb6>] get_page_from_freelist+0xa2/0xb9
 [<c0150d1b>] __alloc_pages+0x4e/0x2b0
 [<c0159c69>] do_anonymous_page+0x43/0x15d
 [<c015a274>] __handle_mm_fault+0xd2/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<0805417d>] 0x805417d
 =======================
Code: e4 00 00 00 00 d3 e0 83 f8 00 7e 3d 31 f6 89 45 e0 89 fb ba 03 00 00 00 89 d8 e8 25 63 fc ff b9 00 04 00 00 89 45 d8 89 c7 89 f0 <f3> ab ba 03 00 00 00 8b 45 d8 e8 93 63 fc ff 83 45 e4 01 83 c3 
EIP: [<c01505af>] prep_new_page+0xb5/0x106 SS:ESP 0068:f6023e40
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1
 [<c0103b64>] dump_trace+0x215/0x21a
 [<c0103c0c>] show_trace_log_lvl+0x1a/0x30
 [<c0103c34>] show_trace+0x12/0x14
 [<c0103d31>] dump_stack+0x19/0x1b
 [<c011efff>] __might_sleep+0xa3/0xab
 [<c0138175>] down_read+0x15/0x29
 [<c012ed57>] blocking_notifier_call_chain+0x1c/0x42
 [<c0122bf9>] profile_task_exit+0x11/0x13
 [<c01244da>] do_exit+0x1c/0x43b
 [<c0104243>] do_trap+0x0/0xbd
 [<c01159e6>] do_page_fault+0x34b/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<c01505af>] prep_new_page+0xb5/0x106
 [<c0150add>] buffered_rmqueue+0x93/0x134
 [<c0150cb6>] get_page_from_freelist+0xa2/0xb9
 [<c0150d1b>] __alloc_pages+0x4e/0x2b0
 [<c0159c69>] do_anonymous_page+0x43/0x15d
 [<c015a274>] __handle_mm_fault+0xd2/0x23d
 [<c011582b>] do_page_fault+0x190/0x5bb
 [<c04afd49>] error_code+0x39/0x40
 [<0805417d>] 0x805417d
 =======================
note: dnscache-epoll-[2935] exited with preempt_count 1
Ingress scheduler: Classifier actions prefered over netfilter

-- 
