Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWISVOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWISVOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 17:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWISVOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 17:14:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:1734 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751040AbWISVOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 17:14:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=cUEW8hL/vPujERfr6AR3Ae9Bjy3FDlKwtEcDIjAoI2TevXaxiuhZSztES56eiMA5eU/6hrseWCAuXr/QcHJBuGsA1ju3Y3aYlgZCmxOcJGq1Tmwz9sarpTi7Qe0TeHPnOW285FfSrg1zGDrwTJPWg1Hia0AOfxp3/FJsgUWbfGc=
Message-ID: <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
Date: Tue, 19 Sep 2006 23:14:43 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: billm@melbpc.org.au, billm@suburbia.net,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <p73venk2sjw.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_16609_6413418.1158700483339"
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <p73venk2sjw.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_16609_6413418.1158700483339
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 19 Sep 2006 10:01:55 +0200, Andi Kleen <ak@suse.de> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> writes:
>
> > Hi,
> >
> > If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
> > tried this with) and then boot the kernel with "no387" then I only get
> > as far as lilo's "...Booting the kernel." message and then the system
> > hangs.
> >
> > The kernel is a 32bit kernel build for K8 and my CPU is a Athlon64 X2 4400+
>
> Do you have a .config? I tried it and it booted until mounting root.
>

The config is attached.

I've also attached the complete dmesg output from a working boot of this kernel.

Below is the output of  scripts/ver_linux to give you an idea of the
build environment and some lspci and various other details so you can
also get a good idea about the hardware.
Hope that's enough, otherwise just ask for whatever you may need.

juhl@dragon:~/download/kernel/linux-2.6.18-rc7-git2$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.18-rc7-git2 #1 SMP PREEMPT Mon Sep 18 23:58:12 CEST
2006 i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
quota-tools            3.13.
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   097
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss agpgart snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
snd_page_alloc snd_util_mem snd_hwdep evdev snd


juhl@dragon:~/download/kernel/linux-2.6.18-rc7-git2$ uname -a
Linux dragon 2.6.18-rc7-git2 #1 SMP PREEMPT Mon Sep 18 23:58:12 CEST
2006 i686 athlon-4 i386 GNU/Linux


juhl@dragon:~/download/kernel/linux-2.6.18-rc7-git2$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.196
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4402.85

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.196
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4399.52


root@dragon:/home/juhl/download/kernel/linux-2.6.18-rc7-git2# lspci -vvx
00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express
and HyperTransport]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir- DUL-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC-
TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut-
LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail- Init+ EOC-
TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut-
LWI=8bit DwFcInEn- LWO=16bit DwFcOutEn-
                Revision ID: 1.05
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+
500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 800MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz+ 300MHz- 400MHz+
500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE-
CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [5c] HyperTransport: MSI Mapping
        Capabilities: [68] HyperTransport: UnitID Clumping
        Capabilities: [74] HyperTransport: Interrupt Discovery and Configuration
        Capabilities: [7c] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
00: b9 10 95 16 07 00 10 00 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: ff200000-ff2fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
                Link: Latency L0s <2us, L1 <32us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed unknown, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd Off, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [7c] HyperTransport: MSI Mapping
        Capabilities: [88] HyperTransport: Revision ID: 1.05
00: b9 10 4b 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 20 ff 20 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 03 00

00:02.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: ff300000-ff3fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x2, ASPM L0s L1, Port 0
                Link: Latency L0s <2us, L1 <32us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed unknown, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd Off, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [7c] HyperTransport: MSI Mapping
        Capabilities: [88] HyperTransport: Revision ID: 1.05
00: b9 10 4c 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 00
20: 30 ff 30 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 00

00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=4 UnitCnt=1 MastHost- DefDir- DUL-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC-
TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=8bit DwFcOut-
LWI=16bit DwFcInEn- LWO=8bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+
TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut-
LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.04
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+
500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz-
500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE-
CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [60] HyperTransport: Interrupt Discovery and Configuration
        Capabilities: [80] AGP version 3.0
                Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
00: b9 10 89 16 06 01 10 00 00 00 00 06 00 00 00 00
10: 08 00 00 dc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:05.0 PCI bridge: ALi Corporation AGP8X Controller (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        Memory behind bridge: ff400000-ff4fffff
        Prefetchable memory behind bridge: c7f00000-d7efffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: b9 10 46 52 07 01 20 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 40 f0 00 20 22
20: 40 ff 40 ff f0 c7 e0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0b 00

00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if
01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff500000-ff5fffff
        Prefetchable memory behind bridge: 88000000-880fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: b9 10 49 52 07 01 00 00 00 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 20 d0 d0 00 22
20: 50 ff 50 ff 00 88 00 88 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00

00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
        Subsystem: ASRock Incorporation Unknown device 1563
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 6000ns max)
00: b9 10 63 15 0f 00 00 02 70 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18

00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: ASRock Incorporation Unknown device 7101
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 Ethernet controller: ALi Corporation ULi 1689,1573 integrated
ethernet. (rev 40)
        Subsystem: ASRock Incorporation Unknown device 5263
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at ff6ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 63 52 07 01 10 02 40 00 00 02 08 20 00 00
10: 01 e8 00 00 00 fc 6f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 14 28

00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a
[Master SecP PriP])
        Subsystem: ASRock Incorporation Unknown device 5229
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ff00 [size=16]
00: b9 10 29 52 05 00 a0 02 c7 8a 01 01 00 20 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 49 18 29 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff6fe000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 e0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50

00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 d0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 02 00 50

00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 64 bytes
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at ff6fc000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 c0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 50

00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
(prog-if 20 [EHCI])
        Subsystem: ASRock Incorporation Unknown device 5239
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 64 bytes
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at ff6ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port
00: b9 10 39 52 16 01 b0 02 01 20 03 0c 10 20 80 00
10: 00 f8 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 39 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 10 20

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia
AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ff4fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at ff4c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
00: 2b 10 27 05 07 00 b0 02 03 00 00 03 10 20 00 00
10: 08 00 00 c8 00 e0 4f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 40 08
30: 00 00 4c ff dc 00 00 00 00 00 00 00 05 01 10 20

04:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at d880 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 00 05 01 90 02 0a 00 01 04 00 20 80 00
10: 81 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 67 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 14

04:05.1 Input device controller: Creative Labs SB Live! Game Port (rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 70 05 01 90 02 0a 00 80 09 00 20 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

04:06.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at d400 [disabled] [size=256]
        Region 1: Memory at ff5ff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 80 00 16 01 b0 02 02 00 00 01 10 20 00 80
10: 01 d4 00 00 04 f0 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 a0 62
30: 00 00 5c ff dc 00 00 00 00 00 00 00 03 01 28 19

04:07.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 42)
        Subsystem: D-Link System Inc DFE-530TX rev B
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at ff5fec00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 88020000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 10 20 00 00
10: 01 d0 00 00 00 ec 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 01 14
30: 00 00 ff ff 40 00 00 00 00 00 00 00 0b 01 03 08


root@dragon:/home/juhl/download/kernel/linux-2.6.18-rc7-git2# cat /proc/modules
snd_seq_oss 34896 0 - Live 0xf8eef000
snd_seq_midi_event 7048 1 snd_seq_oss, Live 0xf8cef000
snd_seq 54456 4 snd_seq_oss,snd_seq_midi_event, Live 0xf8ce0000
snd_pcm_oss 46560 0 - Live 0xf8cd3000
snd_mixer_oss 16776 2 snd_pcm_oss, Live 0xf8cf8000
agpgart 31324 0 - Live 0xf8d01000
snd_emu10k1 120784 2 - Live 0xf8bd2000
snd_rawmidi 21632 1 snd_emu10k1, Live 0xf8b91000
snd_ac97_codec 95544 1 snd_emu10k1, Live 0xf8bb9000
snd_ac97_bus 2624 1 snd_ac97_codec, Live 0xf8b8f000
snd_pcm 80236 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec, Live 0xf8ba4000
snd_seq_device 7572 4 snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,
Live 0xf8b8c000
snd_timer 23132 3 snd_seq,snd_emu10k1,snd_pcm, Live 0xf8b85000
snd_page_alloc 8712 2 snd_emu10k1,snd_pcm, Live 0xf8b81000
snd_util_mem 4104 1 snd_emu10k1, Live 0xf887d000
snd_hwdep 8332 1 snd_emu10k1, Live 0xf8ba0000
evdev 8960 0 - Live 0xf8879000
snd 50980 13 snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_pcm,snd_seq_device,snd_timer,snd_hwdep,
Live 0xf8c2a000


root@dragon:/home/juhl/download/kernel/linux-2.6.18-rc7-git2# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vesafb
03f2-03f5 : floppy
03f7-03f7 : floppy DIR
03f8-03ff : serial
0800-083f : 0000:00:07.1
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0810-0815 : ACPI CPU throttle
  0818-0827 : ACPI GPE0_BLK
  0830-0830 : ACPI PM2_CNT_BLK
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #04
  d000-d0ff : 0000:04:07.0
    d000-d0ff : via-rhine
  d400-d4ff : 0000:04:06.0
  d880-d89f : 0000:04:05.0
    d880-d89f : EMU10K1
  dc00-dc07 : 0000:04:05.1
e800-e8ff : 0000:00:11.0
ff00-ff0f : 0000:00:12.0


root@dragon:/home/juhl/download/kernel/linux-2.6.18-rc7-git2# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c8fff : Video ROM
000c9000-000ce3ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7ffaffff : System RAM
  00100000-0032d81c : Kernel code
  0032d81d-00413b2f : Kernel data
7ffb0000-7ffbffff : ACPI Tables
7ffc0000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
88000000-880fffff : PCI Bus #04
  88000000-8801ffff : 0000:04:06.0
  88020000-8802ffff : 0000:04:07.0
c7f00000-d7efffff : PCI Bus #03
  c8000000-cfffffff : 0000:03:00.0
    c8000000-c8ffffff : vesafb
dc000000-dfffffff : 0000:00:04.0
ff200000-ff2fffff : PCI Bus #01
ff300000-ff3fffff : PCI Bus #02
ff400000-ff4fffff : PCI Bus #03
  ff4c0000-ff4dffff : 0000:03:00.0
  ff4fe000-ff4fffff : 0000:03:00.0
ff500000-ff5fffff : PCI Bus #04
  ff5fec00-ff5fecff : 0000:04:07.0
    ff5fec00-ff5fecff : via-rhine
  ff5ff000-ff5fffff : 0000:04:06.0
    ff5ff000-ff5fffff : aic7xxx
ff6fc000-ff6fcfff : 0000:00:13.2
ff6fd000-ff6fdfff : 0000:00:13.1
ff6fe000-ff6fefff : 0000:00:13.0
ff6ff800-ff6ff8ff : 0000:00:13.3
ff6ffc00-ff6ffcff : 0000:00:11.0
ff7c0000-ffffffff : reserved


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_16609_6413418.1158700483339
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esas571r
Content-Disposition: attachment; filename="config.gz"

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
------=_Part_16609_6413418.1158700483339
Content-Type: application/octet-stream; name=dmesg-2.6.18-rc7-git2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esas8pmy
Content-Disposition: attachment; filename="dmesg-2.6.18-rc7-git2"

TGludXggdmVyc2lvbiAyLjYuMTgtcmM3LWdpdDIgKGp1aGxAZHJhZ29uKSAoZ2NjIHZlcnNpb24g
My40LjYpICMxIFNNUCBQUkVFTVBUIE1vbiBTZXAgMTggMjM6NTg6MTIgQ0VTVCAyMDA2CkJJT1Mt
cHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKIEJJT1MtZTgyMDogMDAwMDAwMDAwMDAwMDAwMCAt
IDAwMDAwMDAwMDAwOWY4MDAgKHVzYWJsZSkKIEJJT1MtZTgyMDogMDAwMDAwMDAwMDA5ZjgwMCAt
IDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQogQklPUy1lODIwOiAwMDAwMDAwMDAwMGU4MDAw
IC0gMDAwMDAwMDAwMDEwMDAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAxMDAw
MDAgLSAwMDAwMDAwMDdmZmIwMDAwICh1c2FibGUpCiBCSU9TLWU4MjA6IDAwMDAwMDAwN2ZmYjAw
MDAgLSAwMDAwMDAwMDdmZmMwMDAwIChBQ1BJIGRhdGEpCiBCSU9TLWU4MjA6IDAwMDAwMDAwN2Zm
YzAwMDAgLSAwMDAwMDAwMDdmZmYwMDAwIChBQ1BJIE5WUykKIEJJT1MtZTgyMDogMDAwMDAwMDA3
ZmZmMDAwMCAtIDAwMDAwMDAwODAwMDAwMDAgKHJlc2VydmVkKQogQklPUy1lODIwOiAwMDAwMDAw
MGZmN2MwMDAwIC0gMDAwMDAwMDEwMDAwMDAwMCAocmVzZXJ2ZWQpCjExNTFNQiBISUdITUVNIGF2
YWlsYWJsZS4KODk2TUIgTE9XTUVNIGF2YWlsYWJsZS4KZm91bmQgU01QIE1QLXRhYmxlIGF0IDAw
MGZmNzgwCk9uIG5vZGUgMCB0b3RhbHBhZ2VzOiA1MjQyMDgKICBETUEgem9uZTogNDA5NiBwYWdl
cywgTElGTyBiYXRjaDowCiAgTm9ybWFsIHpvbmU6IDIyNTI4MCBwYWdlcywgTElGTyBiYXRjaDoz
MQogIEhpZ2hNZW0gem9uZTogMjk0ODMyIHBhZ2VzLCBMSUZPIGJhdGNoOjMxCkRNSSAyLjMgcHJl
c2VudC4KQUNQSTogUlNEUCAodjAwMCBBQ1BJQU0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICkgQCAweDAwMGY5YmIwCkFDUEk6IFJTRFQgKHYwMDEgQSBNIEkgIE9FTVJTRFQgIDB4MTIw
MDA1MDYgTVNGVCAweDAwMDAwMDk3KSBAIDB4N2ZmYjAwMDAKQUNQSTogRkFEVCAodjAwMiBBIE0g
SSAgT0VNRkFDUCAgMHgxMjAwMDUwNiBNU0ZUIDB4MDAwMDAwOTcpIEAgMHg3ZmZiMDIwMApBQ1BJ
OiBNQURUICh2MDAxIEEgTSBJICBPRU1BUElDICAweDEyMDAwNTA2IE1TRlQgMHgwMDAwMDA5Nykg
QCAweDdmZmIwMzkwCkFDUEk6IE9FTUIgKHYwMDEgQSBNIEkgIEFNSV9PRU0gIDB4MTIwMDA1MDYg
TVNGVCAweDAwMDAwMDk3KSBAIDB4N2ZmYzAwNDAKQUNQSTogRFNEVCAodjAwMSAgOTM5TTIgOTM5
TTIxNTAgMHgwMDAwMDE1MCBJTlRMIDB4MDIwMDIwMjYpIEAgMHgwMDAwMDAwMApBQ1BJOiBQTS1U
aW1lciBJTyBQb3J0OiAweDgwOApBQ1BJOiBMb2NhbCBBUElDIGFkZHJlc3MgMHhmZWUwMDAwMApB
Q1BJOiBMQVBJQyAoYWNwaV9pZFsweDAxXSBsYXBpY19pZFsweDAwXSBlbmFibGVkKQpQcm9jZXNz
b3IgIzAgMTU6MyBBUElDIHZlcnNpb24gMTYKQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwMl0gbGFw
aWNfaWRbMHgwMV0gZW5hYmxlZCkKUHJvY2Vzc29yICMxIDE1OjMgQVBJQyB2ZXJzaW9uIDE2CkFD
UEk6IElPQVBJQyAoaWRbMHgwMl0gYWRkcmVzc1sweGZlYzAwMDAwXSBnc2lfYmFzZVswXSkKSU9B
UElDWzBdOiBhcGljX2lkIDIsIHZlcnNpb24gMTcsIGFkZHJlc3MgMHhmZWMwMDAwMCwgR1NJIDAt
MjMKQUNQSTogSU9BUElDIChpZFsweDAzXSBhZGRyZXNzWzB4ZmVjMTAwMDBdIGdzaV9iYXNlWzI0
XSkKSU9BUElDWzFdOiBhcGljX2lkIDMsIHZlcnNpb24gMTcsIGFkZHJlc3MgMHhmZWMxMDAwMCwg
R1NJIDI0LTM5CkFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDAgZ2xvYmFsX2lycSAy
IGRmbCBkZmwpCkFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDkgZ2xvYmFsX2lycSA5
IGxvdyBsZXZlbCkKQUNQSTogSVJRMCB1c2VkIGJ5IG92ZXJyaWRlLgpBQ1BJOiBJUlEyIHVzZWQg
Ynkgb3ZlcnJpZGUuCkFDUEk6IElSUTkgdXNlZCBieSBvdmVycmlkZS4KRW5hYmxpbmcgQVBJQyBt
b2RlOiAgRmxhdC4gIFVzaW5nIDIgSS9PIEFQSUNzClVzaW5nIEFDUEkgKE1BRFQpIGZvciBTTVAg
Y29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgpBbGxvY2F0aW5nIFBDSSByZXNvdXJjZXMgc3RhcnRp
bmcgYXQgODgwMDAwMDAgKGdhcDogODAwMDAwMDA6N2Y3YzAwMDApCkRldGVjdGVkIDIyMDAuMTk2
IE1IeiBwcm9jZXNzb3IuCkJ1aWx0IDEgem9uZWxpc3RzLiAgVG90YWwgcGFnZXM6IDUyNDIwOApL
ZXJuZWwgY29tbWFuZCBsaW5lOiBhdXRvIEJPT1RfSU1BR0U9Mi42LjE4cmM3Z2l0MiBybyByb290
PTgwMQptYXBwZWQgQVBJQyB0byBmZmZmZDAwMCAoZmVlMDAwMDApCm1hcHBlZCBJT0FQSUMgdG8g
ZmZmZmMwMDAgKGZlYzAwMDAwKQptYXBwZWQgSU9BUElDIHRvIGZmZmZiMDAwIChmZWMxMDAwMCkK
RW5hYmxpbmcgZmFzdCBGUFUgc2F2ZSBhbmQgcmVzdG9yZS4uLiBkb25lLgpFbmFibGluZyB1bm1h
c2tlZCBTSU1EIEZQVSBleGNlcHRpb24gc3VwcG9ydC4uLiBkb25lLgpJbml0aWFsaXppbmcgQ1BV
IzAKQ1BVIDAgaXJxc3RhY2tzLCBoYXJkPWMwNGFkMDAwIHNvZnQ9YzA0YWIwMDAKUElEIGhhc2gg
dGFibGUgZW50cmllczogNDA5NiAob3JkZXI6IDEyLCAxNjM4NCBieXRlcykKQ29uc29sZTogY29s
b3VyIGR1bW15IGRldmljZSA4MHgyNQpMb2NrIGRlcGVuZGVuY3kgdmFsaWRhdG9yOiBDb3B5cmln
aHQgKGMpIDIwMDYgUmVkIEhhdCwgSW5jLiwgSW5nbyBNb2xuYXIKLi4uIE1BWF9MT0NLREVQX1NV
QkNMQVNTRVM6ICAgIDgKLi4uIE1BWF9MT0NLX0RFUFRIOiAgICAgICAgICAzMAouLi4gTUFYX0xP
Q0tERVBfS0VZUzogICAgICAgIDIwNDgKLi4uIENMQVNTSEFTSF9TSVpFOiAgICAgICAgICAgMTAy
NAouLi4gTUFYX0xPQ0tERVBfRU5UUklFUzogICAgIDgxOTIKLi4uIE1BWF9MT0NLREVQX0NIQUlO
UzogICAgICA4MTkyCi4uLiBDSEFJTkhBU0hfU0laRTogICAgICAgICAgNDA5NgogbWVtb3J5IHVz
ZWQgYnkgbG9jayBkZXBlbmRlbmN5IGluZm86IDY5NiBrQgogcGVyIHRhc2stc3RydWN0IG1lbW9y
eSBmb290cHJpbnQ6IDEyMDAgYnl0ZXMKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCnwgTG9ja2lu
ZyBBUEkgdGVzdHN1aXRlOgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgc3BpbiB8d2xvY2sgfHJsb2NrIHxtdXRleCB8IHdzZW0gfCByc2VtIHwK
ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQogICAgICAgICAgICAgICAgICAgICBBLUEgZGVhZGxvY2s6ICBv
ayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICAgICAgICAgICAgICAg
QS1CLUItQSBkZWFkbG9jazogIG9rICB8ICBvayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfCAgb2sg
IHwKICAgICAgICAgICAgIEEtQi1CLUMtQy1BIGRlYWRsb2NrOiAgb2sgIHwgIG9rICB8ICBvayAg
fCAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgICAgICAgICAgQS1CLUMtQS1CLUMgZGVhZGxvY2s6
ICBvayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICAgICAgIEEtQi1C
LUMtQy1ELUQtQSBkZWFkbG9jazogIG9rICB8ICBvayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfCAg
b2sgIHwKICAgICAgICAgQS1CLUMtRC1CLUQtRC1BIGRlYWRsb2NrOiAgb2sgIHwgIG9rICB8ICBv
ayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgICAgICBBLUItQy1ELUItQy1ELUEgZGVhZGxv
Y2s6ICBvayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICAgICAgICAg
ICAgICAgICAgZG91YmxlIHVubG9jazogIG9rICB8ICBvayAgfCAgb2sgIHwgIG9rICB8ICBvayAg
fCAgb2sgIHwKICAgICAgICAgICAgICAgICAgaW5pdGlhbGl6ZSBoZWxkOiAgb2sgIHwgIG9rICB8
ICBvayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgICAgICAgICAgICAgIGJhZCB1bmxvY2sg
b3JkZXI6ICBvayAgfCAgb2sgIHwgIG9rICB8ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KICAgICAgICAgICAgICByZWN1cnNpdmUgcmVhZC1sb2NrOiAgICAgICAgICAg
ICB8ICBvayAgfCAgICAgICAgICAgICB8ICBvayAgfAogICAgICAgICAgIHJlY3Vyc2l2ZSByZWFk
LWxvY2sgIzI6ICAgICAgICAgICAgIHwgIG9rICB8ICAgICAgICAgICAgIHwgIG9rICB8CiAgICAg
ICAgICAgIG1peGVkIHJlYWQtd3JpdGUtbG9jazogICAgICAgICAgICAgfCAgb2sgIHwgICAgICAg
ICAgICAgfCAgb2sgIHwKICAgICAgICAgICAgbWl4ZWQgd3JpdGUtcmVhZC1sb2NrOiAgICAgICAg
ICAgICB8ICBvayAgfCAgICAgICAgICAgICB8ICBvayAgfAogIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAg
ICAgaGFyZC1pcnFzLW9uICsgaXJxLXNhZmUtQS8xMjogIG9rICB8ICBvayAgfCAgb2sgIHwKICAg
ICBzb2Z0LWlycXMtb24gKyBpcnEtc2FmZS1BLzEyOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAg
IGhhcmQtaXJxcy1vbiArIGlycS1zYWZlLUEvMjE6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICAg
c29mdC1pcnFzLW9uICsgaXJxLXNhZmUtQS8yMTogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgICAg
IHNpcnEtc2FmZS1BID0+IGhpcnFzLW9uLzEyOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgICAg
c2lycS1zYWZlLUEgPT4gaGlycXMtb24vMjE6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICAgICAg
IGhhcmQtc2FmZS1BICsgaXJxcy1vbi8xMjogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgICAgICAg
c29mdC1zYWZlLUEgKyBpcnFzLW9uLzEyOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgICAgICBo
YXJkLXNhZmUtQSArIGlycXMtb24vMjE6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICAgICAgIHNv
ZnQtc2FmZS1BICsgaXJxcy1vbi8yMTogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIGhhcmQtc2Fm
ZS1BICsgdW5zYWZlLUIgIzEvMTIzOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgc29mdC1zYWZl
LUEgKyB1bnNhZmUtQiAjMS8xMjM6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBoYXJkLXNhZmUt
QSArIHVuc2FmZS1CICMxLzEzMjogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIHNvZnQtc2FmZS1B
ICsgdW5zYWZlLUIgIzEvMTMyOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgaGFyZC1zYWZlLUEg
KyB1bnNhZmUtQiAjMS8yMTM6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBzb2Z0LXNhZmUtQSAr
IHVuc2FmZS1CICMxLzIxMzogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIGhhcmQtc2FmZS1BICsg
dW5zYWZlLUIgIzEvMjMxOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgc29mdC1zYWZlLUEgKyB1
bnNhZmUtQiAjMS8yMzE6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBoYXJkLXNhZmUtQSArIHVu
c2FmZS1CICMxLzMxMjogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIHNvZnQtc2FmZS1BICsgdW5z
YWZlLUIgIzEvMzEyOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgaGFyZC1zYWZlLUEgKyB1bnNh
ZmUtQiAjMS8zMjE6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBzb2Z0LXNhZmUtQSArIHVuc2Fm
ZS1CICMxLzMyMTogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIGhhcmQtc2FmZS1BICsgdW5zYWZl
LUIgIzIvMTIzOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgc29mdC1zYWZlLUEgKyB1bnNhZmUt
QiAjMi8xMjM6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBoYXJkLXNhZmUtQSArIHVuc2FmZS1C
ICMyLzEzMjogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIHNvZnQtc2FmZS1BICsgdW5zYWZlLUIg
IzIvMTMyOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgaGFyZC1zYWZlLUEgKyB1bnNhZmUtQiAj
Mi8yMTM6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBzb2Z0LXNhZmUtQSArIHVuc2FmZS1CICMy
LzIxMzogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIGhhcmQtc2FmZS1BICsgdW5zYWZlLUIgIzIv
MjMxOiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgc29mdC1zYWZlLUEgKyB1bnNhZmUtQiAjMi8y
MzE6ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBoYXJkLXNhZmUtQSArIHVuc2FmZS1CICMyLzMx
MjogIG9rICB8ICBvayAgfCAgb2sgIHwKICAgIHNvZnQtc2FmZS1BICsgdW5zYWZlLUIgIzIvMzEy
OiAgb2sgIHwgIG9rICB8ICBvayAgfAogICAgaGFyZC1zYWZlLUEgKyB1bnNhZmUtQiAjMi8zMjE6
ICBvayAgfCAgb2sgIHwgIG9rICB8CiAgICBzb2Z0LXNhZmUtQSArIHVuc2FmZS1CICMyLzMyMTog
IG9rICB8ICBvayAgfCAgb2sgIHwKICAgICAgaGFyZC1pcnEgbG9jay1pbnZlcnNpb24vMTIzOiAg
b2sgIHwgIG9rICB8ICBvayAgfAogICAgICBzb2Z0LWlycSBsb2NrLWludmVyc2lvbi8xMjM6ICBv
ayAgfCAgb2sgIHwgIG9rICB8CiAgICAgIGhhcmQtaXJxIGxvY2staW52ZXJzaW9uLzEzMjogIG9r
ICB8ICBvayAgfCAgb2sgIHwKICAgICAgc29mdC1pcnEgbG9jay1pbnZlcnNpb24vMTMyOiAgb2sg
IHwgIG9rICB8ICBvayAgfAogICAgICBoYXJkLWlycSBsb2NrLWludmVyc2lvbi8yMTM6ICBvayAg
fCAgb2sgIHwgIG9rICB8CiAgICAgIHNvZnQtaXJxIGxvY2staW52ZXJzaW9uLzIxMzogIG9rICB8
ICBvayAgfCAgb2sgIHwKICAgICAgaGFyZC1pcnEgbG9jay1pbnZlcnNpb24vMjMxOiAgb2sgIHwg
IG9rICB8ICBvayAgfAogICAgICBzb2Z0LWlycSBsb2NrLWludmVyc2lvbi8yMzE6ICBvayAgfCAg
b2sgIHwgIG9rICB8CiAgICAgIGhhcmQtaXJxIGxvY2staW52ZXJzaW9uLzMxMjogIG9rICB8ICBv
ayAgfCAgb2sgIHwKICAgICAgc29mdC1pcnEgbG9jay1pbnZlcnNpb24vMzEyOiAgb2sgIHwgIG9r
ICB8ICBvayAgfAogICAgICBoYXJkLWlycSBsb2NrLWludmVyc2lvbi8zMjE6ICBvayAgfCAgb2sg
IHwgIG9rICB8CiAgICAgIHNvZnQtaXJxIGxvY2staW52ZXJzaW9uLzMyMTogIG9rICB8ICBvayAg
fCAgb2sgIHwKICAgICAgaGFyZC1pcnEgcmVhZC1yZWN1cnNpb24vMTIzOiAgb2sgIHwKICAgICAg
c29mdC1pcnEgcmVhZC1yZWN1cnNpb24vMTIzOiAgb2sgIHwKICAgICAgaGFyZC1pcnEgcmVhZC1y
ZWN1cnNpb24vMTMyOiAgb2sgIHwKICAgICAgc29mdC1pcnEgcmVhZC1yZWN1cnNpb24vMTMyOiAg
b2sgIHwKICAgICAgaGFyZC1pcnEgcmVhZC1yZWN1cnNpb24vMjEzOiAgb2sgIHwKICAgICAgc29m
dC1pcnEgcmVhZC1yZWN1cnNpb24vMjEzOiAgb2sgIHwKICAgICAgaGFyZC1pcnEgcmVhZC1yZWN1
cnNpb24vMjMxOiAgb2sgIHwKICAgICAgc29mdC1pcnEgcmVhZC1yZWN1cnNpb24vMjMxOiAgb2sg
IHwKICAgICAgaGFyZC1pcnEgcmVhZC1yZWN1cnNpb24vMzEyOiAgb2sgIHwKICAgICAgc29mdC1p
cnEgcmVhZC1yZWN1cnNpb24vMzEyOiAgb2sgIHwKICAgICAgaGFyZC1pcnEgcmVhZC1yZWN1cnNp
b24vMzIxOiAgb2sgIHwKICAgICAgc29mdC1pcnEgcmVhZC1yZWN1cnNpb24vMzIxOiAgb2sgIHwK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpH
b29kLCBhbGwgMjE4IHRlc3RjYXNlcyBwYXNzZWQhIHwKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEzMTA3MiAob3JkZXI6
IDcsIDUyNDI4OCBieXRlcykKSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAo
b3JkZXI6IDYsIDI2MjE0NCBieXRlcykKTWVtb3J5OiAyMDcxNjI0ay8yMDk2ODMyayBhdmFpbGFi
bGUgKDIyMzBrIGtlcm5lbCBjb2RlLCAyNDA3MmsgcmVzZXJ2ZWQsIDkyMGsgZGF0YSwgMjEyayBp
bml0LCAxMTc5MzI4ayBoaWdobWVtKQpDaGVja2luZyBpZiB0aGlzIHByb2Nlc3NvciBob25vdXJz
IHRoZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1vZGUuLi4gT2suCkNhbGlicmF0aW5nIGRl
bGF5IHVzaW5nIHRpbWVyIHNwZWNpZmljIHJvdXRpbmUuLiA0NDAyLjg1IEJvZ29NSVBTIChscGo9
MjIwMTQyNSkKTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIKQ1BVOiBBZnRlciBn
ZW5lcmljIGlkZW50aWZ5LCBjYXBzOiAxNzhiZmJmZiBlM2QzZmJmZiAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMSAwMDAwMDAwMCAwMDAwMDAwMwpDUFU6IEFmdGVyIHZlbmRvciBpZGVudGlmeSwg
Y2FwczogMTc4YmZiZmYgZTNkM2ZiZmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDEgMDAwMDAw
MDAgMDAwMDAwMDMKQ1BVOiBMMSBJIENhY2hlOiA2NEsgKDY0IGJ5dGVzL2xpbmUpLCBEIGNhY2hl
IDY0SyAoNjQgYnl0ZXMvbGluZSkKQ1BVOiBMMiBDYWNoZTogMTAyNEsgKDY0IGJ5dGVzL2xpbmUp
CkNQVSAwKDIpIC0+IENvcmUgMApDUFU6IEFmdGVyIGFsbCBpbml0cywgY2FwczogMTc4YmZiZmYg
ZTNkM2ZiZmYgMDAwMDAwMDAgMDAwMDA0MTAgMDAwMDAwMDEgMDAwMDAwMDAgMDAwMDAwMDMKSW50
ZWwgbWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUgc3VwcG9ydGVkLgpJbnRlbCBtYWNoaW5lIGNo
ZWNrIHJlcG9ydGluZyBlbmFibGVkIG9uIENQVSMwLgpDaGVja2luZyAnaGx0JyBpbnN0cnVjdGlv
bi4uLiBPSy4KRnJlZWluZyBTTVAgYWx0ZXJuYXRpdmVzOiAxMmsgZnJlZWQKQUNQSTogQ29yZSBy
ZXZpc2lvbiAyMDA2MDcwNwpDUFUwOiBBTUQgQXRobG9uKHRtKSA2NCBYMiBEdWFsIENvcmUgUHJv
Y2Vzc29yIDQ0MDArIHN0ZXBwaW5nIDAyCmxvY2tkZXA6IG5vdCBmaXhpbmcgdXAgYWx0ZXJuYXRp
dmVzLgpCb290aW5nIHByb2Nlc3NvciAxLzEgZWlwIDIwMDAKQ1BVIDEgaXJxc3RhY2tzLCBoYXJk
PWMwNGFlMDAwIHNvZnQ9YzA0YWMwMDAKSW5pdGlhbGl6aW5nIENQVSMxCkNhbGlicmF0aW5nIGRl
bGF5IHVzaW5nIHRpbWVyIHNwZWNpZmljIHJvdXRpbmUuLiA0Mzk5LjUyIEJvZ29NSVBTIChscGo9
MjE5OTc2MykKQ1BVOiBBZnRlciBnZW5lcmljIGlkZW50aWZ5LCBjYXBzOiAxNzhiZmJmZiBlM2Qz
ZmJmZiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMSAwMDAwMDAwMCAwMDAwMDAwMwpDUFU6IEFm
dGVyIHZlbmRvciBpZGVudGlmeSwgY2FwczogMTc4YmZiZmYgZTNkM2ZiZmYgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDEgMDAwMDAwMDAgMDAwMDAwMDMKQ1BVOiBMMSBJIENhY2hlOiA2NEsgKDY0
IGJ5dGVzL2xpbmUpLCBEIGNhY2hlIDY0SyAoNjQgYnl0ZXMvbGluZSkKQ1BVOiBMMiBDYWNoZTog
MTAyNEsgKDY0IGJ5dGVzL2xpbmUpCkNQVSAxKDIpIC0+IENvcmUgMQpDUFU6IEFmdGVyIGFsbCBp
bml0cywgY2FwczogMTc4YmZiZmYgZTNkM2ZiZmYgMDAwMDAwMDAgMDAwMDA0MTAgMDAwMDAwMDEg
MDAwMDAwMDAgMDAwMDAwMDMKSW50ZWwgbWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUgc3VwcG9y
dGVkLgpJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBlbmFibGVkIG9uIENQVSMxLgpDUFUx
OiBBTUQgQXRobG9uKHRtKSA2NCBYMiBEdWFsIENvcmUgUHJvY2Vzc29yIDQ0MDArIHN0ZXBwaW5n
IDAyClRvdGFsIG9mIDIgcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDg4MDIuMzcgQm9nb01JUFMpLgpF
TkFCTElORyBJTy1BUElDIElSUXMKLi5USU1FUjogdmVjdG9yPTB4MzEgYXBpYzE9MCBwaW4xPTIg
YXBpYzI9LTEgcGluMj0tMQpjaGVja2luZyBUU0Mgc3luY2hyb25pemF0aW9uIGFjcm9zcyAyIENQ
VXM6IApDUFUjMCBoYWQgLTMwIHVzZWNzIFRTQyBza2V3LCBmaXhlZCBpdCB1cC4KQ1BVIzEgaGFk
IDMwIHVzZWNzIFRTQyBza2V3LCBmaXhlZCBpdCB1cC4KQnJvdWdodCB1cCAyIENQVXMKbWlncmF0
aW9uX2Nvc3Q9MzkzCk5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYKQUNQSTogYnVz
IHR5cGUgcGNpIHJlZ2lzdGVyZWQKUENJOiBQQ0kgQklPUyByZXZpc2lvbiAzLjAwIGVudHJ5IGF0
IDB4ZjAwMzEsIGxhc3QgYnVzPTQKUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMQpTZXR0
aW5nIHVwIHN0YW5kYXJkIFBDSSByZXNvdXJjZXMKQUNQSTogSW50ZXJwcmV0ZXIgZW5hYmxlZApB
Q1BJOiBVc2luZyBJT0FQSUMgZm9yIGludGVycnVwdCByb3V0aW5nCkFDUEk6IFBDSSBSb290IEJy
aWRnZSBbUENJMF0gKDAwMDA6MDApClBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUgKGJ1cyAwMCkK
UENJIHF1aXJrOiByZWdpb24gMDgwMC0wODNmIGNsYWltZWQgYnkgYWxpNzEwMSBBQ1BJCkJvb3Qg
dmlkZW8gZGV2aWNlIGlzIDAwMDA6MDM6MDAuMApQQ0k6IFRyYW5zcGFyZW50IGJyaWRnZSAtIDAw
MDA6MDA6MDYuMApBQ1BJOiBQQ0kgSW50ZXJydXB0IFJvdXRpbmcgVGFibGUgW1xfU0JfLlBDSTAu
X1BSVF0KQUNQSTogUENJIEludGVycnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLlAwUDQu
X1BSVF0KQUNQSTogUENJIEludGVycnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLkhUVF8u
X1BSVF0KQUNQSTogUENJIEludGVycnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLlBFQjEu
X1BSVF0KQUNQSTogUENJIEludGVycnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLlBFQjIu
X1BSVF0KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktBXSAoSVJRcyAzIDQgKjUgNiA3IDEw
IDExIDEyIDE0IDE1KQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0JdIChJUlFzIDMgNCA1
IDYgNyAqMTAgMTEgMTIgMTQgMTUpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQ10gKElS
UXMgMyA0IDUgNiA3ICoxMCAxMSAxMiAxNCAxNSksIGRpc2FibGVkLgpBQ1BJOiBQQ0kgSW50ZXJy
dXB0IExpbmsgW0xOS0RdIChJUlFzIDMgNCA1IDYgNyAqMTAgMTEgMTIgMTQgMTUpLCBkaXNhYmxl
ZC4KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktFXSAoSVJRcyAzIDQgNSA2IDcgMTAgKjEx
IDEyIDE0IDE1KQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0ZdIChJUlFzICozIDQgNSA2
IDcgMTAgMTEgMTIgMTQgMTUpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LR10gKElSUXMg
MyA0IDUgNiA3IDEwICoxMSAxMiAxNCAxNSkKQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktI
XSAoSVJRcyAzIDQgNSA2IDcgMTAgMTEgMTIgMTQgMTUpICo5CkFDUEk6IFBDSSBJbnRlcnJ1cHQg
TGluayBbTE5LUF0gKElSUXMgMyA0ICo1IDYgNyAxMCAxMSAxMiAxNCAxNSkKU0NTSSBzdWJzeXN0
ZW0gaW5pdGlhbGl6ZWQKUENJOiBVc2luZyBBQ1BJIGZvciBJUlEgcm91dGluZwpQQ0k6IElmIGEg
ZGV2aWNlIGRvZXNuJ3Qgd29yaywgdHJ5ICJwY2k9cm91dGVpcnEiLiAgSWYgaXQgaGVscHMsIHBv
c3QgYSByZXBvcnQKUENJOiBCcmlkZ2U6IDAwMDA6MDA6MDEuMAogIElPIHdpbmRvdzogZGlzYWJs
ZWQuCiAgTUVNIHdpbmRvdzogZmYyMDAwMDAtZmYyZmZmZmYKICBQUkVGRVRDSCB3aW5kb3c6IGRp
c2FibGVkLgpQQ0k6IEJyaWRnZTogMDAwMDowMDowMi4wCiAgSU8gd2luZG93OiBkaXNhYmxlZC4K
ICBNRU0gd2luZG93OiBmZjMwMDAwMC1mZjNmZmZmZgogIFBSRUZFVENIIHdpbmRvdzogZGlzYWJs
ZWQuClBDSTogQnJpZGdlOiAwMDAwOjAwOjA1LjAKICBJTyB3aW5kb3c6IGRpc2FibGVkLgogIE1F
TSB3aW5kb3c6IGZmNDAwMDAwLWZmNGZmZmZmCiAgUFJFRkVUQ0ggd2luZG93OiBjN2YwMDAwMC1k
N2VmZmZmZgpQQ0k6IEJyaWRnZTogMDAwMDowMDowNi4wCiAgSU8gd2luZG93OiBkMDAwLWRmZmYK
ICBNRU0gd2luZG93OiBmZjUwMDAwMC1mZjVmZmZmZgogIFBSRUZFVENIIHdpbmRvdzogODgwMDAw
MDAtODgwZmZmZmYKQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAwOjAxLjBbQV0gLT4gR1NJIDI5
IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2
aWNlIDAwMDA6MDA6MDEuMCB0byA2NApBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MDIuMFtB
XSAtPiBHU0kgMzQgKGxldmVsLCBsb3cpIC0+IElSUSAxNwpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0
aW1lciBvZiBkZXZpY2UgMDAwMDowMDowMi4wIHRvIDY0ClBDSTogU2V0dGluZyBsYXRlbmN5IHRp
bWVyIG9mIGRldmljZSAwMDAwOjAwOjA1LjAgdG8gNjQKUENJOiBTZXR0aW5nIGxhdGVuY3kgdGlt
ZXIgb2YgZGV2aWNlIDAwMDA6MDA6MDYuMCB0byA2NApORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wg
ZmFtaWx5IDIKSVAgcm91dGUgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3JkZXI6
IDUsIDEzMTA3MiBieXRlcykKVENQIGVzdGFibGlzaGVkIGhhc2ggdGFibGUgZW50cmllczogNjU1
MzYgKG9yZGVyOiA5LCAyMzU5Mjk2IGJ5dGVzKQpUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6
IDMyNzY4IChvcmRlcjogOCwgMTE3OTY0OCBieXRlcykKVENQOiBIYXNoIHRhYmxlcyBjb25maWd1
cmVkIChlc3RhYmxpc2hlZCA2NTUzNiBiaW5kIDMyNzY4KQpUQ1AgcmVubyByZWdpc3RlcmVkCk1h
Y2hpbmUgY2hlY2sgZXhjZXB0aW9uIHBvbGxpbmcgdGltZXIgc3RhcnRlZC4KSW5pdGlhbGl6aW5n
IFJULVRlc3RlcjogT0sKaGlnaG1lbSBib3VuY2UgcG9vbCBzaXplOiA2NCBwYWdlcwppbyBzY2hl
ZHVsZXIgbm9vcCByZWdpc3RlcmVkCmlvIHNjaGVkdWxlciBjZnEgcmVnaXN0ZXJlZCAoZGVmYXVs
dCkKdmVzYWZiOiBmcmFtZWJ1ZmZlciBhdCAweGM4MDAwMDAwLCBtYXBwZWQgdG8gMHhmODg4MDAw
MCwgdXNpbmcgMzA3MmssIHRvdGFsIDE2Mzg0awp2ZXNhZmI6IG1vZGUgaXMgMTAyNHg3Njh4MTYs
IGxpbmVsZW5ndGg9MjA0OCwgcGFnZXM9OQp2ZXNhZmI6IHByb3RlY3RlZCBtb2RlIGludGVyZmFj
ZSBpbmZvIGF0IGMwMDA6Nzg4MAp2ZXNhZmI6IHBtaTogc2V0IGRpc3BsYXkgc3RhcnQgPSBjMDBj
NzlkMywgc2V0IHBhbGV0dGUgPSBjMDBjN2FiMwp2ZXNhZmI6IHBtaTogcG9ydHMgPSAKdmVzYWZi
OiBzY3JvbGxpbmc6IHJlZHJhdwp2ZXNhZmI6IFRydWVjb2xvcjogc2l6ZT0wOjU6Njo1LCBzaGlm
dD0wOjExOjU6MApDb25zb2xlOiBzd2l0Y2hpbmcgdG8gY29sb3VyIGZyYW1lIGJ1ZmZlciBkZXZp
Y2UgMTI4eDQ4CmZiMDogVkVTQSBWR0EgZnJhbWUgYnVmZmVyIGRldmljZQpSZWFsIFRpbWUgQ2xv
Y2sgRHJpdmVyIHYxLjEyYWMKU2VyaWFsOiA4MjUwLzE2NTUwIGRyaXZlciAkUmV2aXNpb246IDEu
OTAgJCAyIHBvcnRzLCBJUlEgc2hhcmluZyBkaXNhYmxlZApzZXJpYWw4MjUwOiB0dHlTMCBhdCBJ
L08gMHgzZjggKGlycSA9IDQpIGlzIGEgMTY1NTBBCkZsb3BweSBkcml2ZShzKTogZmQwIGlzIDEu
NDRNCkZEQyAwIGlzIGEgcG9zdC0xOTkxIDgyMDc3CnZpYS1yaGluZS5jOnYxLjEwLUxLMS40LjEg
SnVseS0yNC0yMDA2IFdyaXR0ZW4gYnkgRG9uYWxkIEJlY2tlcgpBQ1BJOiBQQ0kgSW50ZXJydXB0
IDAwMDA6MDQ6MDcuMFtBXSAtPiBHU0kgMjIgKGxldmVsLCBsb3cpIC0+IElSUSAxOApldGgwOiBW
SUEgUmhpbmUgSUkgYXQgMHhmZjVmZWMwMCwgMDA6NTA6YmE6ZjI6YTM6MWQsIElSUSAxOC4KZXRo
MDogTUlJIFBIWSBmb3VuZCBhdCBhZGRyZXNzIDgsIHN0YXR1cyAweDc4MmQgYWR2ZXJ0aXNpbmcg
MDFlMSBMaW5rIDQ1ZTEuCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowNDowNi4wW0FdIC0+IEdT
SSAyMSAobGV2ZWwsIGxvdykgLT4gSVJRIDE5CnNjc2kwIDogQWRhcHRlYyBBSUM3WFhYIEVJU0Ev
VkxCL1BDSSBTQ1NJIEhCQSBEUklWRVIsIFJldiA3LjAKICAgICAgICA8QWRhcHRlYyAyOTE2ME4g
VWx0cmExNjAgU0NTSSBhZGFwdGVyPgogICAgICAgIGFpYzc4OTI6IFVsdHJhMTYwIFdpZGUgQ2hh
bm5lbCBBLCBTQ1NJIElkPTcsIDMyLzI1MyBTQ0JzCgogIFZlbmRvcjogUElPTkVFUiAgIE1vZGVs
OiBEVkQtUk9NIERWRC0zMDUgICBSZXY6IDEuMDMKICBUeXBlOiAgIENELVJPTSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQU5TSSBTQ1NJIHJldmlzaW9uOiAwMgogdGFyZ2V0MDowOjQ6IEJl
Z2lubmluZyBEb21haW4gVmFsaWRhdGlvbgogdGFyZ2V0MDowOjQ6IEZBU1QtMjAgU0NTSSAyMC4w
IE1CL3MgU1QgKDUwIG5zLCBvZmZzZXQgMTYpCiB0YXJnZXQwOjA6NDogRG9tYWluIFZhbGlkYXRp
b24gc2tpcHBpbmcgd3JpdGUgdGVzdHMKIHRhcmdldDA6MDo0OiBFbmRpbmcgRG9tYWluIFZhbGlk
YXRpb24KICBWZW5kb3I6IFBMRVhUT1IgICBNb2RlbDogQ0QtUiAgIFBYLVcxMjEwUyAgUmV2OiAx
LjAxCiAgVHlwZTogICBDRC1ST00gICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFOU0kgU0NT
SSByZXZpc2lvbjogMDIKIHRhcmdldDA6MDo1OiBCZWdpbm5pbmcgRG9tYWluIFZhbGlkYXRpb24K
IHRhcmdldDA6MDo1OiBGQVNULTIwIFNDU0kgMjAuMCBNQi9zIFNUICg1MCBucywgb2Zmc2V0IDE2
KQogdGFyZ2V0MDowOjU6IERvbWFpbiBWYWxpZGF0aW9uIHNraXBwaW5nIHdyaXRlIHRlc3RzCiB0
YXJnZXQwOjA6NTogRW5kaW5nIERvbWFpbiBWYWxpZGF0aW9uCiAgVmVuZG9yOiBJQk0gICAgICAg
TW9kZWw6IEREWVMtVDM2OTUwTiAgICAgIFJldjogUzk2SAogIFR5cGU6ICAgRGlyZWN0LUFjY2Vz
cyAgICAgICAgICAgICAgICAgICAgICBBTlNJIFNDU0kgcmV2aXNpb246IDAzCnNjc2kwOkE6Njow
OiBUYWdnZWQgUXVldWluZyBlbmFibGVkLiAgRGVwdGggMjAwCiB0YXJnZXQwOjA6NjogQmVnaW5u
aW5nIERvbWFpbiBWYWxpZGF0aW9uCiB0YXJnZXQwOjA6Njogd2lkZSBhc3luY2hyb25vdXMKIHRh
cmdldDA6MDo2OiBGQVNULTgwIFdJREUgU0NTSSAxNjAuMCBNQi9zIERUICgxMi41IG5zLCBvZmZz
ZXQgNjMpCiB0YXJnZXQwOjA6NjogRW5kaW5nIERvbWFpbiBWYWxpZGF0aW9uClNDU0kgZGV2aWNl
IHNkYTogNzE2ODczNDAgNTEyLWJ5dGUgaGR3ciBzZWN0b3JzICgzNjcwNCBNQikKc2RhOiBXcml0
ZSBQcm90ZWN0IGlzIG9mZgpzZGE6IE1vZGUgU2Vuc2U6IGNiIDAwIDAwIDA4ClNDU0kgZGV2aWNl
IHNkYTogZHJpdmUgY2FjaGU6IHdyaXRlIGJhY2sKU0NTSSBkZXZpY2Ugc2RhOiA3MTY4NzM0MCA1
MTItYnl0ZSBoZHdyIHNlY3RvcnMgKDM2NzA0IE1CKQpzZGE6IFdyaXRlIFByb3RlY3QgaXMgb2Zm
CnNkYTogTW9kZSBTZW5zZTogY2IgMDAgMDAgMDgKU0NTSSBkZXZpY2Ugc2RhOiBkcml2ZSBjYWNo
ZTogd3JpdGUgYmFjawogc2RhOiBzZGExIHNkYTIgc2RhMyBzZGE0CnNkIDA6MDo2OjA6IEF0dGFj
aGVkIHNjc2kgZGlzayBzZGEKc3IwOiBzY3NpMy1tbWMgZHJpdmU6IDE2eC80MHggY2QvcncgeGEv
Zm9ybTIgY2RkYSB0cmF5ClVuaWZvcm0gQ0QtUk9NIGRyaXZlciBSZXZpc2lvbjogMy4yMApzciAw
OjA6NDowOiBBdHRhY2hlZCBzY3NpIENELVJPTSBzcjAKc3IxOiBzY3NpMy1tbWMgZHJpdmU6IDMy
eC8zMnggd3JpdGVyIGNkL3J3IHhhL2Zvcm0yIGNkZGEgdHJheQpzciAwOjA6NTowOiBBdHRhY2hl
ZCBzY3NpIENELVJPTSBzcjEKc3IgMDowOjQ6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMCB0
eXBlIDUKc3IgMDowOjU6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMSB0eXBlIDUKc2QgMDow
OjY6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMiB0eXBlIDAKc2VyaW86IGk4MDQyIEFVWCBw
b3J0IGF0IDB4NjAsMHg2NCBpcnEgMTIKc2VyaW86IGk4MDQyIEtCRCBwb3J0IGF0IDB4NjAsMHg2
NCBpcnEgMQptaWNlOiBQUy8yIG1vdXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNlCkVEQUMg
TUM6IFZlcjogMi4wLjEgU2VwIDE4IDIwMDYKVENQIGJpYyByZWdpc3RlcmVkCk5FVDogUmVnaXN0
ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQpORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3
ClN0YXJ0aW5nIGJhbGFuY2VkX2lycQpVc2luZyBJUEkgU2hvcnRjdXQgbW9kZQpUaW1lOiBhY3Bp
X3BtIGNsb2Nrc291cmNlIGhhcyBiZWVuIGluc3RhbGxlZC4KaW5wdXQ6IEFUIFRyYW5zbGF0ZWQg
U2V0IDIga2V5Ym9hcmQgYXMgL2NsYXNzL2lucHV0L2lucHV0MApram91cm5hbGQgc3RhcnRpbmcu
ICBDb21taXQgaW50ZXJ2YWwgNSBzZWNvbmRzCkVYVDMtZnM6IG1vdW50ZWQgZmlsZXN5c3RlbSB3
aXRoIG9yZGVyZWQgZGF0YSBtb2RlLgpWRlM6IE1vdW50ZWQgcm9vdCAoZXh0MyBmaWxlc3lzdGVt
KSByZWFkb25seS4KRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMjEyayBmcmVlZApXcml0
ZSBwcm90ZWN0aW5nIHRoZSBrZXJuZWwgcmVhZC1vbmx5IGRhdGE6IDM2OGsKaW5wdXQ6IEltRXhQ
Uy8yIEdlbmVyaWMgRXhwbG9yZXIgTW91c2UgYXMgL2NsYXNzL2lucHV0L2lucHV0MQpBZGRpbmcg
NzYzMDc2ayBzd2FwIG9uIC9kZXYvc2RhMy4gIFByaW9yaXR5Oi0xIGV4dGVudHM6MSBhY3Jvc3M6
NzYzMDc2awpFWFQzIEZTIG9uIHNkYTEsIGludGVybmFsIGpvdXJuYWwKQUNQSTogUENJIEludGVy
cnVwdCAwMDAwOjA0OjA1LjBbQV0gLT4gR1NJIDIwIChsZXZlbCwgbG93KSAtPiBJUlEgMjAKTGlu
dXggYWdwZ2FydCBpbnRlcmZhY2UgdjAuMTAxIChjKSBEYXZlIEpvbmVzClJlaXNlckZTOiBzZGEy
OiBmb3VuZCByZWlzZXJmcyBmb3JtYXQgIjMuNiIgd2l0aCBzdGFuZGFyZCBqb3VybmFsClJlaXNl
ckZTOiBzZGEyOiB1c2luZyBvcmRlcmVkIGRhdGEgbW9kZQpSZWlzZXJGUzogc2RhMjogam91cm5h
bCBwYXJhbXM6IGRldmljZSBzZGEyLCBzaXplIDgxOTIsIGpvdXJuYWwgZmlyc3QgYmxvY2sgMTgs
IG1heCB0cmFucyBsZW4gMTAyNCwgbWF4IGJhdGNoIDkwMCwgbWF4IGNvbW1pdCBhZ2UgMzAsIG1h
eCB0cmFucyBhZ2UgMzAKUmVpc2VyRlM6IHNkYTI6IGNoZWNraW5nIHRyYW5zYWN0aW9uIGxvZyAo
c2RhMikKUmVpc2VyRlM6IHNkYTI6IFVzaW5nIHI1IGhhc2ggdG8gc29ydCBuYW1lcwpSZWlzZXJG
Uzogc2RhNDogZm91bmQgcmVpc2VyZnMgZm9ybWF0ICIzLjYiIHdpdGggc3RhbmRhcmQgam91cm5h
bApSZWlzZXJGUzogc2RhNDogdXNpbmcgb3JkZXJlZCBkYXRhIG1vZGUKUmVpc2VyRlM6IHNkYTQ6
IGpvdXJuYWwgcGFyYW1zOiBkZXZpY2Ugc2RhNCwgc2l6ZSA4MTkyLCBqb3VybmFsIGZpcnN0IGJs
b2NrIDE4LCBtYXggdHJhbnMgbGVuIDEwMjQsIG1heCBiYXRjaCA5MDAsIG1heCBjb21taXQgYWdl
IDMwLCBtYXggdHJhbnMgYWdlIDMwClJlaXNlckZTOiBzZGE0OiBjaGVja2luZyB0cmFuc2FjdGlv
biBsb2cgKHNkYTQpClJlaXNlckZTOiBzZGE0OiBVc2luZyByNSBoYXNoIHRvIHNvcnQgbmFtZXMK
ZXRoMDogbGluayB1cCwgMTAwTWJwcywgZnVsbC1kdXBsZXgsIGxwYSAweDQ1RTEK
------=_Part_16609_6413418.1158700483339--
