Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUFJUJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUFJUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUFJUJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:09:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41677 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262951AbUFJUJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:09:28 -0400
Date: Thu, 10 Jun 2004 22:08:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pavel Machek <pavel@ucw.cz>, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040610200824.GH4507@openzaurus.ucw.cz>
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610105629.GA367@gondor.apana.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -803,32 +804,31 @@
> >  		return 0;
> >  	}
> >  
> > +	err = -ENOMEM;
> >  	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
> >  		memset(m, 0, PAGE_SIZE);
> 
> BTW, what does this memset do?

Someone (me?) was trying to be carefull, and was not carefull enough.
AFAICS it should be memset(..., PAGE_SIZE << pagedir_order)
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

