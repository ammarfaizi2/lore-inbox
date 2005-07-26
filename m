Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVGZCNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVGZCNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGZCNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:13:48 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:10769 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S261540AbVGZCNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:13:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Date: Mon, 25 Jul 2005 21:13:18 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C75@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Thread-Index: AcWRhS4bUPQpScLyQbiKl2FBEPcHpAAAVSCw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Alan Stern" <stern@rowland.harvard.edu>,
       "Michel Bouissou" <michel@bouissou.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2005 02:13:19.0352 (UTC) FILETIME=[97373F80:01C59187]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Le Lundi 25 Juillet 2005 22:44, Alan Stern a écrit :
> > >
> > > Now that's strange.  When you plug the high-speed device into the 
> > > integrated ports, which IRQ counter changes?  Since 
> nothing is using 
> > > IRQ 21, it should be disabled and its counter should remain 
> > > constant.  Does this mean the interrupts show up on IRQ 
> 19 (used by 
> > > ehci-hcd), or do they not show up at all (i.e., is the 
> USB connection just being polled)?
> > 
> > I assume it's IRQ 19.
> > 
> > cat /proc/interrupts doesn't show IRQ21 at all when uhci 
> isn't loaded.
> 
> As it shouldn't, since nothing is supposed to be using that IRQ.
> 
> > IRQ 19 being shared with 4 IDE controllers that controls my hard 
> > drives, that's hard to isolate interrupts counts due to USB 
> activity 
> > from interrupts counts due to disks activity...
> 
> I was afraid you'd say that...
> 
> Natalie, that's all I can think of.  Now it's up to you to 
> invent a patch Michel can try out, to show just where the 
> IO-APIC code is going wrong.

I will sure try... I'm keeping an eye on your exchange don't worry :) 
just have to get done with urgent work piled up here while on my trip :< ...

--N
 
> Alan Stern
> 
> 
