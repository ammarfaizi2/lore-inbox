Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUBKRo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbUBKRo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 12:44:27 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:2257 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264147AbUBKRoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 12:44:25 -0500
Date: Wed, 11 Feb 2004 12:43:58 -0500
From: Ron Gage <ron@rongage.org>
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.4.24 Via audio driver.
MIME-Version: 1.0
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.10.4
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402111243.58470.ron@rongage.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone offer any possible debug tips for tracing a problem with the Via 
Audio driver under 2.4.24?

Before anyone asks, I already tried using the email address in the maintainers 
list (linux-via@gtf.org) - that address is invalid - no such user.

The problem is that the audio driver appears to not be initializing the DSP
correctly.  Thus, I get no audio out.

Here is the relevent lines from dmesg:

root@db:~# dmesg | grep -i via
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xa800, 00:0c:6e:74:2a:03, IRQ 9.
agpgart: Detected Via Apollo Pro KT400 chipset
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
Via 686a/8233/8235 audio driver 1.9.1-ac3
via82cxxx: Six channel audio available
via82cxxx: timeout while reading AC97 codec (0x8000000)
via82cxxx: board #1 at 0xE000, IRQ 9

Note that I already have tried the following in via_ac97_wait_idle
(via82cxxx.c): changing the usleep value from 15 to 150 - no difference.

Here is the dump from lspci -vv
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio
Controller (rev 50)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a1
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 9
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks for your time and help!


-- 
Ronald R. Gage
MCP, LPIC1, A+, Net+
Pontiac, Michigan





----------------------------------------------------------------
This message was sent using webmail provided by www.rongage.org
