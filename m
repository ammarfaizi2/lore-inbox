Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVHEKla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVHEKla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVHEKlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:41:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58524 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262962AbVHEKjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:39:08 -0400
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
From: Arjan van de Ven <arjan@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
In-Reply-To: <Pine.LNX.4.61.0508051225270.3743@scrub.home>
References: <1123219747.20398.1.camel@localhost>
	 <20050804223842.2b3abeee.akpm@osdl.org>
	 <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
	 <20050804233634.1406e92a.akpm@osdl.org>
	 <Pine.LNX.4.61.0508051132540.3743@scrub.home>
	 <1123235219.3239.46.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051202520.3728@scrub.home>
	 <1123236831.3239.55.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051225270.3743@scrub.home>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 12:38:09 +0200
Message-Id: <1123238289.3239.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 12:32 +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 5 Aug 2005, Arjan van de Ven wrote:
> 
> > > This would imply a similiar kmalloc() would be useful as well.
> > > Second, how relevant is it for the kernel? 
> > 
> > we've had a non-negliable amount of security holes because of this
> 
> So why don't we have a similiar kmalloc()?

nope kmalloc is not an array allocator
> 
> > > Is that really the best place 
> > > to check for rogue user parameters?
> > 
> > it makes it easy and safe. Of course you can and should check it in all
> > users. Just that using a safer API is generally better than forcing
> > everyone to do it themselves.
> 
> How exactly does this make it a "safe API"? Even if it checks for this one 
> case, it still makes the user suspectible for allocating big amounts of 
> unswappable memory.

128Kb max.


