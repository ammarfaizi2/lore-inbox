Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbRDBJe5>; Mon, 2 Apr 2001 05:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132654AbRDBJes>; Mon, 2 Apr 2001 05:34:48 -0400
Received: from pc243.vgkk.com ([211.120.7.243]:56850 "EHLO meguro.vgkk.com")
	by vger.kernel.org with ESMTP id <S132652AbRDBJeb>;
	Mon, 2 Apr 2001 05:34:31 -0400
Message-ID: <3AC84751.88150F7@vgkk.com>
Date: Mon, 02 Apr 2001 18:33:05 +0900
From: "A.Sajjad Zaidi" <sajjad@vgkk.com>
Organization: Vanguard K.K.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Gillespie <viking@flying-brick.caverock.net.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: System clock loses time at approx 17 secs per two hours
In-Reply-To: <Pine.LNX.4.21.0104021504320.6492-100000@brick.flying-brick.caverock.net.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you considered using NTP (Network Time Protocol)?

A.Sajjad Zaidi


Eric Gillespie wrote:

> First off, CC: back to me, as my machine can't handle an estimated 200
> messages a day for me to sign up to the list 8-( - Anyway..
>
> I updated my kernel to 2.4.3 when the patch was released. (Tarballs -
> wonderful things!)
>
> However, I noticed that the kernel timer loses seconds over time with both the
> 2.4.2 and 2.4.3 kernels (seems to be at a steady rate...), and the rate of
> loss is NOT related to the CMOS clock. I compared against a 2.2.18 kernel,
> which lost about 1 second in 14 hours - about what I'd expect with my
> machine).
>
> Now, has anybody else noticed their 2.4.x kernel losing time?  If so, and
> anyone knows how I can fix it so it behaves like 2.2.18, I'd be grateful.
>
> <offtopic>
> Can't say I like the April Fools release on "behalf" of Linus.
> </offtopic>
>
> ===================
> Some relevant data:
>  Linux version 2.4.3 (root@brick.flying-brick.caverock.net.nz)
>  (gcc version 2.95.3 19991030 (prerelease)) #2 Sat Mar 31 09:52:39 NZST 2001
>
> Software present (among others)
> Gnu C                  2.95.3          Gnu make               3.77
> binutils               2.9.5.0.31      Linux C Library        2.2.2
> Dynamic linker (ldd)   2.2.2
>
> Processor information (from /proc/cpuinfo) for a Cyrix-M II-300:
> processor       : 0
> vendor_id       : CyrixInstead
> cpu family      : 6
> model           : 2
> model name      : M II 3.5x Core/Bus Clock
> stepping        : 8
> cpu MHz         : 233.030
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
> bogomips        : 465.30
>
> Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> ==Drivers==
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0213-0213 : isapnp read
> 0220-022f : soundblaster
> 02f8-02ff : serial(auto)
> 0300-031f : eth0
> 0376-0376 : ide1
> 0388-038b : Yamaha OPL3
> 03c0-03df : vesafb
> 03f6-03f6 : ide0
> 0a79-0a79 : isapnp write
> 0cf8-0cff : PCI conf1
> 4000-400f : Silicon Integrated Systems [SiS] 5513 [IDE]
>   4000-4007 : ide0
>   4008-400f : ide1
> e000-e07f : Silicon Integrated Systems [SiS] 5597/5598 VGA
> ==memory info==
> 00000000-0009efff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-01cfffff : System RAM
>   00100000-001e9c4f : Kernel code
>   001e9c50-002445d7 : Kernel data
> 08000000-082fffff : vesafb
> e1000000-e13fffff : Silicon Integrated Systems [SiS] 5597/5598 VGA
> e1400000-e140ffff : Silicon Integrated Systems [SiS] 5597/5598 VGA
> e1410000-e141ffff : Rockwell International HCF 56k V90 FaxModem
> [7.5.] PCI information ('lspci -vvv' as root)
> ==PCI Information==
>
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 10)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 64 set
>
> 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 set
>
> 00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 set
>         Interrupt: pin A routed to IRQ 14
>         Region 0: I/O ports at <ignored>
>         Region 1: I/O ports at <ignored>
>         Region 2: I/O ports at <ignored>
>         Region 3: I/O ports at <ignored>
>         Region 4: I/O ports at 4000 [size=16]
>
> 00:0b.0 Serial controller: Rockwell International HCF 56k V90 FaxModem (rev 01) (prog-if 00 [8250])
>         Subsystem: Aztech System Ltd MDP3858SP-A SVD Modem
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 set
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at e1410000 (32-bit, non-prefetchable) [size=64K]
>         Capabilities: [40] Power Management version 1
>                 Flags: PMEClk- AuxPwr+ DSI+ D1+ D2+ PME+
>                 Status: D0 PME-Enable- DSel=0 DScale=3 PME-
>
> 00:14.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 68) (prog-if 00 [VGA])
>         Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0200
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 0
>         Region 0: Memory at e1000000 (32-bit, prefetchable) [size=4M]
>         Region 1: Memory at e1400000 (32-bit, non-prefetchable) [size=64K]
>         Region 2: I/O ports at e000 [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=32K]
>
> --
>  /|   _,.:*^*:.,   |\           Cheers from the Viking family,
> | |_/'  viking@ `\_| |            including Pippin, our cat
> |    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
>  \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

