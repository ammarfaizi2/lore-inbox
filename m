Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265498AbTIDTHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbTIDTHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:07:45 -0400
Received: from www.inreko.ee ([195.222.18.2]:50188 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id S265498AbTIDTHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:07:44 -0400
Date: Thu, 4 Sep 2003 22:07:39 +0300
From: Marko Kreen <marko@l-t.ee>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.4.22 / HPT372N
Message-ID: <20030904190426.GA31977@l-t.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As i used the pen&paper method for oops tracking i dont have
full oops.

In hpt366.c function hpt372_tune_chipset line 427:

       list_conf = pci_bus_clock_list(speed,
                        (struct chipset_bus_clock_list_entry *)
                                        pci_get_drvdata(dev));

pci_get_drvdata(dev) returns NULL.

Crash happens only if there are some devices attached to hpt.

lspci -vv:

02:00.0 RAID bus controller: Triones Technologies, Inc.  HPT366/368/370/370A/372 (rev 06)
        Subsystem: Triones Technologies, Inc. HPT370A
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at a000 [size=8]
        Region 1: I/O ports at a400 [size=4]
        Region 2: I/O ports at a800 [size=8]
        Region 3: I/O ports at ac00 [size=4]
        Region 4: I/O ports at b000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 

Full config, dmesg(of a non-crash boot) & lspci:

http://www.l-t.ee/marko/hptcrash.tgz


