Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVH3VP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVH3VP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVH3VP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:15:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22217 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932258AbVH3VPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:15:25 -0400
Subject: Re: [PATCH] crypto_free_tfm callers do not need to check for NULL
From: Sridhar Samudrala <sri@us.ibm.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@mail.ru>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       "David S. Miller" <davem@davemloft.net>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Andy Adamson <andros@citi.umich.edu>, netdev@vger.kernel.org,
       lksctp developers <lksctp-developers@lists.sourceforge.net>,
       Bruce Fields <bfields@umich.edu>, Andy Adamson <andros@umich.edu>,
       linux-net@vger.kernel.org, linux-crypto@vger.kernel.org
In-Reply-To: <200508302245.55392.jesper.juhl@gmail.com>
References: <200508302245.55392.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 14:13:35 -0700
Message-Id: <1125436415.3952.11.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 22:45 +0200, Jesper Juhl wrote:
> Since the patch to add a NULL short-circuit to crypto_free_tfm() went in, 
> there's no longer any need for callers of that function to check for NULL.
> This patch removes the redundant NULL checks and also a few similar checks
> for NULL before calls to kfree() that I ran into while doing the 
> crypto_free_tfm bits.
> 
> I've posted similar patches in the past, but was asked to first until the
> short-circuit patch moved from -mm to mainline - and since it is now 
> firmly there in 2.6.13 I assume there's no problem there anymore.
> I was also asked previously to make the patch against mainline and not -mm,
> so this patch is against 2.6.13.
> 
> Feedback, ACK, NACK, etc welcome. 

sctp change looks fine.
A similar check in sctp_endpoint_destroy() can also be removed.

Thanks
Sridhar

