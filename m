Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWFVQgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWFVQgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWFVQgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:36:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030643AbWFVQgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:36:39 -0400
Date: Thu, 22 Jun 2006 09:36:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, penberg@cs.Helsinki.FI, alesan@manoweb.com,
       linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru,
       dtor_core@ameritech.net
Subject: Re: [PATCH] cardbus: revert IO window limit
Message-Id: <20060622093606.2b3b1eb7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
	<20060622001104.9e42fc54.akpm@osdl.org>
	<1150976158.15275.148.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220917080.5498@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:18:41 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 22 Jun 2006, Alan Cox wrote:
> >
> > Ar Iau, 2006-06-22 am 00:11 -0700, ysgrifennodd Andrew Morton:
> > > There is something bad happening in there.  Presumably, this patch will
> > > break the ThinkPad 600x series machines again though.
> > > 
> > 
> > Possibly not - remember Linus fixed the "hidden resources" problem with
> > the PIIX bridge chips.
> 
> Right. The IBM thinkpad probably works (well, at least _that_ one: 
> there's tons of different Thinkpads, they have different cardbus 
> controllers, and at least one of them has some other problem).
> 
> However, changing the IO window size just hides the problem on the machine 
> that breaks this time around, and we should really fix _that_, rather than 
> hide it (because otherwise it will break again when we do something else 
> unrelated that just happens to change the order we do things in).
> 

OK, thanks.  All we have on Alessio's machine is "freezes at boot if APM is enabled"
(http://lkml.org/lkml/2006/6/16/33).  Any suggestions as to how to proceed
with that?


