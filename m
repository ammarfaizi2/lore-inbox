Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVI1Vid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVI1Vid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVI1Vid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:38:33 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:3465 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750974AbVI1Vic convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:38:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JwT6F6UGzp3oK4lUs9UBU2Gcd1/l87PSEIqI0FzN70HyyZM07WrLBu+SFVcWCZlnbJIyqqdRWl/YBD7svdXOFzD5Fc56vlb1RmsG2tuO7kSGNwyo5wQ2BxdCJR9cZFiMW/q53VVFQ8OEgOTXEVUsehXHs8dk4hmBKmTiUND3SnA=
Message-ID: <9a87484905092814384a16d167@mail.gmail.com>
Date: Wed, 28 Sep 2005 23:38:31 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: [RFC][PATCH] inline a few tiny functions in init/initramfs.c
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <2cd57c90050927200118eb9ade@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509240126.26575.jesper.juhl@gmail.com>
	 <200509241415.43773.kernel@kolivas.org>
	 <4334DB96.3040904@yahoo.com.au>
	 <9a87484905092717074e85657e@mail.gmail.com>
	 <1127872565.5210.4.camel@npiggin-nld.site>
	 <2cd57c90050927200118eb9ade@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> On 9/28/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > On Wed, 2005-09-28 at 02:07 +0200, Jesper Juhl wrote:
> >
> > > Ok, so it seems that there's agreement that the other two inlines in
> > > the patch makes sense, but the malloc() is not clear cut.
> > >
> > > Since this is in initramfs after all it doesn't make that big a
> > > difference overall, so I'll just send in a patch that inlines the
> > > other two functions but leaves malloc() alone.
> > >
> >
> > Well, they're not particularly performance critical, and everything
> > is marked init anyway so I don't know why you would bother changing
> > anything ;)
> >
>
> Don't you feel "static inline void __init " stupid? (inline + __init)
> Anyway don't do things like that manually. Leave the optimization job
> to gcc.

Hmm, I guess you are right. They just looked like so obvious
candidates for inlining, __init or no __init, but I guess it doesn't
matter - I'll find better things to spend my time on.
Thanks.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
