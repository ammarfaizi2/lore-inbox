Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUHRSqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUHRSqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUHRSpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:45:50 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:39686 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267475AbUHRSpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:45:45 -0400
Date: Wed, 18 Aug 2004 19:45:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Dave Jones <davej@redhat.com>,
       =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops modprobing i830 with 2.6.8.1
Message-ID: <20040818194531.A1703@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Dave Jones <davej@redhat.com>,
	=?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040817220816.GA14343@hardeman.nu> <20040817233732.GA8264@redhat.com> <20040818004339.A27701@infradead.org> <20040817234522.GA4170@redhat.com> <1092801681.27352.194.camel@bach> <20040818101540.A30983@infradead.org> <1092849766.26057.14.camel@localhost.localdomain> <20040818192806.A1511@infradead.org> <1092850671.26051.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092850671.26051.22.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 18, 2004 at 06:37:51PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 06:37:51PM +0100, Alan Cox wrote:
> On Mer, 2004-08-18 at 19:28, Christoph Hellwig wrote:
> > Well, aic7xxx also works without a pci version of the card present, even
> > if you compile your kernel with PCI..  I don't want to say we should change
> > the driver to not work anymore if there's not agp support, but that the
> > driver shouldn't try to overengineeredly do all this runtime probing unlike
> > everyone else.
> 
> Yes but PCI isnt a module that doesn't load if you have no supported AGP
> device

Well, if you want an example that exactly matches the drm situation look at
various driver with optional i2c support, like many of the fbdev ones.

