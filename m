Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVKMAaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVKMAaL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVKMAaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 19:30:11 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:43021 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964896AbVKMAaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 19:30:09 -0500
Date: Sun, 13 Nov 2005 11:29:45 +1100
To: Nicolas Pitre <nico@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 2/5] crypto/sha1.c: avoid shifting count left and right
Message-ID: <20051113002945.GB22130@gondor.apana.org.au>
References: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain> <Pine.LNX.4.64.0510241356270.5288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510241356270.5288@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 05:57:06PM +0000, Nicolas Pitre wrote:
> 
> This patch avoids shifting the count left and right needlessly for each
> call to sha1_update().  It instead can be done only once at the end in
> sha1_final().
> 
> Keeping the previous test example (sha1_update() successively called with
> len=64), a 1.3% performance increase can be observed on i386, or 0.2% on
> ARM.  The generated code is also smaller on ARM.

Patch applied.

So in summary, patch 1 has been applied with some additional changes.
Patch 2 is applied as is except for a change to accomodate the cpu->be
change from Denis.

Patches 3-5 have been made redundant by the cpu->be change.

Thanks again for your efforts in making sha1 smaller and faster.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
