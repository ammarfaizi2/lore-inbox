Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263631AbUJ2Xea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbUJ2Xea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbUJ2Xd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:33:57 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:25869 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S263533AbUJ2XaI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:30:08 -0400
X-Ironport-AV: i="3.86,111,1096866000"; 
   d="scan'208"; a="99939643:sNHT26763496"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Fri, 29 Oct 2004 18:30:01 -0500
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC6@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcS9/Fb9XwwPmP7rSh6OztBQ42HawQAEXY2w
From: <Tim_T_Murphy@Dell.com>
To: <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Oct 2004 23:30:03.0037 (UTC) FILETIME=[370974D0:01C4BE0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, if you forward lspci -vvx and the "maddr" and "irqno"
information
> (in private mail if you prefer) then I'll fix 8250_pci to work.

maddr:	10		# note, this is for the UP kernel. for SMP,
maddr=201
irqno:	ec40
lspci -d 1028:0008 -vvx:

00:08.1 Class ff00: Dell Remote Access Card III
	Subsystem: Dell Remote Access Card III
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at fe202000 (32-bit, non-prefetchable)
[size=4K]
	Region 1: I/O ports at ec40 [size=64]
	Region 2: Memory at feb00000 (32-bit, prefetchable) [size=512K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 28 10 08 00 03 01 90 02 00 00 00 ff 10 20 80 00
10: 00 20 20 fe 41 ec 00 00 08 00 b0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 08 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 02 00 00

> I think dropping low_latency will work around the problem for the time
> being.

Thanks a lot for the help and advice, I will try this and report
results.

Tim
