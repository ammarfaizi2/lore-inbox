Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276384AbRJCPbT>; Wed, 3 Oct 2001 11:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276379AbRJCPa5>; Wed, 3 Oct 2001 11:30:57 -0400
Received: from mail.cdlsystems.com ([207.228.116.20]:16903 "EHLO
	cdlsystems.com") by vger.kernel.org with ESMTP id <S276381AbRJCPal>;
	Wed, 3 Oct 2001 11:30:41 -0400
Message-ID: <011d01c14c20$8e79b590$160e10ac@hades>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: Problems with Kernel 2.4.10 on SMP
Date: Wed, 3 Oct 2001 09:32:05 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
>
> I have witnessed the same problems on a Dual Processor Box running Kernel
> 2.4.9 (a Dell Poweredge 1400).  I too couldn't find anything suspicous in
> the log file, but did see the "Locking Max Tag Count" message in the log
> that was mentioned below.  I was forced to do a hard reset on the machine.
> Since the machine is our development server, having the machine running
well
> is obviously desirable (I'm sure everyone feels this way :)  I was
planning
> on trying 2.4.10 to see if it was any different, but it looks like the
same
> problems exists.  If anyone has any hints, please let me know.
>
> Configuration:
> Dell Poweredge 1400 Server
> Dual PIII Coppermine's at 1 GHz
> 768 Megs RAM
> Adaptec 29160 SCSI Controller Card (onboard controller disabled)
>
> If anyone wants more info from the logs or /proc, pls let me know
>
> Mark
>
> ----- Original Message -----
> From: "Christian Schroeder" <c-h.schroeder@gmx.net>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, October 03, 2001 8:56 AM
> Subject: Problems with Kernel 2.4.10 on SMP
>
>
> > Hi,
> >
> > since I've been experisnsing large problems with my linux box crashing
and
> > crashing again, I want to give you this bug report, maybe someone else
has
> > the same problem. I used the bug report format in explained in the
kernel
> > sources.
> >
> > Best Regards,
> > Christian Schroeder
> >
> > [1.]
> > The system seams to hang for a while, sometimes recovers and sometimes
not
> >
> > [2.]
> > I've been using version 2.4.4 from SuSE and 2.4.9/2.4.10 from
kernel.org.
> > 2.4.4 runs with no problems on my 2-way machine.
> > 2.4.9 had some hangs which normally recovered after about 15 seconds.
> > 2.4.10 crashed the machine completely. I had to a reset.
> >
> > Regarding 2.4.9 I allways had the impression that the problem came up
when
> > using very large applications like StarOffice. After using the software
> for a
> > moment, it hang and I could see the following line in the syslog
> afterwards:
> >
> > "Sep 25 21:33:50 tepui kernel: __alloc_pages: 0-order allocation
failed."
> >
> > This problem disappeard after I switch to 2.4.10.
> >
> > Regarding 2.4.10 I haven't had the chance to get an output, since as I
> said,
> > the machine hangs completely. What I can say is, that normaly just
before
> the
> > crash, right after e.g. the desktop manager didn't react anymore, the
LED
> of
> > my SCSI controller was signaling great activity on the drives. Then the
> LED
> > turn off and the system didn't move a bit.
> >
> > I checked by SCSI hardware setup, but nothing that made my nervous.
> > Especially I now using 2.4.4 and it works without any problem. No crash,
> no
> > halting.
> >
> > What I also had the impression was, that always near to the last crash,
> the
> > logfiles contained the sequence:
> >
> > "Oct  2 18:16:22 tepui kernel: (scsi0:A:0:0): Locking max tag count at
64"
> >
> > This was not always the case, but I browsed my logfile and found at
least
> 4
> > insidents at which this message showed up close to the next syslog
restart
> > message.
> >
> > [3.]
> > Hmpf... SCSI?
> >
> > [4.]
> > Linux version 2.4.10 (root@tepui) (gcc version 2.95.3 20010315 (SuSE))
#1
> SMP
> > Tue Oct 2 19:14:23 CEST 2001
> >
> > [5.]
> > No Ooops in the syslog.
> >
> > [6.]
> > Sorry, no script.
> >
> > [7.1]
> > Linux tepui 2.4.10 #1 SMP Tue Oct 2 19:14:23 CEST 2001 i686 unknown
> >
> > Gnu C 2.95.3
> > Gnu make 3.79.1
> > binutils 2.10.91.0.4
> > util-linux 2.11b
> > mount 2.11b
> > modutils 2.4.5
> > e2fsprogs 1.19
> > reiserfsprogs 3.x.0j
> > pcmcia-cs 3.1.25
> > isdn4k-utils 3.1pre1a
> > Linux C Library        x    1 root     root      1343073 May 11 16:50c
> > /lib/libc.so.6
> > Dynamic linker (ldd) 2.2.2
> > Procps 2.0.7
> > Net-tools 1.60
> > Kbd 1.04
> > Sh-utils 2.0
> > Modules Loaded         snd-pcm-oss snd-pcm-plugin snd-mixer-oss NVdriver
> > parport_pc lp parport wacom evdev snd-seq-midi snd-seq-midi-event
snd-seq
> > snd-card-ens1370 snd-ens1370 snd-pcm snd-timer snd-rawmidi
snd-seq-device
> > snd-ak4531-codec snd-mixer snd soundcore mousedev hid input uhci usbcore
> > 8139too ipchains
> >
> > [7.2]
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 7
> > model name      : Pentium III (Katmai)
> > stepping        : 3
> > cpu MHz         : 501.148
> > cache size      : 512 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca
> > cmov
> > pat pse36 mmx fxsr sse
> > bogomips        : 999.42
> >
> > processor       : 1
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 7
> > model name      : Pentium III (Katmai)
> > stepping        : 3
> > cpu MHz         : 501.148
> > cache size      : 512 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca
> > cmov
> > pat pse36 mmx fxsr sse
> > bogomips        : 999.42
> >
> > [7.3]
> > snd-pcm-oss            18816   1 (autoclean)
> > snd-pcm-plugin         14256   0 (autoclean) [snd-pcm-oss]
> > snd-mixer-oss           5280   0 (autoclean) [snd-pcm-oss]
> > NVdriver              723872  14 (autoclean)
> > parport_pc             19600   1 (autoclean)
> > lp                      5440   0 (autoclean)
> > parport                26240   1 (autoclean) [parport_pc lp]
> > wacom                   4016   0 (unused)
> > evdev                   4192   1
> > snd-seq-midi            3376   0 (unused)
> > snd-seq-midi-event      3296   0 [snd-seq-midi]
> > snd-seq                44800   0 [snd-seq-midi snd-seq-midi-event]
> > snd-card-ens1370        1952   1
> > snd-ens1370             8464   0 [snd-card-ens1370]
> > snd-pcm                33152   0 [snd-pcm-oss snd-pcm-plugin
snd-ens1370]
> > snd-timer               9968   0 [snd-seq snd-pcm]
> > snd-rawmidi            11040   0 [snd-seq-midi snd-ens1370]
> > snd-seq-device          4032   0 [snd-seq-midi snd-seq snd-rawmidi]
> > snd-ak4531-codec       15552   0 [snd-ens1370]
> > snd-mixer              28768   0 [snd-mixer-oss snd-ens1370
> snd-ak4531-codec]
> > snd                    35184   1 [snd-pcm-oss snd-pcm-plugin
snd-mixer-oss
> > snd-seq-midi snd-seq-midi-event snd-seq snd-card-ens1370 snd-ens1370
> snd-pcm
> > snd-timer snd-rawmidi snd-seq-device snd-ak4531-codec snd-mixer]
> > soundcore               3856   5 [snd]
> > mousedev                3904   0 (unused)
> > hid                    12576   0 (unused)
> > input                   3456   0 [wacom evdev mousedev hid]
> > uhci                   23808   0 (unused)
> > usbcore                49152   1 [wacom hid uhci]
> > 8139too                12608   1 (autoclean)
> > ipchains               32080   0
> >
> > [7.4.1]
> > 0000-001f : dma1
> > 0020-003f : pic1
> > 0040-005f : timer
> > 0060-006f : keyboard
> > 0070-007f : rtc
> > 0080-008f : dma page reg
> > 00a0-00bf : pic2
> > 00c0-00df : dma2
> > 00f0-00ff : fpu
> > 02f8-02ff : serial(auto)
> > 0378-037a : parport0
> > 037b-037f : parport0
> > 03c0-03df : vga+
> > 03f8-03ff : serial(auto)
> > 0778-077a : parport0
> > 0cf8-0cff : PCI conf1
> > b400-b43f : Ensoniq ES1370 [AudioPCI]
> >   b400-b43f : Ensoniq AudioPCI
> > b800-b8ff : Realtek Semiconductor Co., Ltd. RTL-8139
> >   b800-b8ff : 8139too
> > d000-d0ff : Adaptec AHA-2940U2/W / 7890
> > d400-d41f : Intel Corporation 82371AB PIIX4 USB
> >   d400-d41f : usb-uhci
> > d800-d80f : Intel Corporation 82371AB PIIX4 IDE
> > e400-e43f : Intel Corporation 82371AB PIIX4 ACPI
> > e800-e81f : Intel Corporation 82371AB PIIX4 ACPI
> >
> > [7.4.2]
> > 0000-001f : dma1
> > 0020-003f : pic1
> > 0040-005f : timer
> > 0060-006f : keyboard
> > 0070-007f : rtc
> > 0080-008f : dma page reg
> > 00a0-00bf : pic2
> > 00c0-00df : dma2
> > 00f0-00ff : fpu
> > 02f8-02ff : serial(auto)
> > 0378-037a : parport0
> > 037b-037f : parport0
> > 03c0-03df : vga+
> > 03f8-03ff : serial(auto)
> > 0778-077a : parport0
> > 0cf8-0cff : PCI conf1
> > b400-b43f : Ensoniq ES1370 [AudioPCI]
> >   b400-b43f : Ensoniq AudioPCI
> > b800-b8ff : Realtek Semiconductor Co., Ltd. RTL-8139
> >   b800-b8ff : 8139too
> > d000-d0ff : Adaptec AHA-2940U2/W / 7890
> > d400-d41f : Intel Corporation 82371AB PIIX4 USB
> >   d400-d41f : usb-uhci
> > d800-d80f : Intel Corporation 82371AB PIIX4 IDE
> > e400-e43f : Intel Corporation 82371AB PIIX4 ACPI
> > e800-e81f : Intel Corporation 82371AB PIIX4 ACPI
> > tepui:/usr/src/linux-2.4.10/scripts # cat /proc/iomem
> > 00000000-0009f7ff : System RAM
> > 0009f800-0009ffff : reserved
> > 000a0000-000bffff : Video RAM area
> > 000c0000-000c7fff : Video ROM
> > 000c8000-000cd3ff : Extension ROM
> > 000f0000-000fffff : System ROM
> > 00100000-23ffcfff : System RAM
> >   00100000-00219cfd : Kernel code
> >   00219cfe-0026feff : Kernel data
> > 23ffd000-23ffefff : ACPI Tables
> > 23fff000-23ffffff : ACPI Non-volatile Storage
> > e0000000-e00000ff : Realtek Semiconductor Co., Ltd. RTL-8139
> >   e0000000-e00000ff : 8139too
> > e0800000-e0800fff : Adaptec AHA-2940U2/W / 7890
> >   e0800000-e0800fff : aic7xxx
> > e1000000-e2dfffff : PCI Bus #01
> >   e1000000-e1ffffff : nVidia Corporation Riva TnT 128 [NV04]
> > e2f00000-e3ffffff : PCI Bus #01
> >   e3000000-e3ffffff : nVidia Corporation Riva TnT 128 [NV04]
> > e4000000-e7ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
> > fec00000-fec00fff : reserved
> > fee00000-fee00fff : reserved
> > ffff0000-ffffffff : reserved
> >
> > [7.5]
> > 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
> (rev
> > 02)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr-
> > Stepping- SERR+ FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort+ >SERR- <PERR-
> >         Latency: 64
> >         Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
> >         Capabilities: [a0] AGP version 1.0
> >                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
> >                 Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2
> >
> > 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
> (rev
> > 02) (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr-
> > Stepping- SERR+ FastB2B-
> >         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> >         I/O behind bridge: 0000e000-0000dfff
> >         Memory behind bridge: e1000000-e2dfffff
> >         Prefetchable memory behind bridge: e2f00000-e3ffffff
> >         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
> >
> > 00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 0
> >
> > 00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> (prog-if
> > 80 [Master])
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Region 4: I/O ports at d800 [disabled] [size=16]
> >
> > 00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> (prog-if
> > 00 [UHCI])
> >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64
> >         Interrupt: pin D routed to IRQ 15
> >         Region 4: I/O ports at d400 [size=32]
> >
> > 00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> >         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Interrupt: pin ? routed to IRQ 9
> >
> > 00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
> >         Subsystem: Adaptec 2940U2W SCSI Controller
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 (9750ns min, 6250ns max)
> >         Interrupt: pin A routed to IRQ 15
> >         BIST result: 00
> >         Region 0: I/O ports at d000 [disabled] [size=256]
> >         Region 1: Memory at e0800000 (64-bit, non-prefetchable)
[size=4K]
> >         Expansion ROM at <unassigned> [disabled] [size=128K]
> >         Capabilities: [dc] Power Management version 1
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev
> 10)
> >         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 (8000ns min, 16000ns max)
> >         Interrupt: pin A routed to IRQ 10
> >         Region 0: I/O ports at b800 [size=256]
> >         Region 1: Memory at e0000000 (32-bit, non-prefetchable)
[size=256]
> >         Capabilities: [50] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0-,D1+,D2+,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:0c.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
> >         Subsystem: Unknown device 4942:4c4c
> >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
> > <TAbort+
> > <MAbort+ >SERR- <PERR-
> >         Latency: 64 (3000ns min, 32000ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: I/O ports at b400 [size=64]
> >
> > 01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128
[NV04]
> > (rev 04) (prog-if 00 [VGA])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
> ParErr-
> > Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 248 (1250ns min, 250ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e1000000 (32-bit, non-prefetchable)
[size=16M]
> >         Region 1: Memory at e3000000 (32-bit, prefetchable) [size=16M]
> >         Expansion ROM at e2ff0000 [disabled] [size=64K]
> >         Capabilities: [60] Power Management version 1
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [44] AGP version 1.0
> >                 Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
> >                 Command: RQ=15 SBA- AGP+ 64bit- FW- Rate=x2
> >
> > [7.6]
> > Attached devices:
> > Host: scsi0 Channel: 00 Id: 00 Lun: 00
> >   Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
> >   Type:   Direct-Access                    ANSI SCSI revision: 02
> > Host: scsi0 Channel: 00 Id: 01 Lun: 00
> >   Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
> >   Type:   Direct-Access                    ANSI SCSI revision: 03
> > Host: scsi0 Channel: 00 Id: 03 Lun: 00
> >   Vendor: IBM      Model: DNES-309170W     Rev: SA30
> >   Type:   Direct-Access                    ANSI SCSI revision: 03
> > Host: scsi0 Channel: 00 Id: 04 Lun: 00
> >   Vendor: PIONEER  Model: DVD-ROM DVD-303  Rev: 1.09
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi0 Channel: 00 Id: 06 Lun: 00
> >   Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.01
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>


