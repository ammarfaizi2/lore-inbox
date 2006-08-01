Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWHAXc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHAXc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWHAXc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:32:28 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:24337 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750727AbWHAXc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:32:28 -0400
Date: Wed, 2 Aug 2006 09:32:21 +1000
To: Jens Axboe <axboe@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060801233221.GA11913@gondor.apana.org.au>
References: <20060801072315.GH31908@suse.de> <E1G83hL-00035h-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1G83hL-00035h-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 09:30:51AM +1000, Herbert Xu wrote:
> 
> OK, I used a WARN_ON mainly because ext3 has been doing this for years
> without killing anyone until now :)
> 
> [BLOCK] bh: Ensure bh fits within a page

Actually, the other reason is that we can't BUG_ON until ext3 is fixed
to not do this.  So I suppose we should keep the WARN_ON until that
happens.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
