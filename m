Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130264AbRCCENA>; Fri, 2 Mar 2001 23:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130266AbRCCEMv>; Fri, 2 Mar 2001 23:12:51 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:24541 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130264AbRCCEMk>; Fri, 2 Mar 2001 23:12:40 -0500
Message-Id: <200103030503.f2353PQ21936@513.holly-springs.nc.us>
Subject: VT82C586B USB PCI card, Linux USB
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution (0.8/+cvs.2001.02.14.08.55 - Preview Release)
Date: 03 Mar 2001 00:13:49 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a USB PCI card, which shows up as this in `lspci`:

00:09.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 04)

... it appears that they tossed the whole southbridge chip onto a pci
board, and disabled everything but USB. Anyway, this device seems to be
semi-functional under 2.2.18 USB. I have a cheapie IBM usb camera that
works, but a USB scanner that does not -- always gives the following
errors:

usb_control/bulk_msg: timeout 
scanner.c: write_scanner: NAK received.

The firmware upload seems to work ok, but nothing else does. The sane
tools actually segfault, and once the kernel oopsed (didn't manage to
get the output :( ).

 I noticed a config setting for that chipset, but it was under block
devices, so I left it turned off. Judging form reading the LKML, VIA
chipsets are problematic. Has anyone has any positive experiences
getting this device to do the thing it's supposed to do under Linux? Any
tips?

-M

