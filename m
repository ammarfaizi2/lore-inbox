Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVJFM6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVJFM6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 08:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVJFM57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 08:57:59 -0400
Received: from hera.kernel.org ([140.211.167.34]:16096 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750856AbVJFM57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 08:57:59 -0400
Date: Wed, 5 Oct 2005 18:35:40 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mundt <paul.mundt@nokia.com>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] mempool_alloc() pre-allocated object usage
Message-ID: <20051005213540.GA10123@logos.cnet>
References: <20051003143634.GA1702@nokia.com> <1128350953.17024.17.camel@laptopd505.fenrus.org> <20051003162122.GB1844@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003162122.GB1844@nokia.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Oct 03, 2005 at 07:21:22PM +0300, Paul Mundt wrote:
> On Mon, Oct 03, 2005 at 04:49:13PM +0200, Arjan van de Ven wrote:
> > On Mon, 2005-10-03 at 17:36 +0300, Paul Mundt wrote:
> > > Both usage patterns seem valid from my point of view, would you be open
> > > to something that would accomodate both? (ie, possibly adding in a flag
> > > to determine pre-allocated object usage?) Or should I not be using
> > > mempool for contiguity purposes?
> > 
> > a similar dillema was in the highmem bounce code in 2.4; what worked
> > really well back then was to do it both; eg use half the pool for
> > "immediate" use, then try a VM alloc, and use the second half of the
> > pool for the really emergency cases.
> > 
> Unfortunately this won't work very well in our case since it's
> specifically high order allocations that we are after, and we don't have
> the extra RAM to allow for this.

Out of curiosity, what is the requirement for higher order pages?

