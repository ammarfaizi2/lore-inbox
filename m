Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUDMEBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDMEBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:01:48 -0400
Received: from Sophia.Soo.com ([199.202.113.33]:51725 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id S263252AbUDMEBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:01:47 -0400
Date: Tue, 13 Apr 2004 00:01:45 -0400
From: really bensoo_at_soo_dot_com <lnx-kern@soo.com>
To: linux-kernel@vger.kernel.org, Ross Dickson <ross@datscreative.com.au>
Subject: Re: IO-APIC on nforce2
Message-ID: <20040413040145.GA3327@Sophia.soo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Ross Dickson <ross@datscreative.com.au>
References: <200404131117.31306.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404131117.31306.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very odd.  i'm using plain 2.6.5 with your 2.6.3
APIC patches, and left all this io_apic_set_pci_routing()
stuff in.  And, for this first time in who knows
how long i seem to have a stable computer.  Actually
been up more than eight days.

This is an old overclocked MSI K7N2 with the first
revision of the nForce2 chipset, the one that's only
supposed to have UDMA100 (dunno if that's the chipset
or the MSI mboard: the 2.6.X kernels have always said
during bootup that it's running UDMA133).  i use an
old Tulip ethercard instead of the onboard LAN.

This machine is the beater box: an HTPC and a 24/7
file share client, compile and test stuff, play music
thru an Audigy sound card, burn DVD's, play video
files, many of these things at the same time.

Before this kernel i was lucky to have uptimes over
two days.

b

On Tue, Apr 13, 2004 at 11:17:31AM +1000, Ross Dickson wrote:
> I am working with 2.4.26-rc2 and have noticed a change with the the recent acpi?
> update. The recent fix to stop unnecessary ioapic irq routing entries puts the 
> following if statement into io_apic.c, io_apic_set_pci_routing()
> 
> 	/*
> 	 * IRQs < 16 are already in the irq_2_pin[] map
> 	 */
> 	if (irq >= 16)
> 		add_pin_to_irq(irq, ioapic, pin);
> 
> which prevents my io-apic patch from using that function to reprogram the
> io-apic pin on irq0 from pin2 to pin0. 

