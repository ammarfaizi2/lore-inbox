Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbSL3S2s>; Mon, 30 Dec 2002 13:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSL3S2s>; Mon, 30 Dec 2002 13:28:48 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:31503 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267034AbSL3S2r>; Mon, 30 Dec 2002 13:28:47 -0500
Date: Mon, 30 Dec 2002 18:37:07 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 fix link with fbcon built-in
In-Reply-To: <1041244796.4330.14.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0212301836540.2784-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In current bk 2.5, drivers/video/console/fonts.c exports an
> init_module() symbol when built-in, which prevents the kernel from
> linking. Here's a quick fix.
> 
> Ben.
> 
> --- 1.10/drivers/video/console/fonts.c  Fri Nov 29 18:37:57 2002
> +++ edited/drivers/video/console/fonts.c        Mon Dec 30 11:36:42 2002
> @@ -130,8 +130,10 @@
>      return g;
>  }
>   
> +#ifdef MODULE
>  int init_module(void) { return 0; };
>  void cleanup_module(void) {};
> +#endif
>   
>  EXPORT_SYMBOL(fonts);
>  EXPORT_SYMBOL(find_font);

Applied to BK tree. 

