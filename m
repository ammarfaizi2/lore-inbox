Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWAORV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWAORV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWAORV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:21:28 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:55745 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932097AbWAORV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:21:27 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun, 15 Jan 2006 18:21:19 +0100
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: spurious 8259A interrupt: IRQ7
In-reply-to: <20060115171134.94B7B22AEFB@anxur.fi.muni.cz>
Message-Id: <20060115172118.A9CE622B38F@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: benh@kernel.crashing.org

>Hello,
>
>I have this problem with irq 7. There are many ERR interrupts as you can see in
>the table below.
>Count of errorneous is similar to count of radeon interrupts (since start of
>system).
>It appears in all kernels I tried (since 2.6.11.7).
>           CPU0       
>  0:     367164          XT-PIC  timer
>  1:       2397          XT-PIC  i8042
>  2:          0          XT-PIC  cascade
>  5:       5355          XT-PIC  ATI IXP, eth0
>  8:          1          XT-PIC  rtc
>  9:        163          XT-PIC  acpi
> 10:      25595          XT-PIC  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
> 11:      85385          XT-PIC  radeon@pci:0000:01:05.0
> 12:       4991          XT-PIC  i8042
> 14:       8576          XT-PIC  ide0
> 15:      12774          XT-PIC  ide1
>NMI:          0 
>LOC:     367136 
>ERR:      82119
>MIS:          0
>
>without running X, there is no ERR (and also no irq 11).
>Card:
>01:05.0 VGA compatible controller: ATI Technologies Inc RS300M AGP [Radeon Mobility 9100IGP] (prog-if 00 [VGA])
>        Subsystem: ASUSTeK Computer Inc.: Unknown device 1902
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 64 (2000ns min), Cache Line Size 10
>        Interrupt: pin A routed to IRQ 11
>        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
>        Region 1: I/O ports at d000 [size=256]
>        Region 2: Memory at fda00000 (32-bit, non-prefetchable) [size=64K]
>        Expansion ROM at fd900000 [disabled] [size=128K]
>        Capabilities: [58] AGP version 3.0
>                Status: RQ=256 Iso- ArqSz=0 Cal=7 SBA+ ITACoh- GART64- HTrans- 64bit+ FW+ AGP3+ Rate=x4,x8
>                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>regards,
>--
>Jiri Slaby         www.fi.muni.cz/~xslaby
>~\-/~      jirislaby@gmail.com      ~\-/~
>B67499670407CE62ACC8 22A032CC55C339D47A7E
