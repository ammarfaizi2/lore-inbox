Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312305AbSCYFx6>; Mon, 25 Mar 2002 00:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312306AbSCYFxs>; Mon, 25 Mar 2002 00:53:48 -0500
Received: from [202.135.142.194] ([202.135.142.194]:27142 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312305AbSCYFxd>; Mon, 25 Mar 2002 00:53:33 -0500
Date: Mon, 25 Mar 2002 16:56:05 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] smaller kernels
Message-Id: <20020325165605.7d9c1d6e.rusty@rustcorp.com.au>
In-Reply-To: <3C982824.60091B4A@zip.com.au>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002 22:11:48 -0800
Andrew Morton <akpm@zip.com.au> wrote:

> This is the result of a search-and-destroy mission against
> oft-repeated strings in the kernel text.  These come about
> due to the toolchain's inability to common up strings between
> compilation units.

The name is horrible.  BUG() stands out: perhaps "BUG_LITE()"?

And I'm not sure DaveM'll appreciate this:

>  static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
>  {
>  	skb->len-=len;
> -	if (skb->len < skb->data_len)
> -		BUG();
>  	return 	skb->data+=len;
>  }

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
