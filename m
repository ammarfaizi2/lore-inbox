Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWDFXY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWDFXY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWDFXY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:24:58 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:24845 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932213AbWDFXY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:24:58 -0400
Date: Fri, 7 Apr 2006 09:24:54 +1000
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: add alignment handling to digest layer
Message-ID: <20060406232454.GA27623@gondor.apana.org.au>
References: <20060309.123608.08076793.nemoto@toshiba-tops.co.jp> <20060404.000407.41198995.anemo@mba.ocn.ne.jp> <20060405180520.GA15151@gondor.apana.org.au> <20060406.113742.15248428.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406.113742.15248428.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 11:37:42AM +0900, Atsushi Nemoto wrote:
> 
> We don't.  I think update functions do not need an aligned buffer for
> data which is smaller then the alignment size.

You're right.  If we do ever get any hardware that requires this we can
always change it later on.

Another thing, could you pleas change the stack allocation in final so
that it does it like cbc_process_decrypt? The reason is that gcc is too
stupid to not allocate that buffer unconditionally.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
