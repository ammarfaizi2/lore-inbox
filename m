Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275260AbRIZPVB>; Wed, 26 Sep 2001 11:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275256AbRIZPUw>; Wed, 26 Sep 2001 11:20:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:47136 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S275260AbRIZPUo>;
	Wed, 26 Sep 2001 11:20:44 -0400
Date: Tue, 25 Sep 2001 19:34:58 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 2.4.10: ifconfig gets signal 17
Message-ID: <20010925193458.A592@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.10 i686
X-Editor: VIM - Vi IMproved 5.7 (2000 Jun 24, compiled Apr  6 2001 09:59:07)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
     
	 2.4.10: ifconfig gets signal 17

[2.] Full description of the problem/report:
     
	 After updating from kernel 2.4.9 to 2.4.10 I get the following
     error after booting:

	 task `ifconfig' exit_signal 17 in reparent_to_init
	 Sep 25 19:07:58 marvin kernel: task `ifconfig' exit_signal 17 in
	 reparent_to_init

[3.] Keywords
     
	 kernel, networking, ifconfig

[4.] Kernel version

     Linux version 2.4.10 (root@marvin) (gcc version 2.95.2 19991024
	 (release)) #1 Tue Sep 25 18:15:38 CEST 2001

[5.] Output of Oops.. message

     N.A.

[6.] A small shell script

     N.A.

[7.] Environment

[7.1.] Software
       
	   Linux marvin 2.4.10 #1 Tue Sep 25 18:15:38 CEST 2001 i686 unknown

	   Gnu C                  2.95.2
	   Gnu make               3.79.1
	   binutils               2.10.0.33
	   util-linux             2.10s
	   mount                  2.10s
	   modutils               2.4.6
	   e2fsprogs              1.19
	   reiserfsprogs          3.x.0k-pre8
	   PPP                    2.4.1
	   Linux C Library        x    1 root     root      1382179 Jan 19
	   2001 /lib/libc.so.6
	   Dynamic linker (ldd)   2.2
	   Procps                 2.0.7
	   Net-tools              1.57
	   Kbd                    1.02
	   Sh-utils               2.0
	   Modules Loaded         af_packet parport_pc parport khttpd
	                          autofs4 unix 8139too
	                          ide-scsi aic7xxx scsi_mod
	   
[7.2.] Processor

       processor       : 0
	   vendor_id       : CyrixInstead
	   cpu family      : 6
	   model           : 2
	   model name      : 6x86MX 2.5x Core/Bus Clock
	   stepping        : 6
	   cpu MHz         : 167.047
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

[7.3.] Module information

       af_packet              11104   1 (autoclean)
	   khttpd                 21392   3
	   autofs4                 8032   1 (autoclean)
	   unix                   13664  75 (autoclean)
	   8139too                11616   1
	   ide-scsi                7472   0
	   aic7xxx               104384   0
	   scsi_mod               83616   2 [ide-scsi aic7xxx]

[7.4.] Loaded driver and hardware information

       marvin:~ # cat /proc/ioports
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
	     00100000-001cfa35 : Kernel code
		 001cfa36-002000d3 : Kernel data
	   e0000000-e1ffffff : nVidia Corporation Vanta [NV6]
	   e2000000-e2ffffff : nVidia Corporation Vanta [NV6]
	   e3000000-e3000fff : Adaptec AIC-7861
	     e3000000-e3000fff : aic7xxx
	   e3001000-e30010ff : Realtek Semiconductor Co., Ltd. RTL-8139
	     e3001000-e30010ff : 8139too
	   ffff0000-ffffffff : reserved

[7.5.] PCI information
       
       marvin:~ # lspci -vvv
00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:08.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6000 [disabled] [size=256]
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
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information
       
	   Host: scsi0 Channel: 00 Id: 01 Lun: 00
	     Vendor: TANDBERG Model:  TDC 3600        Rev: =08:
	     Type:   Sequential-Access                ANSI SCSI revision: 02
	   Host: scsi0 Channel: 00 Id: 05 Lun: 00
	     Vendor: IOMEGA   Model: ZIP 100          Rev: C.19
		 Type:   Direct-Access                    ANSI SCSI revision: 02
	   Host: scsi0 Channel: 00 Id: 06 Lun: 00
	     Vendor: SCANNER  Model:                  Rev: 1.01
		 Type:   Scanner                          ANSI SCSI revision: 01 CCS
	   Host: scsi1 Channel: 00 Id: 00 Lun: 00
	     Vendor: TEAC     Model: CD-W54E          Rev: 1.1Y
		 Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information

       marvin:~ # ifconfig --version
	   net-tools 1.57
	   ifconfig 1.40 (2000-05-21)


My gcc is still version 2.95.2 instead of 2.95.3 as described in
Changes, but there were no compilation problems. The system is working
okay, but I don't know, what the error wants to say. As of signal(7),
signal 17 means SIGCHLD, but what child has died?

TIA,

Manfred
-- 
 /"\                        |  *  AIM: mahowi42  *  ICQ: 61597169  *
 \ /  ASCII ribbon campaign | PGP-Key available at Public Key Servers
  X   against HTML mail     | or "http://www.mahowi.de/pgp/mahowi.asc"
 / \  and postings          |  * RSA: 0xC05BC0F5 * DSS: 0x4613B5CA *
