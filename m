Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVDCM12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVDCM12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVDCM12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:27:28 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:39180 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261711AbVDCM1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:27:25 -0400
Date: Sun, 3 Apr 2005 22:26:47 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: linville@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Oops in set_spdif_output in i810_audio
Message-ID: <20050403122647.GA21757@gondor.apana.org.au>
References: <20050402162840.29a65623.akpm@osdl.org> <20050403121427.GC21388@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403121427.GC21388@gondor.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 10:14:27PM +1000, herbert wrote:
> 
> I personally don't see a reason why we should allow it to
> continue when the codec doesn't exist.  What do you guys think?

Actually, anybody trying to use this driver without a codec
would've hit the same crash.  Since nobody has complained
before, we should just fail the registration if there is
no codec.

Then we can get rid of all the existing codec != NULL checks.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
