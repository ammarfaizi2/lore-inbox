Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTLORcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTLORcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:32:10 -0500
Received: from proxy.ovh.net ([213.244.20.42]:23825 "EHLO proxy.ovh.net")
	by vger.kernel.org with ESMTP id S263930AbTLORcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:32:00 -0500
Date: Mon, 15 Dec 2003 18:31:57 +0100
From: Miroslaw KLABA <totoro@totoro.be>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Double Interrupt with HT
Message-Id: <20031215183157.04d19f19.totoro@totoro.be>
In-Reply-To: <20031215171620.GA10252@MAIL.13thfloor.at>
References: <20031215155843.210107b6.totoro@totoro.be>
	<20031215171620.GA10252@MAIL.13thfloor.at>
Organization: Ovh
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  # echo "1" >/proc/irq/0/smp_affinity
> 
> which should stop the second 'cpu' from
> handling the timer interrupts ...
> 
> but this doesn't explain the 2x clock,
> which probably is some bug ...
> 
> HTH,
> Herbert
Thanks but already done. It must be a bug in 2.4.23, because with 2.6.0-test11,
I don't have any problem...

How may one find this bug?

Thanks.
Miro

# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. P4M266 Host Bridge
        Subsystem: VIA Technologies, Inc. P4M266 Host Bridge
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        Capabilities: [80] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at ee000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
        Subsystem: VIA Technologies, Inc.: Unknown device 4161
        Flags: medium devsel, IRQ 22
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
        Flags: bus master, medium devsel, latency 32, IRQ 23
        I/O ports at e800 [size=256]
        Memory at ee001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266] (prog-if 00 [VGA])
        Subsystem: S3 Inc. VT8375 [ProSavage8 KM266/KL266]
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at ed000000 (32-bit, non-prefetchable) [size=512K]
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [80] AGP version 2.0

