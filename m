Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVGLXU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVGLXU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVGLXSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:18:15 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:14346 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S262448AbVGLXQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:16:49 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 18:16:46 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C54@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Thread-Index: AcWHLTl6U6HQu4UOSb+YRwHOgTiNLAAB/xtg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Michel Bouissou" <michel@bouissou.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Jul 2005 23:16:46.0963 (UTC) FILETIME=[C64A3430:01C58737]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Now that we know which is the offending device, it should 
> be easy to 
> > find out why the IRQ assignments go wrong.  That certainly 
> needs to be 
> > fixed, even though Michel's problem appears to be solved.
> 
> Well, it's solved by currently giving me the choice between 
> no USB 2.0 and IO-APIC, or USB 2.0 and no IO-APIC. That makes 
> a temporary solution, but I'd love to have both (and recall 
> the happy times of 2.4x that was happy with both ;-)
> 
> Natalie, could you please tell me which kernel (I have 
> started to have a number of them ;-) you'd like me <<  to 
> boot with "apic=debug" and also perhaps with "pci=routeirq" 
> and collect the trace >>, and with which BIOS setup ? (i.e. 
> USB 2.0 enabled or disabled ?).

At this point, you'll need to set the system back to its original state
that you started with, and have both "apic=debug" and "pci=routeirq" as
boot options. I'd say use the last kernel that you prepared with USB
support there (and all usual devices enabled in BIOS).
 
> When you speak about "collecting the trace", I assume you 
> mean the dmesg or /var/log/messages I'll get after booting this way ?

Yes, the dmesg will have all early setup information, including
interrupts setup. With pci=routeirq, all the PCI IRQ mappings should be
there, too, and you might need to include part of /var/log/messages
where USB devices get configured.

Thanks,
--Natalie 
