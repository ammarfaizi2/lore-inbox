Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbTIFNpz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 09:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTIFNpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 09:45:55 -0400
Received: from ns.suse.de ([195.135.220.2]:11471 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261273AbTIFNpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 09:45:54 -0400
Date: Sat, 6 Sep 2003 15:45:50 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: jgarzik@pobox.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com, mikpe@csd.uu.se
Subject: Re: [ACPI] Re: [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Message-Id: <20030906154550.0334a2d5.ak@suse.de>
In-Reply-To: <200309061327.16347.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	<200309060157.47121.adq_dvb@lidskialf.net>
	<3F5936D2.3060502@pobox.com>
	<200309061327.16347.adq_dvb@lidskialf.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Sep 2003 13:27:16 +0100
Andrew de Quincey <adq_dvb@lidskialf.net> wrote:

> On Saturday 06 September 2003 02:22, Jeff Garzik wrote:
> > Andrew de Quincey wrote:
> > > This patch removes some erroneous code from mpparse which breaks IO-APIC
> > > programming
> > >
> > >
> > > --- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06
> > > 00:23:10.000000000 +0100 +++
> > > linux-2.6.0-test4.duffmpparse/arch/i386/kernel/mpparse.c	2003-09-06
> > > 00:28:23.788124872 +0100 @@ -1129,9 +1129,6 @@
> > >  			continue;
> > >  		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
> > >
> > > -		if (!ioapic && (irq < 16))
> > > -			irq += 16;
> > > -
> >
> > Even though I've been digging through stuff off and on, I consider
> > myself pretty darn IOAPIC-clueless.  Mikael, does this look sane to you?
> 
> Really breaks on TX150 servers... All IRQs < 16 get +16 added onto them, which 
> breaks all IRQ routing. It's also already been removed from 2.4.23-pre3

It is needed at least for the Unisys ES7000. But that box needs further changes
anyways which are not in tree yet and is even an own subarchitecture that can be 
tested for.

-Andi
