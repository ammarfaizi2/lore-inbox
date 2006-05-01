Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWEAVHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWEAVHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWEAVHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:07:44 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:5745 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751255AbWEAVHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:07:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=a1XDpY2+rLc2VY4WX1KY8VBvDH8inDfyS97vc9DlsjHNfuA7A54iXW/HCDhDbpkdBdVX3sXKoW44r+IrwtbacL4lcFAlnAwfyRfpm5ldc6UlvXu9XCkv3SE4dv6wsRVMF6wWmJ2I/ie/ivwiMdYigU0hy0g90OekQeH43pKuCDs=
Date: Tue, 2 May 2006 01:05:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Cc: Andrew Morton <akpm@osdl.org>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/bio.c: initialize variable, remove warning
Message-ID: <20060501210546.GB7170@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.64.0605012353100.5245@joo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605012353100.5245@joo>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 11:55:27PM +0300, Petri T. Koistinen wrote:
> Remove compiler warning by initializing uninitialized variable.

> --- a/fs/bio.c
> +++ b/fs/bio.c
> @@ -166,7 +166,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_m
> 
>  		bio_init(bio);
>  		if (likely(nr_iovecs)) {
> -			unsigned long idx;
> +			unsigned long idx = 0;

oh no not again!

