Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVHEKdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVHEKdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVHEKdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:33:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37277 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262961AbVHEKc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:32:57 -0400
Date: Fri, 5 Aug 2005 12:32:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
In-Reply-To: <1123236831.3239.55.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0508051225270.3743@scrub.home>
References: <1123219747.20398.1.camel@localhost>  <20050804223842.2b3abeee.akpm@osdl.org>
  <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI> 
 <20050804233634.1406e92a.akpm@osdl.org>  <Pine.LNX.4.61.0508051132540.3743@scrub.home>
  <1123235219.3239.46.camel@laptopd505.fenrus.org>  <Pine.LNX.4.61.0508051202520.3728@scrub.home>
 <1123236831.3239.55.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Aug 2005, Arjan van de Ven wrote:

> > This would imply a similiar kmalloc() would be useful as well.
> > Second, how relevant is it for the kernel? 
> 
> we've had a non-negliable amount of security holes because of this

So why don't we have a similiar kmalloc()?

> > Is that really the best place 
> > to check for rogue user parameters?
> 
> it makes it easy and safe. Of course you can and should check it in all
> users. Just that using a safer API is generally better than forcing
> everyone to do it themselves.

How exactly does this make it a "safe API"? Even if it checks for this one 
case, it still makes the user suspectible for allocating big amounts of 
unswappable memory.

bye, Roman
