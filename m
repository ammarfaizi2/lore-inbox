Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTKDJDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTKDJDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:03:40 -0500
Received: from c211-30-229-77.rivrw4.nsw.optusnet.com.au ([211.30.229.77]:10244
	"EHLO arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264009AbTKDJDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:03:35 -0500
Date: Tue, 4 Nov 2003 20:03:25 +1100
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031104090325.GA21301@gondor.apana.org.au>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de> <20031103205234.GA17570@gondor.apana.org.au> <20031104084929.GH1477@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031104084929.GH1477@suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 09:49:30AM +0100, Jens Axboe wrote:
> 
> That could work, but it breaks the rule that counts are always accurate.

Yes, it means that recount may return a higher value but it is never
lower.

I think it should be safe though as recount is not always called (it is
only called if the phys/hw segments exceed the limits).  In the cases
where it is not called you may be looking at an overestimate anyway.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
