Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWHFVK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWHFVK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWHFVK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:10:28 -0400
Received: from xenotime.net ([66.160.160.81]:38311 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750718AbWHFVK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:10:27 -0400
Date: Sun, 6 Aug 2006 14:13:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
Message-Id: <20060806141310.607a6e40.rdunlap@xenotime.net>
In-Reply-To: <44D657BF.6070004@drzeus.cx>
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx>
	<20060806204842.GE16816@flint.arm.linux.org.uk>
	<44D657BF.6070004@drzeus.cx>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Aug 2006 22:57:35 +0200 Pierre Ossman wrote:

> Russell King wrote:
> > On Sun, Aug 06, 2006 at 10:22:23PM +0200, Pierre Ossman wrote:
> >> There were some confusion about base I/O variables in the wbsd driver.
> >> Seems like things have been working on shear luck so far. The global 'io'
> >> variable (used when manually configuring the resources) was used instead of
> >> the local 'base' variable.
> > 
> > Applied, thanks.
> > 
> > Shouldn't "base" be something other than "int" (eg, unsigned long) ?
> 
> unsigned short would probably be the right<tm> thing as the resource is
> 16 bits. I haven't seen it as big enough issue to warrant a patch.

and why not <resource_size_t> ?

> > Also, wbsd_init() takes base, irq, dma but passes wbsd_request_resources
> > io, irq and dma?  I suspect more fixes are on their way... 8)
> 
> *sigh*
> 
> And I thought this brown paper bag was just temporary...


---
~Randy
