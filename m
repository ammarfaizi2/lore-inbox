Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUGKUhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUGKUhH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUGKUhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:37:07 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:47764 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264430AbUGKUhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:37:03 -0400
Date: Sun, 11 Jul 2004 22:36:59 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: VESA fb problem with 2.6.7-mm[567]
Message-ID: <20040711203659.GE2899@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The nvidia graphics card in one of my laptops cannot be talked into
working with vesafb:

...
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Cannot allocate resource region 4 of device 0000:00:01.1
PCI: Cannot allocate resource region 5 of device 0000:00:01.1
vesafb: probe of vesafb0 failed with error -6
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Simple Boot Flag at 0x36 set to 0x1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
...

0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go 32M] (rev a3) (prog-if 00 [VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 006d
        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 11
        Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Memory at fc000000 (32-bit, prefetchable) [size=512K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0
	
Short:

* vesafb fails
* vga16fb works

The same kernel works on another laptop with another nvidia card.
The only major difference is the unorthodox display resolution in this
laptop (WXGA, 1280x800).

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
