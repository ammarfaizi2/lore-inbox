Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTIHTre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTIHTrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:47:18 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:64929 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263566AbTIHTrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:47:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16220.56495.308087.395919@gargle.gargle.HOWL>
Date: Mon, 8 Sep 2003 21:46:55 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>, torvalds@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
Subject: Re: [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
In-Reply-To: <3F5936D2.3060502@pobox.com>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	<200309060016.16545.adq_dvb@lidskialf.net>
	<3F590E28.6090101@pobox.com>
	<200309060157.47121.adq_dvb@lidskialf.net>
	<3F5936D2.3060502@pobox.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
 > Andrew de Quincey wrote:
 > > This patch removes some erroneous code from mpparse which breaks IO-APIC programming
 > > 
 > > 
 > > --- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06 00:23:10.000000000 +0100
 > > +++ linux-2.6.0-test4.duffmpparse/arch/i386/kernel/mpparse.c	2003-09-06 00:28:23.788124872 +0100
 > > @@ -1129,9 +1129,6 @@
 > >  			continue;
 > >  		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 > >  
 > > -		if (!ioapic && (irq < 16))
 > > -			irq += 16;
 > > -
 > 
 > 
 > Even though I've been digging through stuff off and on, I consider 
 > myself pretty darn IOAPIC-clueless.  Mikael, does this look sane to you?

Sorry, I'm only a local APIC caretaker, not an I/O-APIC expert.
Check with Alan, Ingo, Maciej, or the big-SMP people.
