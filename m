Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312310AbSCYGLT>; Mon, 25 Mar 2002 01:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312314AbSCYGLA>; Mon, 25 Mar 2002 01:11:00 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11539 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312310AbSCYGK5>; Mon, 25 Mar 2002 01:10:57 -0500
Message-ID: <3C9EBF13.4FEBB158@zip.com.au>
Date: Sun, 24 Mar 2002 22:09:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] smaller kernels
In-Reply-To: <3C982824.60091B4A@zip.com.au> <20020325165605.7d9c1d6e.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> On Tue, 19 Mar 2002 22:11:48 -0800
> Andrew Morton <akpm@zip.com.au> wrote:
> 
> > This is the result of a search-and-destroy mission against
> > oft-repeated strings in the kernel text.  These come about
> > due to the toolchain's inability to common up strings between
> > compilation units.
> 
> The name is horrible.  BUG() stands out: perhaps "BUG_LITE()"?

out_of_line_bug()? It's a bit ornate I guess, but it tells
you what it does when you look at it.

> And I'm not sure DaveM'll appreciate this:
> 
> >  static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
> >  {
> >       skb->len-=len;
> > -     if (skb->len < skb->data_len)
> > -             BUG();
> >       return  skb->data+=len;
> >  }

OK, we can out that back (out-of-line) for -pre6.

-
