Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSHKF3U>; Sun, 11 Aug 2002 01:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSHKF3U>; Sun, 11 Aug 2002 01:29:20 -0400
Received: from kih-tnt1-du-178.164.KSP.vol.com ([209.42.178.164]:55825 "EHLO
	hapablap.dns2go.com") by vger.kernel.org with ESMTP
	id <S317708AbSHKF3Q>; Sun, 11 Aug 2002 01:29:16 -0400
Date: Sun, 11 Aug 2002 00:31:56 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Blaise <jblaiseg@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: actiontec PCI call waiting modem not responding with kernels 2.4.7+, 2.4.6 is ok though..
Message-ID: <20020811053156.GA17530@hapablap.dns2go.com>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Blaise <jblaiseg@bellsouth.net>, linux-kernel@vger.kernel.org
References: <3D5569B4.4010500@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5569B4.4010500@bellsouth.net>
User-Agent: Mutt/1.3.27i
X-Uptime: 23:05:50 up 9 days,  1:45,  1 user,  load average: 1.24, 1.10, 1.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, these reports are coming out of the woodwork all of a sudden.  Just
yesterday I got an email from a guy with the same (probably) problem.  I
own an Actiontec PCI call waiting modem, and it works fine with every
version of Linux I've thrown at it; I like it.

First things first:  are you using setserial to set up the modem?  If
so, cut it out.  Modern 2.4 kernels autodetect and setup everything
themselves (Not sure when that started; possibly 2.4.7).  Anyway, try
using /dev/ttyS4 as your modem device and see what happens; that is the
first PCI serial port.

Let me know.

On Sat, Aug 10, 2002 at 03:29:56PM -0400, Blaise wrote:
>            here we go..
> 
> 1 Problem    : Not able to init modem..
> 
> 2 Desc        : Worked fine till 2.4.7..
> 
> 3 Keywords    : PCI Modem
> 
> 4 Kernel version
> 
>    Working    : Linux version 2.4.6 (root@core) (gcc version 2.95.3 
> 20010315 (SuSE)) #1 Wed Jan 16 14:46:28 EST 2002
>     Not working: Linux version 2.4.7 (root@core) (gcc version 2.95.3 
> 20010315 (SuSE)) #1 Wed Jan 16 14:46:28 EST 2002
> 
> 5 Oops        : No oops..
> 
> 6 Recreatable error script : N/A
> 
> 7.1 Environment    :
> 
>    output of ver_linux script
> 
>        <snip>
> 
> Linux core 2.4.6 #1 Wed Jan 16 14:46:28 EST 2002 i586 unknown
> 
> Gnu C                  2.95.3
> Gnu make               3.79.1
> binutils               2.10.91.0.4
> util-linux             2.11b
> mount                  2.11b
> modutils               2.4.5
> e2fsprogs              1.19
> reiserfsprogs          3.x.0j
> pcmcia-cs              3.1.25
> PPP                    2.4.0
> isdn4k-utils           3.1pre1a
> Linux C Library        x    1 root     root      1343073 May 11  2001 
> /lib/libc.so.6
> Dynamic linker (ldd)   2.2.2
> Procps                 2.0.7
> Net-tools              1.60
> Kbd                    1.04
> Sh-utils               2.0
> 
>        <snip>
> 
> 7.2 CPU info    : cat of /proc/cpuinfo
> 
>        <snip>
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 5
> model           : 8
> model name      : AMD-K6(tm) 3D processor
> stepping        : 12
> cpu MHz         : 501.151
> cache size      : 64 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow 
> k6_mtrr
> bogomips        : 999.42
> 
>        <snip>
> 
> 7.3 module info : none
> 
> 7.4 Loaded driver and hardware information
> 
>    from 2.4.6 (working)
>    (/proc/ioports)
> 
>        <snip>
> 
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vesafb
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 6000-60ff : VIA Technologies, Inc. VT82C586B ACPI
> c000-cfff : PCI Bus #01
> d000-d00f : VIA Technologies, Inc. Bus Master IDE
>  d000-d007 : ide0
>  d008-d00f : ide1
> d400-d41f : VIA Technologies, Inc. UHCI USB
> d800-d87f : 3Com Corporation 3cSOHO100-TX Hurricane
>  d800-d87f : 00:08.0
> dc00-dcff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
>  dc00-dc07 : serial(set)
> e000-e0ff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
> e400-e407 : Lucent Microelectronics Venus Modem (V90, 56KFlex)
> 
>        <snip>
> 
>    (/proc/iomem)
> 
>        <snip>
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-03feffff : System RAM
>  00100000-0023776f : Kernel code
>  00237770-002a571b : Kernel data
> 03ff0000-03ff07ff : ACPI Non-volatile Storage
> 03ff0800-03ffffff : ACPI Tables
> e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
> e4000000-e5ffffff : PCI Bus #01
>  e4000000-e4ffffff : nVidia Corporation Riva TnT 128 [NV04]
> e6000000-e6ffffff : PCI Bus #01
>  e6000000-e6ffffff : nVidia Corporation Riva TnT 128 [NV04]
>    e6000000-e6fbffff : vesafb
> e8000000-e800007f : 3Com Corporation 3cSOHO100-TX Hurricane
> e8001000-e80010ff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
> ffff0000-ffffffff : reserved
> 
>        <snip>
> 
>    from 2.4.7 (not working)
>    (/proc/ioports)
> 
>        <snip>
> 
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vesafb
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 6000-60ff : VIA Technologies, Inc. VT82C586B ACPI
> c000-cfff : PCI Bus #01
> d000-d00f : VIA Technologies, Inc. Bus Master IDE
>  d000-d007 : ide0
>  d008-d00f : ide1
> d400-d41f : VIA Technologies, Inc. UHCI USB
> d800-d87f : 3Com Corporation 3cSOHO100-TX Hurricane
>  d800-d87f : 00:08.0
> dc00-dcff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
>  dc00-dc07 : serial(auto)
> e000-e0ff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
> e400-e407 : Lucent Microelectronics Venus Modem (V90, 56KFlex)
> 
>        <snip>
> 
>    (/proc/iomem)
> 
>        <snip>
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-03feffff : System RAM
>  00100000-00222993 : Kernel code
>  00222994-0028febb : Kernel data
> 03ff0000-03ff07ff : ACPI Non-volatile Storage
> 03ff0800-03ffffff : ACPI Tables
> e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
> e4000000-e5ffffff : PCI Bus #01
>  e4000000-e4ffffff : nVidia Corporation Riva TnT 128 [NV04]
> e6000000-e6ffffff : PCI Bus #01
>  e6000000-e6ffffff : nVidia Corporation Riva TnT 128 [NV04]
>    e6000000-e6fbffff : vesafb
> e8000000-e800007f : 3Com Corporation 3cSOHO100-TX Hurricane
> e8001000-e80010ff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
> ffff0000-ffffffff : reserved
> 
>        <snip>
> 
> 7.5 PCI information ('lspci -vvv' as root)
> 
>        <snip>
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR+
>        Latency: 16
>        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
>        Capabilities: [a0] AGP version 1.0
>                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
>                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
> MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort+ >SERR- <PERR-
>        Latency: 0
>        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>        I/O behind bridge: 0000c000-0000cfff
>        Memory behind bridge: e4000000-e5ffffff
>        Prefetchable memory behind bridge: e6000000-e6ffffff
>        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
> [Apollo VP] (rev 47)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
> ParErr- Stepping+ SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
> (prog-if 8a [Master SecP PriP])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64
>        Region 4: I/O ports at d000 [size=16]
> 
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) 
> (prog-if 00 [UHCI])
>        Subsystem: Unknown device 0925:1234
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64, cache line size 08
>        Interrupt: pin D routed to IRQ 5
>        Region 4: I/O ports at d400 [size=32]
> 
> 00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Interrupt: pin ? routed to IRQ 9
> 
> 00:08.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane 
> (rev 30)
>        Subsystem: 3Com Corporation 3cSOHO100-TX Hurricane
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR+
>        Latency: 64 (2500ns min, 2500ns max), cache line size 08
>        Interrupt: pin A routed to IRQ 10
>        Region 0: I/O ports at d800 [size=128]
>        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=128]
>        Expansion ROM at e7000000 [disabled] [size=128K]
>        Capabilities: [dc] Power Management version 1
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.0 Communication controller: Lucent Microelectronics Venus Modem 
> (V90, 56KFlex)
>        Subsystem: Action Tec Electronics Inc: Unknown device 0500
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR+
>        Latency: 0 (63000ns min, 3500ns max)
>        Interrupt: pin A routed to IRQ 11
>        Region 0: Memory at e8001000 (32-bit, non-prefetchable) [size=256]
>        Region 1: I/O ports at dc00 [size=256]
>        Region 2: I/O ports at e000 [size=256]
>        Region 3: I/O ports at e400 [size=8]
>        Capabilities: [f8] Power Management version 2
>                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2+,D3hot+,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128 
> [NV04] (rev 04) (prog-if 00 [VGA])
>        Subsystem: Diamond Multimedia Systems: Unknown device 5802
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (1250ns min, 250ns max)
>        Interrupt: pin A routed to IRQ 0
>        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
>        Region 1: Memory at e6000000 (32-bit, prefetchable) [size=16M]
>        Expansion ROM at e5000000 [disabled] [size=64K]
>        Capabilities: [60] Power Management version 1
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [44] AGP version 1.0
>                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
>                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 
>        <snip>
> 
> 7.6 SCSI/IDE info (cat /proc/ide/via)
> 
>        <snip>
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.20
> South Bridge:                       VIA vt82c586b
> Revision:                           ISA 0x47 IDE 0x6
> BM-DMA base:                        0xd000
> PCI clock:                          33MHz
> Master Read  Cycle IRDY:            1ws
> Master Write Cycle IRDY:            1ws
> BM IDE Status Register Read Retry:  yes
> Max DRDY Pulse Width:               No limit
> -----------------------Primary IDE-------Secondary IDE------
> Read DMA FIFO flush:          yes                 yes
> End Sector FIFO flush:         no                  no
> Prefetch Buffer:              yes                 yes
> Post Write Buffer:            yes                  no
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   40w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:       UDMA      UDMA      UDMA       DMA
> Address Setup:       30ns      30ns      30ns     120ns
> Cmd Active:          90ns      90ns      90ns      90ns
> Cmd Recovery:        30ns      30ns      30ns      30ns
> Data Active:         90ns      90ns      90ns     330ns
> Data Recovery:       30ns      30ns      30ns     270ns
> Cycle Time:          60ns      60ns      60ns     600ns
> Transfer Rate:   33.0MB/s  33.0MB/s  33.0MB/s   3.3MB/s
> 
>        <snip>
> 
> 7.7 Other information that might be relevant to the problem
> 
>    *shrug*
> 
> 
> X.
> 
>        Here are some logs that might come in handy..
> 
>    A clipping from my /var/log/boot.msg
> 
>            <snip>
> 
> <6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
> SERIAL_PCI ISAPNP enabled
> <6>PCI: Found IRQ 11 for device 00:09.0
> <6>ttyS04 at port 0xdc00 (irq = 11) is a 16550A
> 
>            <snip>
> 
> With any kernel later than 2.4.6 this part will sometimes fail, either way
> the modem still won't respond unless useing 2.4.6 or earlyer..
> 
>    A clipping from my /var/log/messages
> 
>            <snip>
> 
> Aug 26 15:39:30 core pppd[381]: Perms of /dev/ttyS0 are ok, no 'mesg n' 
> neccesary.
> Aug 26 15:39:31 core wvdial[696]: WvDial: Internet dialer version 1.41
> Aug 26 15:39:31 core wvdial[696]: Initializing modem.
> Aug 26 15:39:31 core wvdial[696]: Sending: ATZ
> Aug 26 15:39:31 core wvdial[696]: Sending: ATQ0
> Aug 26 15:39:31 core wvdial[696]: Re-Sending: ATZ
> Aug 26 15:39:31 core wvdial[696]: Modem not responding.
> 
>            <snip>
> 
> this works with 2.4.6...
> 
> Please help me!!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
This concept of "wuv" confuses and infuriates us!
			-- Lrrr of Omicron Persei VIII
