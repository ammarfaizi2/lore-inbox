Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUCKU7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUCKU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:59:06 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:4171 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261728AbUCKU7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:59:02 -0500
Subject: Re: 2.6.4-mm1
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040311104650.009a8d3e.akpm@osdl.org>
References: <20040310233140.3ce99610.akpm@osdl.org>
	 <1079024816.5325.2.camel@redeeman.linux.dk>
	 <200403111453.20866.norberto+linux-kernel@bensa.ath.cx>
	 <20040311100957.00dd6e7f.akpm@osdl.org>
	 <1079028899.5327.4.camel@redeeman.linux.dk>
	 <20040311104650.009a8d3e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079038721.5333.8.camel@redeeman.linux.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 21:58:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gonna try now, already compiling... i will come back with details in a
few minutes..

On Thu, 2004-03-11 at 19:46, Andrew Morton wrote:
> Redeeman <lkml@metanurb.dk> wrote:
> >
> >  i didnt do anything more than patch with mm1, is there a patch for doing
> >  that spin_unlock_irq()? :)
> 
> --- 25/fs/mpage.c~a	2004-03-11 10:46:29.000000000 -0800
> +++ 25-akpm/fs/mpage.c	2004-03-11 10:46:31.000000000 -0800
> @@ -672,7 +672,6 @@ mpage_writepages(struct address_space *m
>  		}
>  		pagevec_release(&pvec);
>  	}
> -	spin_unlock_irq(&mapping->tree_lock);
>  	if (bio)
>  		mpage_bio_submit(WRITE, bio);
>  	return ret;
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Regards, Redeeman
redeeman@metanurb.dk

