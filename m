Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312859AbSCYX2K>; Mon, 25 Mar 2002 18:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312878AbSCYX2A>; Mon, 25 Mar 2002 18:28:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:31243 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312859AbSCYX1v>; Mon, 25 Mar 2002 18:27:51 -0500
Date: Mon, 25 Mar 2002 19:22:31 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] smaller kernels
In-Reply-To: <20020325165605.7d9c1d6e.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.21.0203251921570.3378-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Mar 2002, Rusty Russell wrote:

> On Tue, 19 Mar 2002 22:11:48 -0800
> Andrew Morton <akpm@zip.com.au> wrote:
> 
> > This is the result of a search-and-destroy mission against
> > oft-repeated strings in the kernel text.  These come about
> > due to the toolchain's inability to common up strings between
> > compilation units.
> 
> The name is horrible.  BUG() stands out: perhaps "BUG_LITE()"?
> 
> And I'm not sure DaveM'll appreciate this:
> 
> >  static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
> >  {
> >  	skb->len-=len;
> > -	if (skb->len < skb->data_len)
> > -		BUG();
> >  	return 	skb->data+=len;
> >  }

Andrew, 

I've just readded all asserts which you removed... if you really want to
remove any of those, please prove me that they are useless.

