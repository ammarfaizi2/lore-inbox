Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTGAVSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTGAVSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:18:48 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([24.192.190.108]:13060
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S263823AbTGAVSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:18:42 -0400
Date: Tue, 1 Jul 2003 17:33:04 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
cc: caberome@bellsouth.net
Subject: Re: simple pnp bios io resources bug makes  system unusable
Message-ID: <Pine.LNX.4.44.0307011728120.470-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem I experienced was when I disable parport in the IBM BIOS, PnP
gets invalid values it set io 0x0 -> 0xfffffffffff and some other misc
values for IRQ and DMA.

This might fix that issue.

isapnp: Card 'Crystal Audio'
isapnp: Card 'Creative SB32 PnP'
isapnp: Card 'U.S. Robotics Sportster 33600 FAX/Voice Int'
isapnp: 3 Plug & Play cards detected total

There some other issues though that are being worked on.

Shawn S.

>my one line patch just skips an io registration with a simple sanity
>check.
>never once have i heard a device with an ioport of 0x0.
>question is why it happens and only once.
>tested with

>ISA Plug and Play:
>U.S. Robotics Sportster 33600 FAX/Voice Int
>Creative ViBRA16C PnP
>Crystal Codec

>Host/PCI Bridge:
>VIA Technologies, In VT82C585VP [Apollo V
>VIA Technologies, In VT82C586/A/B PCI-to-
>VIA Technologies, In VT82C586/B/686A/B PI
>VIA Technologies, In USB
>VIA Technologies, In VT82C586B ACPI

>(also noticing cutoff in /sys/devices/pci0/*/name)


