Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSLHFWn>; Sun, 8 Dec 2002 00:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSLHFWn>; Sun, 8 Dec 2002 00:22:43 -0500
Received: from dp.samba.org ([66.70.73.150]:17067 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265196AbSLHFWm>;
	Sun, 8 Dec 2002 00:22:42 -0500
Date: Sun, 8 Dec 2002 16:28:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Adam J. Richter" <adam@yggdrasil.com>, James.Bottomley@steeleye.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021208052843.GA30968@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, James.Bottomley@steeleye.com,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212060714.XAA06006@adam.yggdrasil.com> <20021207094530.GB22230@zax.zax> <20021207112657.A18207@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207112657.A18207@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 11:26:57AM +0000, Russell King wrote:
> On Sat, Dec 07, 2002 at 08:45:30PM +1100, David Gibson wrote:
> > Actually, no, since my idea was to remove the "consistent_alloc()"
> > path from the driver entirely - leaving only the map/sync approach.
> > That gives a result which is correct everywhere (afaict) but (as
> > you've since pointed out) will perform poorly on platforms where the
> > map/sync operations are expensive.
> 
> As I've also pointed out in the past couple of days, doing this will
> mean that you then need to teach the drivers to align structures to
> cache line boundaries.  Otherwise, you _will_ get into a situation
> where you _will_ loose data.

Sure, but that's already an issue with the current streaming DMA API.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
