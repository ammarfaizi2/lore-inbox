Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUFJK4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUFJK4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 06:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUFJK4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 06:56:42 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:36624 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261752AbUFJK4l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 06:56:41 -0400
Date: Thu, 10 Jun 2004 20:56:29 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040610105629.GA367@gondor.apana.org.au>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 08:50:12PM +1000, Herbert Xu wrote:
>
> @@ -803,32 +804,31 @@
>  		return 0;
>  	}
>  
> +	err = -ENOMEM;
>  	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
>  		memset(m, 0, PAGE_SIZE);

BTW, what does this memset do?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
