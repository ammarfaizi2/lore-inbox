Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUBLRSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266541AbUBLRSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:18:38 -0500
Received: from chef.nerp.net ([199.199.210.160]:24531 "EHLO chef.nerp.net")
	by vger.kernel.org with ESMTP id S266531AbUBLRQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:16:52 -0500
Date: Thu, 12 Feb 2004 11:16:47 -0600
From: Chad Walstrom <chewie@wookimus.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: NAT over 3c59x cards freezes interactivity on 2.6.2
Message-ID: <20040212171647.GW6864@wookimus.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline
X-Operating-System: Linux skuld 2.6.2-k7
X-GnuPG-Fingerprint: B4AB D627 9CBD 687E 7A31  1950 0CC7 0B18 206C 5AFD
Keywords: 3c59x, 3c59x.ko, kernel, 2.6.2, NAT, interactivity
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[1.] SUMMARY: NAT over 3c59x cards freezes interactivity on 2.6.2

[2.] DETAILS: Upon upgrading from 2.4.x to 2.6.2, I've noticed that my
workstation/NAT box freezes on interactive processes while transfering
large files over NAT to other machines on the network.  For example,
when I'm trying to update my Debian laptop's package lists (apt-get
update).  The Packages and Sources files are large, compressed text
files.  When updating these through apt, it loads the workstation with a
near-constant stream of data.

When the download activity stops on the laptop, interactivity is
restored on the NAT workstation.  There are times when both
interactivity on the workstation AND download activity stops.  Killing
the download process restores interactivity to the workstation.

I noticed that Alex Beier reported a similar problem with the 2.6.1-rc1
kernel and attributed the issue to the 3c59x drivers.

    http://www.ussg.iu.edu/hypermail/linux/kernel/0401.2/1532.html

My workstation uses two 3c905 cards with the 3c59x.ko module.

I do have ACPI and Kernel preemption enabled, and I have not had a
chance to test disabling either. (When I have free-time this weekend,
I'll do it.)

I browsed the ChangeLogs for 2.6.3-rc2 and rc2 present on www.kernel.org
before posting this bug to see if it had been fixed yet, but didn't find
anything.

[3.] KEYWORDS: 3c59x, 3c59x.ko, kernel, 2.6.2, NAT, interactivity

[4.] VERSION:=20
Linux version 2.6.2-k7 (chewie@skuld) (gcc version 3.3.2 (Debian)) #1 Sat F=
eb 7 12:54:03 CST 2004

[5-6.] NA

[7.1] SOFTWARE: 2.6.2, iptables

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux skuld 2.6.2-k7 #1 Sat Feb 7 12:54:03 CST 2004 i686 GNU/Linux
=20
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre9
e2fsprogs              1.35-WIP
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         snd_pcm_oss snd_mixer_oss binfmt_misc snd_ens1371 sn=
d_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer snd_ac97_codec ga=
meport snd md5 ipv6 hid ipt_TOS ipt_MASQUERADE ipt_limit ipt_REJECT ipt_LOG=
 ipt_state ip_nat_irc ip_nat_tftp ip_nat_ftp ip_conntrack_irc ip_conntrack_=
tftp ip_conntrack_ftp ipt_multiport ipt_conntrack iptable_filter iptable_ma=
ngle iptable_nat ip_conntrack ip_tables af_packet uhci_hcd ohci_hcd ehci_hc=
d lp reiserfs dm_mod 3c59x sg cpuid evbug parport_pc parport evdev joydev u=
sbmouse usbkbd usbcore radeon nvram unix rtc

[7.2.] PROCESSOR INFO:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 4
cpu MHz		: 1050.540
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2068.48

[7.3.] MODULE INFO:

snd_pcm_oss 53412 1 - Live 0xea076000
snd_mixer_oss 19136 1 snd_pcm_oss, Live 0xea05f000
binfmt_misc 10440 1 - Live 0xe5c57000
snd_ens1371 24808 1 - Live 0xe5c68000
snd_rawmidi 25056 1 snd_ens1371, Live 0xe5c60000
snd_seq_device 8136 1 snd_rawmidi, Live 0xe5c09000
snd_pcm 99428 2 snd_pcm_oss,snd_ens1371, Live 0xe5cb9000
snd_page_alloc 11780 1 snd_pcm, Live 0xe5c21000
snd_timer 25412 1 snd_pcm, Live 0xe5c4f000
snd_ac97_codec 54148 1 snd_ens1371, Live 0xe5c30000
gameport 4736 1 snd_ens1371, Live 0xe5c0c000
snd 52196 8 snd_pcm_oss,snd_mixer_oss,snd_ens1371,snd_rawmidi,snd_seq_devic=
e,snd_pcm,snd_timer,snd_ac97_codec, Live 0xe5c41000
md5 4096 1 - Live 0xe5bc8000
ipv6 254336 18 - Live 0xe5c79000
hid 32768 0 - Live 0xe5c27000
ipt_TOS 2368 12 - Live 0xe5c04000
ipt_MASQUERADE 3712 1 - Live 0xe5bfe000
ipt_limit 2368 1 - Live 0xe5bca000
ipt_REJECT 6720 4 - Live 0xe5c10000
ipt_LOG 5696 7 - Live 0xe5c06000
ipt_state 1856 21 - Live 0xe5c00000
ip_nat_irc 4208 0 - Live 0xe5bfb000
ip_nat_tftp 3312 0 - Live 0xe5bf9000
ip_nat_ftp 4912 0 - Live 0xe5bf6000
ip_conntrack_irc 71284 1 ip_nat_irc, Live 0xe5be3000
ip_conntrack_tftp 3476 0 - Live 0xe5bc4000
ip_conntrack_ftp 72052 1 ip_nat_ftp, Live 0xe5bd0000
ipt_multiport 1920 1 - Live 0xe5bce000
ipt_conntrack 2368 32 - Live 0xe5bcc000
iptable_filter 2752 1 - Live 0xe5ba6000
iptable_mangle 2752 1 - Live 0xe5b68000
iptable_nat 24044 5 ipt_MASQUERADE,ip_nat_irc,ip_nat_tftp,ip_nat_ftp, Live =
0xe5b88000
ip_conntrack 32240 10 ipt_MASQUERADE,ipt_state,ip_nat_irc,ip_nat_tftp,ip_na=
t_ftp,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp,ipt_conntrack,ipt=
able_nat, Live 0xe5ba8000
ip_tables 17792 11 ipt_TOS,ipt_MASQUERADE,ipt_limit,ipt_REJECT,ipt_LOG,ipt_=
state,ipt_multiport,ipt_conntrack,iptable_filter,iptable_mangle,iptable_nat=
, Live 0xe5b97000
af_packet 22216 4 - Live 0xe5b90000
uhci_hcd 32400 0 - Live 0xe5b71000
ohci_hcd 18432 0 - Live 0xe5b82000
ehci_hcd 25348 0 - Live 0xe5b7a000
lp 11012 0 - Live 0xe5b6d000
reiserfs 239924 3 - Live 0xe5966000
dm_mod 40224 5 - Live 0xe591a000
3c59x 38952 0 - Live 0xe590f000
sg 37592 0 - Live 0xe58f7000
cpuid 2432 0 - Live 0xe588c000
evbug 3008 0 - Live 0xe5882000
parport_pc 36588 1 - Live 0xe58a6000
parport 43880 2 lp,parport_pc, Live 0xe58eb000
evdev 9600 0 - Live 0xe5895000
joydev 9984 0 - Live 0xe5891000
usbmouse 5568 0 - Live 0xe5873000
usbkbd 7360 0 - Live 0xe587f000
usbcore 110428 8 hid,uhci_hcd,ohci_hcd,ehci_hcd,usbmouse,usbkbd, Live 0xe58=
cf000
radeon 118956 2 - Live 0xe58b0000
nvram 9160 0 - Live 0xe587b000
unix 28272 78 - Live 0xe5884000
rtc 12664 0 - Live 0xe5876000

[7.4.] LOADED DRIVER AND HARDWARE INFO

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-a03f : 0000:00:09.0
  a000-a03f : Ensoniq AudioPCI
a400-a4ff : 0000:00:0b.0
a800-a83f : 0000:00:0e.0
  a800-a83f : 0000:00:0e.0
ac00-ac3f : 0000:00:0f.0
  ac00-ac3f : 0000:00:0f.0
b000-b00f : 0000:00:11.1
  b000-b007 : ide0
  b008-b00f : ide1
b400-b41f : 0000:00:11.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:11.3
  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:11.4
  bc00-bc1f : uhci_hcd
c000-c0ff : 0000:00:11.5


00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000d4000-000d97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002dec22 : Kernel code
  002dec23-003aa53f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e7ffffff : radeonfb
e8000000-ebffffff : 0000:00:00.0
ec000000-edffffff : PCI Bus #01
  ed000000-ed07ffff : 0000:01:00.0
    ed000000-ed07ffff : radeonfb
ef000000-ef000fff : 0000:00:0b.0
  ef000000-ef000fff : aic7xxx
ffff0000-ffffffff : reserved

[7.5.] PCI INFORMATION

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW- AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW- Rate=3Dx1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 A=
GP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative SoundBlaster AudioPCI 128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort+ =
<MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a000 [size=3D64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
	Subsystem: Adaptec AHA-2940U2W SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at a400 [disabled] [size=3D256]
	Region 1: Memory at ef000000 (64-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0e.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at a800 [size=3D64]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]

00:0f.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ac00 [size=3D64]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT82=
33/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT823=
5 PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b000 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at b400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at b800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at bc00 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 A=
C97 Audio Controller (rev 10)
	Subsystem: VIA Technologies, Inc.: Unknown device 4511
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at c000 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Rad=
eon 7200] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 7000/Radeon VE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: I/O ports at 9000 [size=3D256]
	Region 2: Memory at ed000000 (32-bit, non-prefetchable) [size=3D512K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=3D48 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- 64bit=
- FW- AGP3- Rate=3Dx1,x2,x4
		Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW- Rate=3Dx1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

[7.6.] SCSI INFORMATION

Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03

[X] KERNEL CONFIGURATION
#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy

#
# General setup
#
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=3Dy
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_HPET_TIMER=3Dy
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_EDD=3Dm
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy
CONFIG_PM_DISK=3Dy
CONFIG_PM_DISK_PARTITION=3D"/dev/sda7"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_RELAXED_AML=3Dy

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=3Dm
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
CONFIG_EISA=3Dy
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=3Dy
CONFIG_EISA_VIRTUAL_ROOT=3Dy
CONFIG_EISA_NAMES=3Dy
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=3Dy

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=3Dm
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_COMPAQ=3Dm
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=3Dy
CONFIG_HOTPLUG_PCI_IBM=3Dm
CONFIG_HOTPLUG_PCI_ACPI=3Dm
# CONFIG_HOTPLUG_PCI_CPCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_MISC=3Dm

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=3Dm

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dm
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=3Dm
CONFIG_MTD_CONCAT=3Dm
CONFIG_MTD_REDBOOT_PARTS=3Dm
CONFIG_MTD_CMDLINE_PARTS=3Dm

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dm
CONFIG_MTD_BLOCK=3Dm
CONFIG_MTD_BLOCK_RO=3Dm
CONFIG_FTL=3Dm
CONFIG_NFTL=3Dm
CONFIG_NFTL_RW=3Dy
# CONFIG_INFTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dm
CONFIG_MTD_JEDECPROBE=3Dm
CONFIG_MTD_GEN_PROBE=3Dm
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_CFI_INTELEXT=3Dm
CONFIG_MTD_CFI_AMDSTD=3Dm
CONFIG_MTD_CFI_STAA=3Dm
CONFIG_MTD_RAM=3Dm
CONFIG_MTD_ROM=3Dm
CONFIG_MTD_ABSENT=3Dm
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=3Dm
CONFIG_MTD_PHYSMAP_START=3D0x8000000
CONFIG_MTD_PHYSMAP_LEN=3D0x4000000
CONFIG_MTD_PHYSMAP_BUSWIDTH=3D2
CONFIG_MTD_PNC2000=3Dm
CONFIG_MTD_SC520CDP=3Dm
CONFIG_MTD_NETSC520=3Dm
CONFIG_MTD_SCx200_DOCFLASH=3Dm
CONFIG_MTD_AMD76XROM=3Dm
CONFIG_MTD_SCB2_FLASH=3Dm
CONFIG_MTD_NETtel=3Dm
CONFIG_MTD_DILNETPC=3Dm
CONFIG_MTD_DILNETPC_BOOTSIZE=3D0x80000
# CONFIG_MTD_L440GX is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=3Dm
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=3Dm
CONFIG_MTD_MTDRAM=3Dm
CONFIG_MTDRAM_TOTAL_SIZE=3D4096
CONFIG_MTDRAM_ERASE_SIZE=3D128
CONFIG_MTD_BLKMTD=3Dm

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=3Dm
CONFIG_MTD_DOC2001=3Dm
# CONFIG_MTD_DOC2001PLUS is not set
CONFIG_MTD_DOCPROBE=3Dm
# CONFIG_MTD_DOCPROBE_ADVANCED is not set
CONFIG_MTD_DOCPROBE_ADDRESS=3D0

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=3Dm
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
CONFIG_MTD_NAND_IDS=3Dm

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_CRYPTOLOOP=3Dy
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D8192
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm
CONFIG_IDE_TASK_IOCTL=3Dy
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dy
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dy
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_REPORT_LUNS=3Dy
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=3Dy

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=3Dy
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D8
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
CONFIG_AIC7XXX_PROBE_EISA_VL=3Dy
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=3D0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX_CONFIG=3Dy
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA23XX is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID5=3Dm
CONFIG_MD_RAID6=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_BLK_DEV_DM=3Dm
CONFIG_DM_IOCTL_V4=3Dy

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_PCI=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_UNIX=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=3Dm
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=3D12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
# CONFIG_IP_VS_PROTO_UDP is not set
# CONFIG_IP_VS_PROTO_ESP is not set
# CONFIG_IP_VS_PROTO_AH is not set

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS application helper
#
CONFIG_IPV6=3Dm
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_TUNNEL=3Dm
# CONFIG_DECNET is not set
CONFIG_BRIDGE=3Dm
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=3Dy

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_TFTP=3Dm
CONFIG_IP_NF_AMANDA=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_IPRANGE=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_MATCH_PHYSDEV=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_SAME=3Dm
CONFIG_IP_NF_NAT_LOCAL=3Dy
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_NAT_TFTP=3Dm
CONFIG_IP_NF_NAT_AMANDA=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MAC=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP6_NF_MATCH_OWNER=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_AHESP=3Dm
CONFIG_IP6_NF_MATCH_LENGTH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dm
CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_ADLER32 is not set
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_HMAC_NONE=3Dy
# CONFIG_SCTP_HMAC_SHA1 is not set
# CONFIG_SCTP_HMAC_MD5 is not set
CONFIG_ATM=3Dm
CONFIG_ATM_CLIP=3Dm
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=3Dm
CONFIG_ATM_MPOA=3Dm
CONFIG_ATM_BR2684=3Dm
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_VLAN_8021Q=3Dm
CONFIG_LLC=3Dm
# CONFIG_LLC2 is not set
CONFIG_IPX=3Dm
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=3Dm
CONFIG_DEV_APPLETALK=3Dy
CONFIG_LTPC=3Dm
CONFIG_COPS=3Dm
CONFIG_COPS_DAYNA=3Dy
CONFIG_COPS_TANGENT=3Dy
CONFIG_IPDDP=3Dm
CONFIG_IPDDP_ENCAP=3Dy
CONFIG_IPDDP_DECAP=3Dy
CONFIG_X25=3Dm
CONFIG_LAPB=3Dm
# CONFIG_NET_DIVERT is not set
CONFIG_ECONET=3Dm
CONFIG_ECONET_AUNUDP=3Dy
CONFIG_ECONET_NATIVE=3Dy
CONFIG_WAN_ROUTER=3Dm
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_CSZ=3Dm
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm
CONFIG_ETHERTAP=3Dm
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=3Dm
CONFIG_TYPHOON=3Dm
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPPOATM=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=3Dm
CONFIG_ARLAN=3Dm
CONFIG_WAVELAN=3Dm

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=3Dm
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_TMD_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
CONFIG_NET_WIRELESS=3Dy

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=3Dm

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
CONFIG_DONGLE=3Dy
CONFIG_ESI_DONGLE=3Dm
CONFIG_ACTISYS_DONGLE=3Dm
CONFIG_TEKRAM_DONGLE=3Dm
CONFIG_LITELINK_DONGLE=3Dm
CONFIG_MA600_DONGLE=3Dm
CONFIG_GIRBIL_DONGLE=3Dm
CONFIG_MCP2120_DONGLE=3Dm
CONFIG_OLD_BELKIN_DONGLE=3Dm
CONFIG_ACT200L_DONGLE=3Dm

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=3Dm

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=3Dm
CONFIG_NSC_FIR=3Dm
CONFIG_WINBOND_FIR=3Dm
CONFIG_TOSHIBA_FIR=3Dm
CONFIG_SMC_IRCC_FIR=3Dm
CONFIG_ALI_FIR=3Dm
CONFIG_VLSI_FIR=3Dm
CONFIG_VIA_FIR=3Dm

#
# Bluetooth support
#
CONFIG_BT=3Dm
CONFIG_BT_L2CAP=3Dm
CONFIG_BT_SCO=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=3Dm
CONFIG_BT_HCIUSB_SCO=3Dy
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_BCSP_TXCRC=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIVHCI=3Dm

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1024
CONFIG_INPUT_JOYDEV=3Dm
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=3Dm
CONFIG_INPUT_EVBUG=3Dm

#
# Input I/O drivers
#
CONFIG_GAMEPORT=3Dm
CONFIG_SOUND_GAMEPORT=3Dm
CONFIG_GAMEPORT_NS558=3Dm
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_SERIAL=3Dm
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_INPUT_JOYSTICK=3Dy
CONFIG_JOYSTICK_ANALOG=3Dm
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=3Dm
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=3Dm
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDDLER=3Dm
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dm
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
# CONFIG_TIPAR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=3Dm
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_KCS=3Dm
CONFIG_IPMI_WATCHDOG=3Dm

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_HW_RANDOM=3Dm
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dm
CONFIG_GEN_RTC=3Dm
CONFIG_GEN_RTC_X=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=3Dy
CONFIG_DRM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=3Dm
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HANGCHECK_TIMER=3Dm

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_CHARDEV=3Dm

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCF=3Dm

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD8111=3Dm
CONFIG_I2C_ELEKTOR=3Dm
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_I801=3Dm
CONFIG_I2C_I810=3Dm
CONFIG_I2C_ISA=3Dm
CONFIG_I2C_NFORCE2=3Dm
# CONFIG_I2C_PHILIPSPAR is not set
CONFIG_I2C_PARPORT=3Dm
CONFIG_I2C_PARPORT_LIGHT=3Dm
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_PROSAVAGE=3Dm
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VELLEMAN is not set
CONFIG_I2C_VIA=3Dm
CONFIG_I2C_VIAPRO=3Dm
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=3Dm
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_EEPROM=3Dm
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_VIA686A=3Dm
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=3Dy
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=3Dy
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=3Dy
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_MDA_CONSOLE=3Dm
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_PCI_CONSOLE=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
# CONFIG_LOGO_LINUX_CLUT224 is not set

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=3Dm
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_ENS1370=3Dm
CONFIG_SND_ENS1371=3Dm
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=3Dm
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=3Dm

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_UHCI_HCD=3Dm

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=3Dm

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=3Dm
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=3Dm
CONFIG_USB_MOUSE=3Dm
CONFIG_USB_AIPTEK=3Dm
CONFIG_USB_WACOM=3Dm
CONFIG_USB_KBTAB=3Dm
CONFIG_USB_POWERMATE=3Dm
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_SCANNER=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USB_HPUSBSCSI=3Dm

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=3Dm
CONFIG_USB_VICAM=3Dm
CONFIG_USB_DSBR=3Dm
CONFIG_USB_IBMCAM=3Dm
CONFIG_USB_KONICAWC=3Dm
CONFIG_USB_OV511=3Dm
CONFIG_USB_PWC=3Dm
CONFIG_USB_SE401=3Dm
CONFIG_USB_STV680=3Dm
CONFIG_USB_W9968CF=3Dm

#
# USB Network adaptors
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_GENESYS=3Dy
CONFIG_USB_NET1080=3Dy
CONFIG_USB_PL2301=3Dy

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_ZAURUS=3Dy
CONFIG_USB_CDCETHER=3Dy

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=3Dy

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KEYSPAN_MPR=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA18X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=3Dy
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_EZUSB=3Dy

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_TIGL=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_BRLVGER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_LED=3Dm
CONFIG_USB_SPEEDTOUCH=3Dm
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=3Dy
CONFIG_QUOTA=3Dy
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dm
CONFIG_UDF_FS=3Dm

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=3Dy
CONFIG_DEVPTS_FS_XATTR=3Dy
CONFIG_DEVPTS_FS_SECURITY=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=3Dm
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=3Dy
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dm
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=3Dm
CONFIG_NCP_FS=3Dm
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_CODA_FS=3Dm
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_INTERMEZZO_FS=3Dm
CONFIG_AFS_FS=3Dm
CONFIG_RXRPC=3Dm

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_ACORN_PARTITION=3Dy
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=3Dy
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=3Dy
CONFIG_OSF_PARTITION=3Dy
CONFIG_AMIGA_PARTITION=3Dy
CONFIG_ATARI_PARTITION=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
# CONFIG_NEC98_PARTITION is not set
CONFIG_SGI_PARTITION=3Dy
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"cp437"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dm
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Library routines
#
CONFIG_CRC32=3Dm
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_PC=3Dy

--=20
Chad Walstrom <chewie@wookimus.net>           http://www.wookimus.net/
           assert(expired(knowledge)); /* core dump */

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAK7T/DMcLGCBsWv0RAiKxAKCFkLOQ1PYn8k7oqVJdzMR6AifFdgCeI7i0
mSKD8Rp90Q6+vG28+sR2zP0=
=fNyl
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--
