Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVHHRy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVHHRy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVHHRy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:54:56 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:13225 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932139AbVHHRyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:54:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SkSbaWChH7Bk4hNU7RHHBAnJ/tJhlS7wMPiNxQmAVAR8E02andJSj07DLG1quKt3jzoiRME7PLKjZZjoybjixVGVDA8VN6883TcCtWW2sstuSB7MMGxqG0+ZOutgUp+UEIe3BgC9KWgbjJTSWy4L8oAUsolpqmetdQsmr8Q8fcw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
Date: Mon, 8 Aug 2005 19:54:52 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081954.52638.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 August 2005 20:47, Linus Torvalds wrote:
> 
> James and gang found the aic7xxx slowdown that happened after 2.6.12, and 
> we'd like to get particular testing that it's fixed, so if you have a 
> relevant machine, please do test this.
> 

I'm using the aic7xxx driver, and although I haven't had any trouble with
previous kernels and this driver I thought I'd report anyway that everything
seems to be working ok with -rc6. At least this means you haven't broken a
previously working setup :-)

Details about my hardware below :

$ uname -a
Linux dragon 2.6.13-rc6 #1 Mon Aug 8 18:07:08 CEST 2005 i686 unknown unknown GNU/Linux

$ /sbin/lspci -vvv
<...>
00:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160N Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	BIST result: 00
	Region 0: I/O ports at 9800 [disabled] [size=256]
	Region 1: Memory at e3000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at 20000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

<...>

$ dmesg
<...>
[   27.874038] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
[   27.874041]         <Adaptec 29160N Ultra160 SCSI adapter>
[   27.874043]         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   27.874046] 
[   27.884187] kobject host0: registering. parent: 0000:00:0b.0, set: devices
[   27.884206] kobject host0: registering. parent: scsi_host, set: class_obj
[   27.884226] kobject host0: registering. parent: spi_host, set: class_obj
[   27.884240] kobject target0:0:0: registering. parent: host0, set: devices
[   27.884248] kobject target0:0:0: registering. parent: spi_transport, set: class_obj
[   43.122408] kobject <NULL>: cleaning up
[   43.122436] kobject target0:0:0: cleaning up
[   43.122439] kobject target0:0:0: cleaning up
[   43.122445] kobject target0:0:1: registering. parent: host0, set: devices
[   43.122455] kobject target0:0:1: registering. parent: spi_transport, set: class_obj
[   43.378585] kobject <NULL>: cleaning up
[   43.378600] kobject target0:0:1: cleaning up
[   43.378603] kobject target0:0:1: cleaning up
[   43.378609] kobject target0:0:2: registering. parent: host0, set: devices
[   43.378617] kobject target0:0:2: registering. parent: spi_transport, set: class_obj
[   43.634760] kobject <NULL>: cleaning up
[   43.634773] kobject target0:0:2: cleaning up
[   43.634777] kobject target0:0:2: cleaning up
[   43.634782] kobject target0:0:3: registering. parent: host0, set: devices
[   43.634791] kobject target0:0:3: registering. parent: spi_transport, set: class_obj
[   43.890919] kobject <NULL>: cleaning up
[   43.890932] kobject target0:0:3: cleaning up
[   43.890936] kobject target0:0:3: cleaning up
[   43.890941] kobject target0:0:4: registering. parent: host0, set: devices
[   43.890949] kobject target0:0:4: registering. parent: spi_transport, set: class_obj
[   43.896324]   Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
[   43.899023]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   43.901656]  target0:0:4: asynchronous.
[   43.904268]  target0:0:4: Beginning Domain Validation
[   43.909476]  target0:0:4: Domain Validation skipping write tests
[   43.912470]  target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
[   43.917610]  target0:0:4: Ending Domain Validation
[   43.920192] kobject 0:0:4:0: registering. parent: target0:0:4, set: devices
[   43.920207] kobject 0:0:4:0: registering. parent: scsi_device, set: class_obj
[   43.920231] kobject target0:0:5: registering. parent: host0, set: devices
[   43.920248] kobject target0:0:5: registering. parent: spi_transport, set: class_obj
[   43.925135]   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
[   43.927873]   Type:   CD-ROM                             ANSI SCSI revision: 02
[   43.930543]  target0:0:5: asynchronous.
[   43.933130]  target0:0:5: Beginning Domain Validation
[   43.937224]  target0:0:5: Domain Validation skipping write tests
[   43.940045]  target0:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
[   43.944099]  target0:0:5: Ending Domain Validation
[   43.946629] kobject 0:0:5:0: registering. parent: target0:0:5, set: devices
[   43.946640] kobject 0:0:5:0: registering. parent: scsi_device, set: class_obj
[   43.946656] kobject target0:0:6: registering. parent: host0, set: devices
[   43.946664] kobject target0:0:6: registering. parent: spi_transport, set: class_obj
[   43.947795]   Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
[   43.950487]   Type:   Direct-Access                      ANSI SCSI revision: 03
[   43.953091]  target0:0:6: asynchronous.
[   43.955613] scsi0:A:6:0: Tagged Queuing enabled.  Depth 250
[   43.958183]  target0:0:6: Beginning Domain Validation
[   43.963544]  target0:0:6: wide asynchronous.
[   43.970778]  target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
[   43.982801]  target0:0:6: Ending Domain Validation
[   43.985348] kobject 0:0:6:0: registering. parent: target0:0:6, set: devices
[   43.985360] kobject 0:0:6:0: registering. parent: scsi_device, set: class_obj
[   43.985898] kobject target0:0:8: registering. parent: host0, set: devices
[   43.985917] kobject target0:0:8: registering. parent: spi_transport, set: class_obj
[   44.242053] kobject <NULL>: cleaning up
[   44.242068] kobject target0:0:8: cleaning up
[   44.242071] kobject target0:0:8: cleaning up
[   44.242077] kobject target0:0:9: registering. parent: host0, set: devices
[   44.242085] kobject target0:0:9: registering. parent: spi_transport, set: class_obj
[   44.498214] kobject <NULL>: cleaning up
[   44.498228] kobject target0:0:9: cleaning up
[   44.498231] kobject target0:0:9: cleaning up
[   44.498237] kobject target0:0:10: registering. parent: host0, set: devices
[   44.498245] kobject target0:0:10: registering. parent: spi_transport, set: class_obj
[   44.754374] kobject <NULL>: cleaning up
[   44.754388] kobject target0:0:10: cleaning up
[   44.754391] kobject target0:0:10: cleaning up
[   44.754397] kobject target0:0:11: registering. parent: host0, set: devices
[   44.754405] kobject target0:0:11: registering. parent: spi_transport, set: class_obj
[   45.010534] kobject <NULL>: cleaning up
[   45.010547] kobject target0:0:11: cleaning up
[   45.010551] kobject target0:0:11: cleaning up
[   45.010556] kobject target0:0:12: registering. parent: host0, set: devices
[   45.010564] kobject target0:0:12: registering. parent: spi_transport, set: class_obj
[   45.266692] kobject <NULL>: cleaning up
[   45.266706] kobject target0:0:12: cleaning up
[   45.266709] kobject target0:0:12: cleaning up
[   45.266714] kobject target0:0:13: registering. parent: host0, set: devices
[   45.266722] kobject target0:0:13: registering. parent: spi_transport, set: class_obj
[   45.522851] kobject <NULL>: cleaning up
[   45.522864] kobject target0:0:13: cleaning up
[   45.522867] kobject target0:0:13: cleaning up
[   45.522873] kobject target0:0:14: registering. parent: host0, set: devices
[   45.522881] kobject target0:0:14: registering. parent: spi_transport, set: class_obj
[   45.779010] kobject <NULL>: cleaning up
[   45.779023] kobject target0:0:14: cleaning up
[   45.779026] kobject target0:0:14: cleaning up
[   45.779032] kobject target0:0:15: registering. parent: host0, set: devices
[   45.779040] kobject target0:0:15: registering. parent: spi_transport, set: class_obj
[   46.035168] kobject <NULL>: cleaning up
[   46.035182] kobject target0:0:15: cleaning up
[   46.035185] kobject target0:0:15: cleaning up
[   46.035218] kobject sd: registering. parent: <NULL>, set: drivers
[   46.036144] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   46.040009] SCSI device sda: drive cache: write back
[   46.042622] kobject sda: registering. parent: <NULL>, set: block
[   46.043558] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   46.047467] SCSI device sda: drive cache: write back
[   46.050117]  sda: sda1 sda2 sda3 sda4
[   46.074908] kobject sda1: registering. parent: sda, set: <NULL>
[   46.074921] kobject sda2: registering. parent: sda, set: <NULL>
[   46.074927] kobject sda3: registering. parent: sda, set: <NULL>
[   46.074934] kobject sda4: registering. parent: sda, set: <NULL>
[   46.074957] kobject queue: registering. parent: sda, set: <NULL>
[   46.074965] kobject iosched: registering. parent: queue, set: <NULL>
[   46.074972] Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
[   46.077641] kobject sr: registering. parent: <NULL>, set: drivers
[   46.079568] sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
[   46.082224] Uniform CD-ROM driver Revision: 3.20
[   46.084874] kobject sr0: registering. parent: <NULL>, set: block
[   46.084886] kobject queue: registering. parent: sr0, set: <NULL>
[   46.084892] kobject iosched: registering. parent: queue, set: <NULL>
[   46.084899] Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
[   46.089717] sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   46.092388] kobject sr1: registering. parent: <NULL>, set: block
[   46.092409] kobject queue: registering. parent: sr1, set: <NULL>
[   46.092415] kobject iosched: registering. parent: queue, set: <NULL>
[   46.092422] Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
<...>

