Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUGVJB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUGVJB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUGVJBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:01:41 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20123 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S266836AbUGVJBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:01:01 -0400
Date: Thu, 22 Jul 2004 11:00:55 +0200
From: Alexander Wagner <a.wagner@physik.uni-wuerzburg.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.7 USB-Storage Sony Clie
Message-ID: <20040722090055.GA4365@wptx44.physik.uni-wuerzburg.de>
Mime-Version: 1.0
User-Agent: Mutt/1.4.1i
X-MIMETrack: Itemize by SMTP Server on domino1/uni-wuerzburg(Release 6.51HF254 | May 17, 2004) at
 07/22/2004 11:00:55,
	Serialize by Router on domino1/uni-wuerzburg(Release 6.51HF254 | May 17, 2004) at
 07/22/2004 11:00:58,
	Serialize complete at 07/22/2004 11:00:58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The Sony Clie NR70V is recognized as a mass storage
correctly since 2.6.7, though I'm still unable to mount the
Memory Stick, as it is not assigned a valid scsi-device. It
may be noted that this works like a charm in 2.4 series.
(Tested 2.4.20-31.9 RedHat, unfortunatly I've no vanilla
available.)

Mounting other USB-Storage Devices works perfectly.

Keywords: 
   usb-storage, clie, scsi

Kernel version: 
   Linux version 2.6.7.080704 (root@ingata) (gcc version 3.3.4 (Debian 1:3.3.4-2)) #1 Thu Jul 8 11:14:55 CEST 2004)

   (This is a vanilla 2.6.7 kernel with user supplied DSDT.)

Log:
   Jul 22 10:35:25 ingata kernel: usb 2-1: new full speed USB device using address 2
   Jul 22 10:35:26 ingata kernel: SCSI subsystem initialized
   Jul 22 10:35:26 ingata kernel: Initializing USB Mass Storage driver...
   Jul 22 10:35:26 ingata kernel: scsi0 : SCSI emulation for USB Mass Storage devices
   Jul 22 10:35:26 ingata usb.agent[6801]:      usb-storage: loaded successfully
   Jul 22 10:35:26 ingata kernel: usbcore: registered new driver usb-storage
   Jul 22 10:35:26 ingata kernel: USB Mass Storage support registered.
   Jul 22 10:35:26 ingata kernel: SCSI subsystem initialized
   Jul 22 10:35:26 ingata kernel: Initializing USB Mass Storage driver...
   Jul 22 10:35:26 ingata kernel: usb-storage: USB Mass Storage device detected
   Jul 22 10:35:26 ingata kernel: usb-storage: altsetting is 0, id_index is 113
   Jul 22 10:35:26 ingata kernel: usb-storage: -- associate_dev
   Jul 22 10:35:26 ingata kernel: usb-storage: Transport: Control/Bulk/Interrupt
   Jul 22 10:35:26 ingata kernel: usb-storage: Protocol: 8070i
   Jul 22 10:35:26 ingata kernel: usb-storage: Endpoints: In: 0xdfda6cbc Out: 0xdfda6ca8 Int: 0xdfda6c94 (Period 1)
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: scsi0 : SCSI emulation for USB Mass Storage devices
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Command INQUIRY (6 bytes)
   Jul 22 10:35:26 ingata kernel: usb-storage:  12 00 00 00 24 00
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 12/12
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Call to usb_stor_ctrl_transfer() returned 0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 36/36
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: CBI data stage result is 0x0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_intr_transfer: xfer 2 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 2/2
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Got interrupt data (0x28, 0x0)
   Jul 22 10:35:26 ingata kernel: usb-storage: CBI IRQ data showed reserved bType 0x28
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82 len=0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_clear_halt: result = 0
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transport indicates command failure
   Jul 22 10:35:26 ingata kernel: usb-storage: Issuing auto-REQUEST_SENSE
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 12/12
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Call to usb_stor_ctrl_transfer() returned 0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 18/18
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: CBI data stage result is 0x0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_intr_transfer: xfer 2 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 2/2
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Got interrupt data (0x0, 0x0)
   Jul 22 10:35:26 ingata kernel: usb-storage: -- Result from auto-sense is 0
   Jul 22 10:35:26 ingata kernel: usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
   Jul 22 10:35:26 ingata kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x2
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Command INQUIRY (6 bytes)
   Jul 22 10:35:26 ingata kernel: usb-storage:  12 00 00 00 24 00
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 12/12
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Call to usb_stor_ctrl_transfer() returned 0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 36/36
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: CBI data stage result is 0x0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_intr_transfer: xfer 2 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 2/2
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Got interrupt data (0x3a, 0x0)
   Jul 22 10:35:26 ingata kernel: usb-storage: CBI IRQ data showed reserved bType 0x3a
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82 len=0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_clear_halt: result = 0
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transport indicates command failure
   Jul 22 10:35:26 ingata kernel: usb-storage: Issuing auto-REQUEST_SENSE
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 12/12
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Call to usb_stor_ctrl_transfer() returned 0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 18/18
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: CBI data stage result is 0x0
   Jul 22 10:35:26 ingata kernel: usb-storage: usb_stor_intr_transfer: xfer 2 bytes
   Jul 22 10:35:26 ingata kernel: usb-storage: Status code 0; transferred 2/2
   Jul 22 10:35:26 ingata kernel: usb-storage: -- transfer complete
   Jul 22 10:35:26 ingata kernel: usb-storage: Got interrupt data (0x0, 0x0)
   Jul 22 10:35:26 ingata kernel: usb-storage: -- Result from auto-sense is 0
   Jul 22 10:35:26 ingata kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
   Jul 22 10:35:26 ingata kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x2
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Bad target number (1:0)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x40000
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Bad target number (2:0)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x40000
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Bad target number (3:0)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x40000
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Bad target number (4:0)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x40000
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Bad target number (5:0)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x40000
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Bad target number (6:0)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x40000
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.
   Jul 22 10:35:26 ingata kernel: usb-storage: queuecommand called
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread awakened.
   Jul 22 10:35:26 ingata kernel: usb-storage: Bad target number (7:0)
   Jul 22 10:35:26 ingata kernel: usb-storage: scsi cmd done, result=0x40000
   Jul 22 10:35:26 ingata usb.agent[6801]:      usb-storage: loaded successfully
   Jul 22 10:35:26 ingata kernel: USB Mass Storage device found at 2
   Jul 22 10:35:26 ingata kernel: usbcore: registered new driver usb-storage
   Jul 22 10:35:26 ingata kernel: USB Mass Storage support registered.
   Jul 22 10:35:26 ingata kernel: usb-storage: *** thread sleeping.

Software:
   If some fields are empty or look unusual you may have an old version.
   Compare to the current minimal requirements in Documentation/Changes.
    
   Linux ingata 2.6.7.080704 #1 Thu Jul 8 11:14:55 CEST 2004
   i686 GNU/Linux
    
   Gnu C                  3.3.4
   Gnu make               3.80
   binutils               2.14.90.0.7
   util-linux             2.12
   mount                  2.12
   module-init-tools      3.1-pre5
   e2fsprogs              1.35
   xfsprogs               2.6.18
   pcmcia-cs              3.2.5
   quota-tools            3.12.
   nfs-utils              1.0.6
   Linux C Library        2.3.2
   Dynamic linker (ldd)   2.3.2
   Procps                 3.2.1
   Net-tools              1.60
   Console-tools          0.2.3
   Sh-utils               5.0.91
   Modules Loaded         sd_mod usb_storage scsi_mod nvram ds
   nfsd exportfs nsc_ircc irda parport_pc lp parport thermal
   fan button processor ac battery yenta_socket pcmcia_core
   snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm_oss
   snd_mixer_oss snd_pcm snd_timer snd_page_alloc
   snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
   ehci_hcd uhci_hcd usbcore evdev e1000

Processor:
   processor       : 0
   vendor_id       : GenuineIntel
   cpu family      : 6
   model           : 9
   model name      : Intel(R) Pentium(R) M processor 1700MHz
   stepping        : 5
   cpu MHz         : 598.193
   cache size      : 1024 KB
   fdiv_bug        : no
   hlt_bug         : no
   f00f_bug        : no
   coma_bug        : no
   fpu             : yes
   fpu_exception   : yes
   cpuid level     : 2
   wp              : yes
   flags           : fpu vme de pse tsc msr mce cx8 sep mtrr
   pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe
   tm2 est
   bogomips        : 1179.64

Modules:
   sd_mod 16320 0 - Live 0xe0da8000
   usb_storage 101072 0 - Live 0xe0dc4000
   scsi_mod 70272 2 sd_mod,usb_storage, Live 0xe0d41000
   nvram 7624 0 - Live 0xe0d22000
   ds 14084 4 - Live 0xe0d3c000
   nfsd 91336 8 - Live 0xe0d57000
   exportfs 5056 1 nfsd, Live 0xe0d1f000
   nsc_ircc 18684 0 - Live 0xe0d36000
   irda 190208 1 nsc_ircc, Live 0xe0d73000
   parport_pc 35776 1 - Live 0xe0d2c000
   lp 8772 0 - Live 0xe0d1b000
   parport 35528 2 parport_pc,lp, Live 0xe0cfd000
   thermal 10256 1 - Live 0xe0c6a000
   fan 2892 0 - Live 0xe0cbc000
   button 4696 0 - Live 0xe0ce9000
   processor 14000 1 thermal, Live 0xe0c98000
   ac 3340 0 - Live 0xe0c00000
   battery 7756 0 - Live 0xe0c95000
   yenta_socket 18496 0 - Live 0xe0cf7000
   pcmcia_core 55300 2 ds,yenta_socket, Live 0xe0d08000
   snd_intel8x0m 16904 0 - Live 0xe0ce3000
   snd_intel8x0 30920 0 - Live 0xe0cee000
   snd_ac97_codec 67268 2 snd_intel8x0m,snd_intel8x0, Live
   0xe0caa000
   snd_pcm_oss 50088 0 - Live 0xe0cd5000
   snd_mixer_oss 17792 1 snd_pcm_oss, Live 0xe0ca4000
   snd_pcm 86308 3 snd_intel8x0m,snd_intel8x0,snd_pcm_oss, Live
   0xe0cbe000
   snd_timer 21444 1 snd_pcm, Live 0xe0c9d000
   snd_page_alloc 9096 3 snd_intel8x0m,snd_intel8x0,snd_pcm,
   Live 0xe0c07000
   snd_mpu401_uart 6336 1 snd_intel8x0, Live 0xe0c5c000
   snd_rawmidi 20352 1 snd_mpu401_uart, Live 0xe0c64000
   snd_seq_device 6664 1 snd_rawmidi, Live 0xe0c59000
   snd 48612 10
   snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
   Live 0xe0c88000
   soundcore 7392 1 snd, Live 0xe0c0b000
   ehci_hcd 26628 0 - Live 0xe0c10000
   uhci_hcd 29776 0 - Live 0xe0c50000
   usbcore 100384 5 usb_storage,ehci_hcd,uhci_hcd, Live
   0xe0c6e000
   evdev 7360 0 - Live 0xe0c04000
   e1000 80964 0 - Live 0xe0c18000

PCI:
   0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
           Subsystem: IBM: Unknown device 0529
           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
           Latency: 0
           Region 0: Memory at d0000000 (32-bit, prefetchable)
           Capabilities: <available only to root>

   0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
           Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 96
           Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
           I/O behind bridge: 00003000-00003fff
           Memory behind bridge: c0100000-c01fffff
           Prefetchable memory behind bridge: e0000000-e7ffffff
           Expansion ROM at 00003000 [disabled] [size=4K]
           BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

   0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
           Subsystem: IBM: Unknown device 052d
           Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0
           Interrupt: pin A routed to IRQ 11
           Region 4: I/O ports at 1800 [size=32]

   0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
           Subsystem: IBM: Unknown device 052d
           Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0
           Interrupt: pin B routed to IRQ 11
           Region 4: I/O ports at 1820 [size=32]

   0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
           Subsystem: IBM: Unknown device 052d
           Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0
           Interrupt: pin C routed to IRQ 11
           Region 4: I/O ports at 1840 [size=32]

   0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
           Subsystem: IBM: Unknown device 052e
           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0
           Interrupt: pin D routed to IRQ 11
           Region 0: Memory at c0000000 (32-bit, non-prefetchable)
           Capabilities: <available only to root>

   0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
           Latency: 0
           Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
           I/O behind bridge: 00004000-00008fff
           Memory behind bridge: c0200000-cfffffff
           Prefetchable memory behind bridge: e8000000-efffffff
           BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

   0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
           Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0

   0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
           Subsystem: IBM: Unknown device 052d
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0
           Interrupt: pin A routed to IRQ 11
           Region 0: I/O ports at <unassigned>
           Region 1: I/O ports at <unassigned>
           Region 2: I/O ports at <unassigned>
           Region 3: I/O ports at <unassigned>
           Region 4: I/O ports at 1860 [size=16]
           Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

   0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
           Subsystem: IBM: Unknown device 052d
           Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Interrupt: pin B routed to IRQ 11
           Region 4: I/O ports at 1880 [size=32]

   0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)
           Subsystem: IBM: Unknown device 0537
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0
           Interrupt: pin B routed to IRQ 11
           Region 0: I/O ports at 1c00
           Region 1: I/O ports at 18c0 [size=64]
           Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
           Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
           Capabilities: <available only to root>

   0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
           Subsystem: IBM: Unknown device 0525
           Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 0
           Interrupt: pin B routed to IRQ 11
           Region 0: I/O ports at 2400
           Region 1: I/O ports at 2000 [size=128]
           Capabilities: <available only to root>

   0000:01:00.0 VGA compatible controller: ATI Technologies Inc M10 NT [FireGL Mobility T2] (rev 80) (prog-if 00 [VGA])
           Subsystem: IBM: Unknown device 054f
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
           Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
           Interrupt: pin A routed to IRQ 11
           Region 0: Memory at e0000000 (32-bit, prefetchable)
           Region 1: I/O ports at 3000 [size=256]
           Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
           Capabilities: <available only to root>

   0000:02:00.0 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
           Subsystem: IBM: Unknown device 0552
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 168, Cache Line Size: 0x10 (64 bytes)
           Interrupt: pin A routed to IRQ 11
           Region 0: Memory at b0000000 (32-bit, non-prefetchable)
           Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
           Memory window 0: 20400000-207ff000 (prefetchable)
           Memory window 1: 20800000-20bff000
           I/O window 0: 00004000-000040ff
           I/O window 1: 00004400-000044ff
           BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
           16-bit legacy interface ports at 0001

   0000:02:00.1 CardBus bridge: Texas Instruments PCI4520 PC card Cardbus Controller (rev 01)
           Subsystem: IBM: Unknown device 0552
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 168, Cache Line Size: 0x10 (64 bytes)
           Interrupt: pin B routed to IRQ 11
           Region 0: Memory at b1000000 (32-bit, non-prefetchable)
           Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
           Memory window 0: 20c00000-20fff000 (prefetchable)
           Memory window 1: 21000000-213ff000
           I/O window 0: 00004800-000048ff
           I/O window 1: 00004c00-00004cff
           BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
           16-bit legacy interface ports at 0001

   0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet Controller (Mobile) (rev 03)
           Subsystem: IBM PRO/1000 MT Mobile Connection
           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
           Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 64 (63750ns min), Cache Line Size: 0x08 (32 bytes)
           Interrupt: pin A routed to IRQ 11
           Region 0: Memory at c0240000 (32-bit, non-prefetchable)
           Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
           Region 2: I/O ports at 8000 [size=64]
           Capabilities: <available only to root>

   0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
           Subsystem: Unknown device 17ab:8331
           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
           Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Latency: 80 (2500ns min, 7000ns max), Cache Line Size: 0x08 (32 bytes)
           Interrupt: pin A routed to IRQ 11
           Region 0: Memory at c0210000 (32-bit, non-prefetchable)
           Capabilities: <available only to root>

SCSI:
   Attached devices:

   (This is the main problem ;)

Other:
   The system uses a user supplied DSDT, which is the only patch applied.
   Removing it doesn't cure the problem though.

-- 

Kind regards,                /                 War is Peace.
                            |            Freedom is Slavery.
Alexander Wagner            |         Ignorance is Strength.
----------------------------|
Theoretische Physik II      | Theory     : G. Orwell, "1984"
Universitaet Wuerzburg     /  In practice:   USA, since 2001
