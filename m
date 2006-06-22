Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWFVQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWFVQTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWFVQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:19:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030301AbWFVQTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:19:06 -0400
Date: Thu, 22 Jun 2006 09:18:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       alesan@manoweb.com, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <1150976158.15275.148.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI> 
 <20060622001104.9e42fc54.akpm@osdl.org> <1150976158.15275.148.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Alan Cox wrote:
>
> Ar Iau, 2006-06-22 am 00:11 -0700, ysgrifennodd Andrew Morton:
> > There is something bad happening in there.  Presumably, this patch will
> > break the ThinkPad 600x series machines again though.
> > 
> 
> Possibly not - remember Linus fixed the "hidden resources" problem with
> the PIIX bridge chips.

Right. The IBM thinkpad probably works (well, at least _that_ one: 
there's tons of different Thinkpads, they have different cardbus 
controllers, and at least one of them has some other problem).

However, changing the IO window size just hides the problem on the machine 
that breaks this time around, and we should really fix _that_, rather than 
hide it (because otherwise it will break again when we do something else 
unrelated that just happens to change the order we do things in).

		Linus
