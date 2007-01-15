Return-Path: <linux-kernel-owner+w=401wt.eu-S1751760AbXAOAbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbXAOAbH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbXAOAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:31:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:49044 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbXAOAbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:31:05 -0500
Date: Sun, 14 Jan 2007 16:29:24 -0800
From: Greg KH <greg@kroah.com>
To: Dave Airlie <airlied@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc5] intel_rng: substitue magic PCI IDs with macros
Message-ID: <20070115002924.GA20993@kroah.com>
References: <20070114172421.GA3874@Ahmed> <1168796241.3123.954.camel@laptopd505.fenrus.org> <21d7e9970701141131n24bb371di2c941c681b4afdf8@mail.gmail.com> <20070114230718.GB3874@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114230718.GB3874@Ahmed>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 01:07:18AM +0200, Ahmed S. Darwish wrote:
> On Mon, Jan 15, 2007 at 06:31:01AM +1100, Dave Airlie wrote:
> > On 1/15/07, Arjan van de Ven <arjan@infradead.org> wrote:
> > >On Sun, 2007-01-14 at 19:24 +0200, Ahmed S. Darwish wrote:
> > >> Substitue intel_rng magic PCI IDs values used in the IDs table
> > >> with the macros defined in pci_ids.h
> > >>
> > >Hi,
> > >
> > >hmm this is actually the opposite direction than most of the kernel is
> > >heading in, mostly because the pci_ids.h file is a major maintenance
> > >pain.
> > >
> > >Afaik the current "rule" is: if a PCI ID is only used in one driver, use
> > >the numeric value and not (add) a symbolic constant.
> > >
> > 
> > My guess is that the RNG is on the LPC so the values are used in a few 
> > places..
> > 
> 
> Will pci_ids.h be removed from the tree some time in the future then ?

No, it should contain ids that are used in multiple places (vendor ids
are one such example.)

And in this case, the majority of the patch is just using the vendor id,
which in my opinion, is a good idea.

thanks,

greg k-h
