Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWEPHoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWEPHoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 03:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWEPHoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 03:44:32 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:62225 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751606AbWEPHob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 03:44:31 -0400
Date: Tue, 16 May 2006 17:44:24 +1000
To: Joachim Fritschi <jfritschi@freenet.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] Twofish cipher i586-asm optimized
Message-ID: <20060516074424.GA17773@gondor.apana.org.au>
References: <200605071156.57844.jfritschi@freenet.de> <200605072247.46655.jfritschi@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605072247.46655.jfritschi@freenet.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 08:47:46PM +0000, Joachim Fritschi wrote:
> After going over my patch again, i realized i missed the .cra_priority 
> and .cra_driver_name setting in the crypto api struct. Here is an updated 
> version of my patch:
> 
> http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-i586-asm-2.6.17-2.diff 

Thanks for doing this Joachim.  I like the result.

But the duplicate key code is a bit too much.  The fact that AES does
it should only serve as a reminder for us to fix it, not to create even
more duplication.

So could you please move the key generation code into a separate file,
say crypto/twofish-common.c which can then be shared by all twofish
implementations?

BTW, please include the actual patches the next time you submit them
along with Signed-off-by lines.  You should consult the file
Documentation/SubmittingPatches for detailed instructions.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
