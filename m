Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTIIWCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbTIIWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:02:18 -0400
Received: from zok.SGI.COM ([204.94.215.101]:42176 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264667AbTIIWCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:02:11 -0400
Date: Tue, 9 Sep 2003 15:01:42 -0700
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Message-ID: <20030909220142.GA7668@sgi.com>
Mail-Followup-To: Andrew de Quincey <adq_dvb@lidskialf.net>,
	andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309092143.58189.adq@lidskialf.net> <20030909211756.GA7487@sgi.com> <200309092238.27112.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309092238.27112.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 10:38:26PM +0100, Andrew de Quincey wrote:
> On Tuesday 09 September 2003 22:17, Jesse Barnes wrote:
> > On Tue, Sep 09, 2003 at 09:43:58PM +0100, Andrew de Quincey wrote:
> > > On Tuesday 09 September 2003 21:13, Jesse Barnes wrote:
> > > > Instead of going into an infinite loop because the list isn't setup
> > > > yet, just return NULL if there are no prt entries.
> > >
> > > Ah, this is a patch against the vanilla kernel.. This is unfortunately
> > > incompatible with my recent ACPI patches.
> >
> > Maybe you could include it in your patch then?  I noticed that your
> > patch changes some of the IRQ routing code...
> 
> I'm not sure it is still needed or not. The patch makes a lot of changes as to 
> how the acpi_prt list is generated. What triggers the problem exactly, so I 
> can test? 

An SGI Altix system that only supports part of the ACPI spec :).  Our
PROM currently doesn't generate any MADT entries other than CPUs (I'm
not even sure how we could add them since we use our own interrupt
controller, not an IOAPIC or IOSAPIC) and lacks an ACPI namespace, so
we're missing all sorts of stuff.

Jesse
