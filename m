Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbRFLPy4>; Tue, 12 Jun 2001 11:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbRFLPyr>; Tue, 12 Jun 2001 11:54:47 -0400
Received: from Expansa.sns.it ([192.167.206.189]:34567 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S262027AbRFLPyh>;
	Tue, 12 Jun 2001 11:54:37 -0400
Date: Tue, 12 Jun 2001 17:53:56 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Pierfrancesco Caci <p.caci@seabone.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: es1371 and recent kernels
In-Reply-To: <873d95lnqr.fsf@paperino.int-seabone.net>
Message-ID: <Pine.LNX.4.33.0106121747110.16928-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It does work very well for me with 2.4.5 and 2.4.6-pre2, both with or
without devfs, both if sound support has been statically linked or
compiled as module.

On 12 Jun 2001, Pierfrancesco Caci wrote:

>
> [please be kind and Cc when replying]
>
> Has someone been able to get es1371 to actually produce anything
> audible with latest kernels? The last version I could use was 2.4.0.
> Then I had some trouble but I attributed them to devfs. Now I've
> removed devfs and still I'm not able to play anything.
>
> .config is available at http://mirror.seabone.net/paperino.config
>
> pieffe@paperino:/proc $ cat devices
> Character devices:
>   1 mem
>   2 pty
>   3 ttyp
>   4 ttyS
>   5 cua
>   6 lp
>   7 vcs
>  10 misc
>  14 sound
>  29 fb
>  89 i2c
> 128 ptm
> 129 ptm
> 136 pts
> 137 pts
> 162 raw
>
> Block devices:
>   2 fd
>   3 ide0
>  22 ide1
>
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 vc/0
  5 ptmx
  7 vcs
 10 misc
 14 sound
 21 sg
 29 fb
 36 netlink
 81 video_capture
 90 mtd
128 ptm
136 pts
162 raw
180 usb
202 cpu/msr
203 cpu/cpuid

Block devices:
  3 ide0
 22 ide1
 31 mtdblock

> pieffe@paperino:/proc $ cat es1371
>                 Creative ES137x Debug Dump-o-matic
> AC97 CODEC state
> reg:0x00  val:0x1990
> reg:0x02  val:0x0303
> reg:0x04  val:0x1515
> reg:0x06  val:0x0017
> reg:0x08  val:0x0000
> reg:0x0a  val:0x000a
> reg:0x0c  val:0x0006
> reg:0x0e  val:0x0000
> reg:0x10  val:0x0b0b
> reg:0x12  val:0x0b0b
> reg:0x14  val:0x0b0b
> reg:0x16  val:0x0b0b
> reg:0x18  val:0x0b0b
> reg:0x1a  val:0x0404
> reg:0x1c  val:0x0a0a
> reg:0x1e  val:0x0000
> reg:0x20  val:0x0000
> reg:0x22  val:0x0000
> reg:0x24  val:0x0000
> reg:0x26  val:0x800f
> reg:0x28  val:0x0200
> reg:0x2a  val:0x0000
> reg:0x2c  val:0xbb80
> reg:0x2e  val:0x0000
> reg:0x30  val:0x0000
> reg:0x32  val:0xbb80
> reg:0x34  val:0x0000
> reg:0x36  val:0x0000
> reg:0x38  val:0x0000
> reg:0x3a  val:0x0000
> reg:0x3c  val:0x0000
> reg:0x3e  val:0x0000
> reg:0x40  val:0x0000
> reg:0x42  val:0x0000
> reg:0x44  val:0x0000
> reg:0x46  val:0x0000
> reg:0x48  val:0x0000
> reg:0x4a  val:0x0000
> reg:0x4c  val:0x0000
> reg:0x4e  val:0x0000
> reg:0x50  val:0x0000
> reg:0x52  val:0x0000
> reg:0x54  val:0x0000
> reg:0x56  val:0x0000
> reg:0x58  val:0x0000
> reg:0x5a  val:0x0302
> reg:0x5c  val:0x0000
> reg:0x5e  val:0x0080
> reg:0x60  val:0x0022
> reg:0x62  val:0x0000
> reg:0x64  val:0x0000
> reg:0x66  val:0x0000
> reg:0x68  val:0x0000
> reg:0x6a  val:0x0000
> reg:0x6c  val:0x0000
> reg:0x6e  val:0x0000
> reg:0x70  val:0x0000
> reg:0x72  val:0x0000
> reg:0x74  val:0x0000
> reg:0x76  val:0x0000
> reg:0x78  val:0x003f
> reg:0x7a  val:0x0000
> reg:0x7c  val:0x4352
> reg:0x7e  val:0x5913
>
                Creative ES137x Debug Dump-o-matic
AC97 CODEC state
reg:0x00  val:0x1990
reg:0x02  val:0x1717
reg:0x04  val:0x1515
reg:0x06  val:0x0017
reg:0x08  val:0x0000
reg:0x0a  val:0x000a
reg:0x0c  val:0x000b
reg:0x0e  val:0x000b
reg:0x10  val:0x0b0b
reg:0x12  val:0x0b0b
reg:0x14  val:0x0b0b
reg:0x16  val:0x0b0b
reg:0x18  val:0x0b0b
reg:0x1a  val:0x0404
reg:0x1c  val:0x0a0a
reg:0x1e  val:0x0000
reg:0x20  val:0x0000
reg:0x22  val:0x0000
reg:0x24  val:0x0000
reg:0x26  val:0x800f
reg:0x28  val:0x0200
reg:0x2a  val:0x0000
reg:0x2c  val:0xbb80
reg:0x2e  val:0x0000
reg:0x30  val:0x0000
reg:0x32  val:0xbb80
reg:0x34  val:0x0000
reg:0x36  val:0x0000
reg:0x38  val:0x0000
reg:0x3a  val:0x0000
reg:0x3c  val:0x0000
reg:0x3e  val:0x0000
reg:0x40  val:0x0000
reg:0x42  val:0x0000
reg:0x44  val:0x0000
reg:0x46  val:0x0000
reg:0x48  val:0x0000
reg:0x4a  val:0x0000
reg:0x4c  val:0x0000
reg:0x4e  val:0x0000
reg:0x50  val:0x0000
reg:0x52  val:0x0000
reg:0x54  val:0x0000
reg:0x56  val:0x0000
reg:0x58  val:0x0000
reg:0x5a  val:0x0302
reg:0x5c  val:0x0000
reg:0x5e  val:0x0080
reg:0x60  val:0x0022
reg:0x62  val:0x0000
reg:0x64  val:0x0000
reg:0x66  val:0x0000
reg:0x68  val:0x0000
reg:0x6a  val:0x0000
reg:0x6c  val:0x0000
reg:0x6e  val:0x0000
reg:0x70  val:0x0000
reg:0x72  val:0x0000
reg:0x74  val:0x0000
reg:0x76  val:0x0000
reg:0x78  val:0x0071
reg:0x7a  val:0x0000
reg:0x7c  val:0x4352
reg:0x7e  val:0x5913
> pieffe@paperino:/proc $ cat interrupts
>            CPU0
>   0:     122894          XT-PIC  timer
>   1:       5051          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:       3225          XT-PIC  eth0
>   8:          1          XT-PIC  rtc
>  10:      38969          XT-PIC  es1371
>  12:      28771          XT-PIC  PS/2 Mouse
>  14:       8790          XT-PIC  ide0
>  15:        112          XT-PIC  ide1
> NMI:          0
> ERR:          0
>
           CPU0
  0:   51784328          XT-PIC  timer
  1:     142458          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 11:   11021305          XT-PIC  es1371, usb-uhci, eth0
 12:    1374347          XT-PIC  PS/2 Mouse
 14:    1085963          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0
ERR:          0
> pieffe@paperino:/proc $ cat iomem
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-03feffff : System RAM
>   00100000-0021aee3 : Kernel code
>   0021aee4-0027df2b : Kernel data
> 03ff0000-03ff2fff : ACPI Non-volatile Storage
> 03ff3000-03ffffff : ACPI Tables
> e0000000-e3ffffff : PCI Bus #01
>   e0000000-e0ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
>   e2000000-e2000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
> e4000000-e5ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
> e7000000-e700007f : 3Com Corporation 3c905B-Combo [Deluxe Etherlink XL 10/100]
> ffff0000-ffffffff : reserved
>
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-0020638d : Kernel code
  0020638e-00265f7f : Kernel data
40000000-408fffff : PCI Bus #01
  40000000-407fffff : Matrox Graphics, Inc. MGA G200 AGP
  40800000-40803fff : Matrox Graphics, Inc. MGA G200 AGP
    40800000-40803fff : matroxfb MMIO
40900000-409fffff : Intel Corporation 82557 [Ethernet Pro 100]
40a00000-40a00fff : Intel Corporation 82557 [Ethernet Pro 100]
  40a00000-40a00fff : eepro100
41000000-41ffffff : PCI Bus #01
  41000000-41ffffff : Matrox Graphics, Inc. MGA G200 AGP
    41000000-41ffffff : matroxfb FB
44000000-47ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
fffc0000-ffffffff : reserved
> pieffe@paperino:/proc $ cat ioports
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
> 02f8-02ff : serial(auto)
> 0376-0376 : ide1
> 0378-037a : parport0
> 037b-037f : parport0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial(auto)
> 0778-077a : parport0
> 0cf8-0cff : PCI conf1
> 4000-403f : Intel Corporation 82371AB PIIX4 ACPI
> 5000-501f : Intel Corporation 82371AB PIIX4 ACPI
> d000-dfff : PCI Bus #01
>   d000-d0ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
> e000-e01f : Intel Corporation 82371AB PIIX4 USB
> e400-e47f : 3Com Corporation 3c905B-Combo [Deluxe Etherlink XL 10/100]
>   e400-e47f : eth0
> e800-e83f : Ensoniq ES1371 [AudioPCI-97]
>   e800-e83f : es1371
> f000-f00f : Intel Corporation 82371AB PIIX4 IDE
>   f000-f007 : ide0
>   f008-f00f : ide1
0cf8-0cff : PCI conf1
1000-103f : Intel Corporation 82557 [Ethernet Pro 100]
  1000-103f : eepro100
1040-107f : Ensoniq ES1371 [AudioPCI-97]
  1040-107f : es1371
1080-109f : Intel Corporation 82371AB PIIX4 USB
  1080-109f : usb-uhci
10a0-10af : Intel Corporation 82371AB PIIX4 IDE
  10a0-10a7 : ide0
  10a8-10af : ide1
f800-f83f : Intel Corporation 82371AB PIIX4 ACPI
fc00-fc1f : Intel Corporation 82371AB PIIX4 ACPI
>
> pieffe@paperino:/proc $ cat modules
> es1371                 25680   0 (autoclean)
> ac97_codec              8576   0 (autoclean) [es1371]
> parport_pc             23248   1 (autoclean)
> lp                      5552   1 (autoclean)
> parport                25664   1 (autoclean) [parport_pc lp]
> binfmt_misc             3264   0
> soundcore               3792   4 (autoclean) [es1371]
>
> #lspci -vv
> 00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
>         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
>         Latency: 32 (3000ns min, 32000ns max)
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at e800 [size=64]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
00:0f.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Compaq Computer Corporation ES1371, ES1373 AudioPCI
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1040 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Luigi Genoni
Unix System Manager Scuola Normale Superiore di Pisa

