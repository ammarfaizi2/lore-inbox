Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbTBRRcZ>; Tue, 18 Feb 2003 12:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267917AbTBRRcZ>; Tue, 18 Feb 2003 12:32:25 -0500
Received: from fmr05.intel.com ([134.134.136.6]:45797 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267916AbTBRRcY>; Tue, 18 Feb 2003 12:32:24 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A18B@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Shawn Starr <shawn.starr@datawire.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Simone Piunno <pioppo@ferrara.linux.it>, Grover@unaropia,
       Adam Belay <ambx1@neo.rr.com>
Subject: RE: 2.5.xx ACPI/Sb16 IRQ conflict 
Date: Tue, 18 Feb 2003 09:42:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Shawn Starr [mailto:shawn.starr@datawire.net] 
> I can confirm this with 2.5.61 and my SB16AWE card. There 
> seems to be a bug 
> when PCI interrupts are set by ACPI on a IBM 300PL 6892-N2U.
> 
> Also, the IBM BIOS's PnP for OS is enabled.
> 
> When the PnP BIOS is disabled and pci=noacpi is NOT used. 
> There are no 
> conflicts. When PnP BIOS is enabled and we don't set 
> pci=noacpi we get 
> conflicts with IRQs. 

Hmmm, yes.

> >ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5

There should have been a previous line about LNKD, listing possible
interrupts for it -- what did that line say?

Clearly, either we need another IRQ for LNKD or we PnPISA needs to
assign a different IRQ - some coordination is needed here.

Regards -- Andy
