Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWFYB2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWFYB2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 21:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWFYB2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 21:28:30 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:235 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S964886AbWFYB2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 21:28:30 -0400
X-ORBL: [64.216.106.128]
Message-ID: <449DE6BA.2050206@ksu.edu>
Date: Sat, 24 Jun 2006 20:28:26 -0500
From: "Scott J. Harmon" <harmon@ksu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060601)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: acpi gets wrong interrupt for via sata in 2.6.16.17
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this is my first time posting here.

The short: something that came in 2.6.16.17 has caused my sata to no
longer work correctly (by work correctly, I mean actually be able to
detect any drives).  I'm no expert, but it seems that it is getting the
wrong interrupt.  In 2.6.16.16 it works fine with the exact same config.
 It also works fine if I append 'pci=noacpi'.  This has still happens in
2.6.17.

Here is the output of lspci:

scott@amdg:~$ /sbin/lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:07.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705
Gigabit Ethernet (rev 03)
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46)
00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
01:00.0 VGA compatible controller: nVidia Corporation NV15DDR [GeForce2
Ti] (rev a4)


I can also attach my .config if needed.

Thanks,

Scott.
-- 
"Computer Science is no more about computers than astronomy is about
telescopes." - Edsger Dijkstra
