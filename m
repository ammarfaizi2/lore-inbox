Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752231AbWCJLkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbWCJLkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbWCJLkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:40:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17897 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751933AbWCJLkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:40:42 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Tim Small <tim@buttersideup.com>
Cc: Dave Peterson <dsp@llnl.gov>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <44115DA4.604@buttersideup.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603091551.25097.dsp@llnl.gov> <20060310000227.GA30236@kroah.com>
	 <200603091746.51686.dsp@llnl.gov>
	 <1141976218.2876.2.camel@laptopd505.fenrus.org>
	 <44115DA4.604@buttersideup.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 12:40:35 +0100
Message-Id: <1141990836.2876.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 11:06 +0000, Tim Small wrote:
> Arjan van de Ven wrote:
> 
> > It depends on how many PCI devices in your machine you wish to
> >
> >>blacklist or whitelist.  The motivation for this feature is that
> >>certain known badly-designed devices report an endless stream of
> >>spurious PCI bus parity errors.  We want to skip such devices when
> >>checking for PCI bus parity errors.
> >>    
> >>
> >
> >ok so this is actually a per pci device property!
> >I would suggest moving this property to the pci device itself, not doing
> >it inside an edac directory.
> >  
> >
> Yes, this seems more sensible to me.  For one thing, I suspect that just 
> keying on vendor:device is probably too blunt for this and that 
> blacklisting a particular PCI device revision is a likely requirement, 
> as well as subsystem vendor/subsystem device.

and maybe even something as funky as firmware version.
So it for sure is a per device (not per ID) property, and something that
needs a global quirk table kind of thing with the option to do per
driver overrides


