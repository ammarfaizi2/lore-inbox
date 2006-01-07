Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbWAGVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbWAGVmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbWAGVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:42:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62372 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030595AbWAGVmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:42:18 -0500
Date: Sat, 7 Jan 2006 16:42:08 -0500
From: Dave Jones <davej@redhat.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
Message-ID: <20060107214208.GR9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C03214.5080201@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 04:26:44PM -0500, Brice Goglin wrote:

 > It might be a PCI Express, I'm not sure. Here's lspci -vvv as root.
 > Where am I supposed to look ?
 > 
 > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon
 > Mobility M300] (prog-if 00 [VGA])
 >         Subsystem: IBM: Unknown device 056e
 >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
 > ParErr- Stepping- SERR+ FastB2B-
 >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
 > <TAbort- <MAbort- >SERR- <PERR-
 >         Latency: 0, Cache Line Size: 0x08 (32 bytes)
 >         Interrupt: pin A routed to IRQ 169
 >         Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
 >         Region 1: I/O ports at 2000 [size=256]
 >         Region 2: Memory at a8100000 (32-bit, non-prefetchable) [size=64K]
 >         Expansion ROM at a8120000 [disabled] [size=128K]
 >         Capabilities: [50] Power Management version 2
 >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
 > PME(D0-,D1-,D2-,D3hot-,D3cold-)
 >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 >         Capabilities: [58] #10 [0001]
 >         Capabilities: [80] Message Signalled Interrupts: 64bit+
 > Queue=0/0 Enable-
 >                 Address: 0000000000000000  Data: 0000
 >
 > Assuming this is a PCI Express card, then what is the proper fix ?

It's PCIE.

 > Should I prevent my initscript from loading agpgart (actually intel_agp)
 > at all ? (I guess udev or hotplug is trying to load it here). Is there
 > something like agpgart for PCI express ? Or is it useless ?

it's useless. though the loading of it shouldn't harm anything.
Does it spew warnings during your boot ?

		Dave

