Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbTCDBih>; Mon, 3 Mar 2003 20:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbTCDBih>; Mon, 3 Mar 2003 20:38:37 -0500
Received: from mx02.cyberus.ca ([216.191.240.26]:34570 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id <S268957AbTCDBig>;
	Mon, 3 Mar 2003 20:38:36 -0500
Date: Mon, 3 Mar 2003 20:48:16 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, "" <kuznet@ms2.inr.ac.ru>,
       "" <david.knierim@tekelec.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Donald Becker <becker@scyld.com>, "" <linux-kernel@vger.kernel.org>,
       "" <alexander@netintact.se>, "" <raarts@office.netland.nl>
Subject: Re: PCI init issues
In-Reply-To: <20030303151412.A15195@jurassic.park.msu.ru>
Message-ID: <20030303203540.F67734@shell.cyberus.ca>
References: <20030302121050.F61365@shell.cyberus.ca> <20030303151412.A15195@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ivan,

Patch was applied; no luck at all. Below is dmesg output with
debug turned on in the pci-irq.c file.

--------
Mar  3 18:01:39 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xfd875last bus=8
Mar  3 18:01:39 localhost kernel: PCI: Using configuration type 1
Mar  3 18:01:39 localhost kernel: PCI: Probing PCI hardware
Mar  3 18:01:39 localhost kernel: PCI: Probing PCI hardware
Mar  3 18:01:39 localhost kernel: Transparent bridge - Intel Corp.
82801BA/CA/ PCI Bridge
Mar  3 18:01:39 localhost kernel: PCI: Discovered primary peer bus 10
[IRQ]
Mar  3 18:01:39 localhost kernel: PCI: Discovered primary peer bus 11
[IRQ]
Mar  3 18:01:39 localhost kernel: PCI: Discovered primary peer bus 12
[IRQ]
Mar  3 18:01:39 localhost kernel: PCI: Using IRQ router PIIX [8086/2480]
at 00f.0
Mar  3 18:01:39 localhost kernel: PCI: IRQ fixup
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B0,I29,P0) ->
16
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B0,I29,P1) ->
19
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B0,I29,P2) ->
18
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B2,I1,P1) ->
48
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B3,I1,P1) ->
24
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B3,I1,P2) ->
25
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I4,P0) ->
96
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I5,P1) ->
96
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I6,P2) ->
96
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B6,I7,P3) ->
96
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B8,I1,P1) ->
16
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B8,I2,P2) ->
17
Mar  3 18:01:39 localhost kernel: PCI->APIC IRQ transform: (B8,I3,P3) ->
18
---------------

BIOS irq assignments i suppose are validated.

I have a feeling the reason it works in windows is because of a
functional ACPI.

What next? ;->

cheers,
jamal
