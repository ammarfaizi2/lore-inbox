Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUCWLll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUCWLll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:41:41 -0500
Received: from aun.it.uu.se ([130.238.12.36]:61072 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262499AbUCWLlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:41:40 -0500
Date: Tue, 23 Mar 2004 12:41:37 +0100 (MET)
Message-Id: <200403231141.i2NBfb2a009314@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: doug@pigeonhold.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: APIC on Chaintech ZNF3-150 Motherboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 10:32:45 +0000, Doug Winter wrote:
>I've just put a new computer together with an AMD Athlon 64 3200+ and a
>Chaintech ZNF3-150 motherboard.  This has the Nvidia NForce 3 chipset.
>
>Booting 2.6.4, from the debian kernel-image-2.6.4-1-k7 package, I get
>reproducible errors from the onboard BCM5788 NIC and a Realtek 8139 NIC
>when under load.
>
>When the disk is under load, I get reproducible DMA errors from any IDE
>disk that is under load.
>
>When I boot with "noapic", these problems go away.

NVidia chipsets are known to have problems when used with
local APIC or I/O-APIC. We don't know exactly what happens,
but it looks like a hardware or BIOS problem. The only
known cure is to try combinations of:

upgrade BIOS
pci=noacpi
acpi=off
noapic
nolapic

FWIW, VIA's K8T800 chipset seems to work very well.
