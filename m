Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVCTJkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVCTJkb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 04:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVCTJka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 04:40:30 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:10501 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262051AbVCTJk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 04:40:26 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: adobriyan@mail.ru (Alexey Dobriyan)
Subject: Re: [patch 1/4] crypto/sha256.c: fix sparse warnings
Cc: herbert@gondor.apana.org.au, domen@coderock.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200503201110.39174.adobriyan@mail.ru>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DCwuN-000473-00@gondolin.me.apana.org.au>
Date: Sun, 20 Mar 2005 20:39:43 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@mail.ru> wrote:
> 
> crypto/sha256.c:61:9: warning: cast to restricted type
> 
> Use CHECK="sparse -Wbitwise" to see it.

Thanks.  I've applied all four patches to crypto.  I changed patch 4/4
slightly so that it reads

+#define u32_in(x) le32_to_cpu(*(const __le32 *)(x))

instead of le32_to_cpup(...) for the sake of minimising the changes.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
