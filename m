Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbTDVAha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 20:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTDVAha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 20:37:30 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:50075 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S262693AbTDVAh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 20:37:29 -0400
Date: Mon, 21 Apr 2003 18:49:33 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: ENE Technology flash memory reader
Message-ID: <20030421184933.A17766@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have here on a machine a flash card reader with a PCI id 1524:0510.
In a verbose mode from 'lspci' it identifies itself as

00:10.1 FLASH memory: ENE Technology Inc: Unknown device 0510
	Subsystem: Asustek Computer, Inc.: Unknown device 1724
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 3
	Region 0: I/O ports at 8400 [size=128]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


This seems to be somewhat integrated with a bus controller 1524:1411, a.k.a

00:10.0 CardBus bridge: ENE Technology Inc: Unknown device 1411 (rev 01)
	Subsystem: ENE Technology Inc: Unknown device 1411

A Windows driver (at least 0510 part of it) treats that as some
kind of a SCSI device.

So far I cannot make Linux with 2.4.x kernels to recognize that
gizmo.  Does anybody know if there is a device driver which would
make this workable in Linux?

Apparently some details about it one can find in
http://www.tssc.de/download/docs/List%20of%20supported%20devices.pdf

   Thanks,
   Michal
