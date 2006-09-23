Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWIWUMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWIWUMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWIWUMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:12:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14529
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964788AbWIWUMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:12:54 -0400
Date: Sat, 23 Sep 2006 13:12:52 -0700 (PDT)
Message-Id: <20060923.131252.74747591.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]: Fix ALIGN() macro
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060923144041.GA3540@gondor.apana.org.au>
References: <20060923124633.GA2567@gondor.apana.org.au>
	<20060923125458.GA2682@gondor.apana.org.au>
	<20060923144041.GA3540@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 24 Sep 2006 00:40:41 +1000

> OK I think I've found the problem.
> 
> [CRYPTO] hmac: Fix hmac_init update call
> 
> The crypto_hash_update call in hmac_init gave the number 1
> instead of the length of the sg list in bytes.  This is a
> missed conversion from the digest => hash change.
> 
> As tcrypt only tests crypto_hash_digest it didn't catch this.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This, along with the ALIGN() patch, fixes all the regressions
for me.  Good spotting Herbert!

Linus, please apply.
