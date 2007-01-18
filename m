Return-Path: <linux-kernel-owner+w=401wt.eu-S932077AbXARJ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbXARJ24 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbXARJ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:28:56 -0500
Received: from stz-bg.com ([213.169.37.103]:46927 "EHLO stz-bg.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077AbXARJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:28:52 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 04:28:51 EST
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=stz-bg.com;
  b=niCNXDZEtGuEQ0gMTbC6zYeUmwxJhmmpmIrqSy8n5TRXmXAjGIROMoL2zkuThC2IGRcSOmFJZ8mr94+yikZDTKDFz8RwDkXbJoHzVn5rn2ieqB7vx465VPIi+ToJc/Eq  ;
Message-ID: <48247.82.103.71.18.1169112129.squirrel@mail.stz-bg.com>
Date: Thu, 18 Jan 2007 11:22:09 +0200 (EET)
Subject: PROBLEM: writting files > 100 MB in FAT32
From: "Condor" <condor@stz-bg.com>
To: linux-kernel@vger.kernel.org
Reply-To: condor@stz-bg.com
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[1.] Files if > 100 MB saving in USB memory stick 4 GB with FAT32. While
saving all files is broken.
[2.] I have USB memory stick A-DATA 4 GB with FAT32. When i trying to save
files in my USB and files is > of 100 MB, all files that i save is broken.
I put my USB in my laptop and mount it as: mount /dev/sda1 /mnt/usb-win
While i mount it, i got in my local disk and copy one file that is 520 MB.
The file is copying very slow (10 min). and after i see again my console i
wait light to my usb is off and i unmount it as: umount /mnt/usb-win
I get my USB stick and when i return to home i trying to copy file from my
USB to my windows and linux. Both OS unable to read file.
After some tryings i format my USB in FAT16 and now every thing is work
fine. I copy files to my USB and back to my hard drive and all files work
fine.
[3.] lsmod
# lsmod
Module                  Size  Used by
sg                     22552  0
sd_mod                 17408  0
usb_storage            80448  0
snd_intel8x0m          15372  4
snd_seq_oss            30720  0
snd_seq_midi_event      6912  1 snd_seq_oss
snd_seq                47056  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          7308  2 snd_seq_oss,snd_seq
snd_pcm_oss            40224  0
snd_mixer_oss          15744  1 snd_pcm_oss
ipv6                  231456  14
nls_iso8859_1           4992  1
nls_cp437               6656  1
vfat                   11136  1
fat                    47516  1 vfat
nls_base                7424  4 nls_iso8859_1,nls_cp437,vfat,fat
capability              4232  0
commoncap               6272  1 capability
psmouse                35464  0
pcmcia                 31532  0
tsdev                   6976  0
usbhid                 37344  0
usbmouse                5376  0
ipw2200               128176  0
nvidia               4709172  22
ieee80211              30280  1 ipw2200
ieee80211_crypt         5760  1 ieee80211
ohci1394               31792  0
ieee1394               84440  1 ohci1394
yenta_socket           24460  2
rsrc_nonstatic         12416  1 yenta_socket
i2c_i801                7948  0
intel_agp              21148  1
agpgart                28108  2 nvidia,intel_agp
firmware_class          8832  2 pcmcia,ipw2200
i2c_core               18560  2 nvidia,i2c_i801
pcmcia_core            34712  3 pcmcia,yenta_socket,rsrc_nonstatic
snd_intel8x0           29596  1
snd_ac97_codec         89888  2 snd_intel8x0m,snd_intel8x0
snd_ac97_bus            3072  1 snd_ac97_codec
snd_pcm                65540  6
snd_intel8x0m,snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              20868  2 snd_seq,snd_pcm
snd                    45284  18
snd_intel8x0m,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
uhci_hcd               22156  0
soundcore               7392  1 snd
usbcore               116996  5 usb_storage,usbhid,usbmouse,uhci_hcd
snd_page_alloc          8712  3 snd_intel8x0m,snd_intel8x0,snd_pcm
serio_raw               6532  0

[4.] Linux version 2.6.19.1 (root@elrond) (gcc version 3.4.6) #1 SMP
PREEMPT Wed Dec 27 09:36:04 EET 2006

[5.] none

[6.] none
[7.]
[7.1]
Linux elrond 2.6.19.1 #1 SMP PREEMPT Wed Dec 27 09:36:04 EET 2006 i686
i686 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
jfsutils               1.1.11
reiserfsprogs          3.6.19
xfsprogs               2.8.10
pcmcia-cs              3.2.8
quota-tools            3.13.
PPP                    2.4.4
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   097
Modules Loaded         sg sd_mod usb_storage snd_intel8x0m snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss ipv6
nls_iso8859_1 nls_cp437 vfat fat nls_base capability commoncap psmouse
pcmcia tsdev usbhid usbmouse ipw2200 nvidia ieee80211 ieee80211_crypt
ohci1394 ieee1394 yenta_socket rsrc_nonstatic i2c_i801 intel_agp agpgart
firmware_class i2c_core pcmcia_core snd_intel8x0 snd_ac97_codec
snd_ac97_bus snd_pcm snd_timer snd uhci_hcd soundcore usbcore
snd_page_alloc serio_raw

[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.60GHz
stepping        : 8
cpu MHz         : 1596.512
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up est tm2
bogomips        : 3194.39

[7.3]
sg 22552 0 - Live 0xe0bc9000
sd_mod 17408 0 - Live 0xe0bc3000
usb_storage 80448 0 - Live 0xe0bdf000
snd_intel8x0m 15372 4 - Live 0xe0b05000
snd_seq_oss 30720 0 - Live 0xe0b0a000
snd_seq_midi_event 6912 1 snd_seq_oss, Live 0xe0ad1000
snd_seq 47056 4 snd_seq_oss,snd_seq_midi_event, Live 0xe0ae7000
snd_seq_device 7308 2 snd_seq_oss,snd_seq, Live 0xe0a86000
snd_pcm_oss 40224 0 - Live 0xe0af4000
snd_mixer_oss 15744 1 snd_pcm_oss, Live 0xe0ae2000
ipv6 231456 14 - Live 0xe0b27000
nls_iso8859_1 4992 1 - Live 0xe0aca000
nls_cp437 6656 1 - Live 0xe0a89000
vfat 11136 1 - Live 0xe0ac6000
fat 47516 1 vfat, Live 0xe0ad5000
nls_base 7424 4 nls_iso8859_1,nls_cp437,vfat,fat, Live 0xe0a7d000
capability 4232 0 - Live 0xe0a83000
commoncap 6272 1 capability, Live 0xe0a80000
psmouse 35464 0 - Live 0xe0abc000
pcmcia 31532 0 - Live 0xe0a54000
tsdev 6976 0 - Live 0xe097d000
usbhid 37344 0 - Live 0xe09d7000
usbmouse 5376 0 - Live 0xe097a000
ipw2200 128176 0 - Live 0xe09f1000
nvidia 4709172 22 - Live 0xe0ef3000 (P)
ieee80211 30280 1 ipw2200, Live 0xe09c1000
ieee80211_crypt 5760 1 ieee80211, Live 0xe094e000
ohci1394 31792 0 - Live 0xe0971000
ieee1394 84440 1 ohci1394, Live 0xe095b000
yenta_socket 24460 2 - Live 0xe093a000
rsrc_nonstatic 12416 1 yenta_socket, Live 0xe0914000
i2c_i801 7948 0 - Live 0xe0902000
intel_agp 21148 1 - Live 0xe08e3000
agpgart 28108 2 nvidia,intel_agp, Live 0xe090c000
firmware_class 8832 2 pcmcia,ipw2200, Live 0xe08df000
i2c_core 18560 2 nvidia,i2c_i801, Live 0xe08fc000
pcmcia_core 34712 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xe08a0000
snd_intel8x0 29596 1 - Live 0xe08d6000
snd_ac97_codec 89888 2 snd_intel8x0m,snd_intel8x0, Live 0xe091a000
snd_ac97_bus 3072 1 snd_ac97_codec, Live 0xe087e000
snd_pcm 65540 6 snd_intel8x0m,snd_pcm_oss,snd_intel8x0,snd_ac97_codec,
Live 0xe08ea000
snd_timer 20868 2 snd_seq,snd_pcm, Live 0xe0899000
snd 45284 18
snd_intel8x0m,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,
Live 0xe08c9000
uhci_hcd 22156 0 - Live 0xe0892000
soundcore 7392 1 snd, Live 0xe0887000
usbcore 116996 5 usb_storage,usbhid,usbmouse,uhci_hcd, Live 0xe08ab000
snd_page_alloc 8712 3 snd_intel8x0m,snd_intel8x0,snd_pcm, Live 0xe0883000
serio_raw 6532 0 - Live 0xe0880000

[7.4]
# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0400-041f : 0000:00:1f.3
  0400-041f : i801_smbus
0480-04bf : 0000:00:1f.0
0800-087f : 0000:00:1f.0
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0810-0815 : ACPI CPU throttle
  0828-082f : ACPI GPE0_BLK
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #07
c800-c8ff : 0000:00:1e.3
  c800-c8ff : Intel ICH6 Modem
d000-d07f : 0000:00:1e.3
  d000-d07f : Intel ICH6 Modem
d080-d0bf : 0000:00:1e.2
  d080-d0bf : Intel ICH6
d400-d4ff : 0000:00:1e.2
  d400-d4ff : Intel ICH6
d800-d81f : 0000:00:1d.2
  d800-d81f : uhci_hcd
d880-d89f : 0000:00:1d.1
  d880-d89f : uhci_hcd
dc00-dc1f : 0000:00:1d.0
  dc00-dc1f : uhci_hcd
e000-efff : PCI Bus #02
  e000-e0ff : PCI CardBus #03
  e400-e4ff : PCI CardBus #03
  e800-e8ff : 0000:02:03.0
    e800-e8ff : 8139too
  ec00-ecff : PCI CardBus #07
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cf800-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffcffff : System RAM
  00100000-002eb680 : Kernel code
  002eb681-00394f73 : Kernel data
1ffd0000-1ffddfff : ACPI Tables
1ffde000-1fffffff : ACPI Non-volatile Storage
30000000-34ffffff : PCI Bus #02
  30000000-31ffffff : PCI CardBus #03
  32000000-33ffffff : PCI CardBus #07
  34000000-3400ffff : 0000:02:03.0
36000000-37ffffff : PCI CardBus #03
38000000-39ffffff : PCI CardBus #07
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
e0000000-efffffff : reserved
f8fff800-f8fff8ff : 0000:00:1e.2
  f8fff800-f8fff8ff : Intel ICH6
f8fffc00-f8fffdff : 0000:00:1e.2
  f8fffc00-f8fffdff : Intel ICH6
f9000000-fbefffff : PCI Bus #01
  f9000000-f9ffffff : 0000:01:00.0
  fa000000-faffffff : 0000:01:00.0
    fa000000-faffffff : nvidia
  fbee0000-fbefffff : 0000:01:00.0
fbf00000-fbffffff : PCI Bus #02
  fbf00000-fbf00fff : 0000:02:04.0
    fbf00000-fbf00fff : yenta_socket
  fbf01000-fbf01fff : 0000:02:04.1
    fbf01000-fbf01fff : yenta_socket
  fbffe000-fbffefff : 0000:02:09.0
    fbffe000-fbffefff : ipw2200
  fbfff000-fbfff7ff : 0000:02:04.2
    fbfff000-fbfff7ff : ohci1394
  fbfffc00-fbfffcff : 0000:02:03.0
    fbfffc00-fbfffcff : 8139too
fed13000-fed19fff : reserved
fed1c000-fed1ffff : reserved
fff80000-ffffffff : reserved

[7.5]
# lspci -vvv
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Processor to DRAM Controller (rev 04)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express
Root Port (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f9000000-fbefffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
                Address: fee0100c  Data: 41c1
        Capabilities: [a0] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 2
                Link: Latency L0s <256ns, L1 <4us
                Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
                Slot: Number 16, PowerLimit 75.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [100] Virtual Channel
        Capabilities: [140] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at dc00 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at d880 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 20
        Region 4: I/O ports at d800 [size=32]

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
(prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=0a, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fbf00000-fbffffff
        Prefetchable memory behind bridge: 0000000030000000-0000000034f00000
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] #0d [0000]

00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at d400 [size=256]
        Region 1: I/O ports at d080 [size=64]
        Region 2: Memory at f8fffc00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at f8fff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97
Modem Controller (rev 04) (prog-if 00 [Generic])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0121
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at c800 [size=256]
        Region 1: I/O ports at d000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 04)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0400 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce Go
6600] (rev a2) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (64-bit, prefetchable) [size=128M]
        Region 3: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
        [virtual] Expansion ROM at fbee0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <512ns, L1 <4us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
                Link: Latency L0s <256ns, L1 <4us
                Link: ASPM L0s L1 Enabled RCB 128 bytes CommClk+ ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
        Capabilities: [100] Virtual Channel
        Capabilities: [128] Power Budgeting

02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0161
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at fbfffc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 34000000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fbf00000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: 36000000-37fff000
        I/O window 0: 0000e000-0000e0ff
        I/O window 1: 0000e400-0000e4ff
        BridgeCtl: Parity+ SERR+ ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:04.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 18
        Region 0: Memory at fbf01000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 32000000-33fff000 (prefetchable)
        Memory window 1: 38000000-39fff000
        I/O window 0: 0000ec00-0000ecff
        I/O window 1: 00001000-000010ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:04.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 04) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd. Unknown device 0321
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin C routed to IRQ 23
        Region 0: Memory at fbfff000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+

02:09.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network
Connection (rev 05)
        Subsystem: Intel Corporation Unknown device 2701
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 6000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at fbffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

[7.6]
# cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory
[7.7]
none


Regards,
Condor

