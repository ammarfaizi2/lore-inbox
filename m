Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSLGKur>; Sat, 7 Dec 2002 05:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbSLGKur>; Sat, 7 Dec 2002 05:50:47 -0500
Received: from dp.samba.org ([66.70.73.150]:37257 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262314AbSLGKuo>;
	Sat, 7 Dec 2002 05:50:44 -0500
Date: Sat, 7 Dec 2002 20:56:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021207095626.GC22230@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212060714.XAA06006@adam.yggdrasil.com> <200212061626.gB6GQvl01748@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212061626.gB6GQvl01748@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 10:26:57AM -0600, James Bottomley wrote:
> adam@yggdrasil.com said:
> > 	I like your term DMA_CONSISTENT better than DMA_CONFORMANCE_CONSISTANT
> > .  I think the word "conformance" in there does not reduce the time
> > that it takes to figure out what the symbol means.  I don't think any
> > other facility will want to use the terms DMA_{,IN}CONSISTENT, so I
> > prefer that we go with the more medium sized symbol. 
> 
> I'm not so keen on this.  The idea of this parameter is not to tell
> the allocation routine what type of memory you would like, but to
> tell it what type of memory the driver can cope with.  I think for
> the inconsistent case, DMA_INCONSISTENT looks like the driver is
> requiring inconsistent memory, and expecting to get it.  I'm open to
> changing the "CONFORMANCE" part, but I'd like to name these
> parameters something that doesn't imply they're requesting a type of
> memory.

Well, actually I was thinking of the flags as a bitmask, not an enum,
so I was assuming (flags==0) for not-neccessarily-consistent memory.
However, since having seen davem's comments, I agree with him that
separate entry points is probably a better idea for API sanity.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
