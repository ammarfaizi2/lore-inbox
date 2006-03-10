Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWCJR6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWCJR6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWCJR6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:58:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56741 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751295AbWCJR6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:58:06 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <200603100946.12448.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603091746.51686.dsp@llnl.gov>
	 <1141976218.2876.2.camel@laptopd505.fenrus.org>
	 <200603100946.12448.dsp@llnl.gov>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 18:58:01 +0100
Message-Id: <1142013481.2876.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 09:46 -0800, Dave Peterson wrote:
> On Thursday 09 March 2006 23:36, Arjan van de Ven wrote:
> > ok so this is actually a per pci device property!
> > I would suggest moving this property to the pci device itself, not doing
> > it inside an edac directory.
> >
> > by doing that you get the advantage that 1) it's a more logical place,
> > and 2) users can do it even for 1 of 2 cards, if they have 2 cards of
> > the same make and 3) you can use the generic kernel quirk interface for
> > this and 4) drivers can in principle control this for their hardware in
> > complex cases
> >
> > I understand that on a PC, EDAC is the only user. but ppc has a similar
> > mechanism I suspect, and they more than likely would be able to share
> > this property....
> 
> I'd be curious to hear people's opinions on the following idea:
> move the PCI bus parity error checking functionality from EDAC
> to the PCI subsystem.

I can see the point on at least moving all the infrastructure there. 
The actual call to run it... maybe. that's more debatable I suppose. 

