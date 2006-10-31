Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422857AbWJaIVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbWJaIVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422862AbWJaIVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:21:31 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:23816 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1422857AbWJaIVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:21:31 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: rtcvb32@yahoo.com
Subject: Re: [PATCH 2.6.18] crypto/api:  optional cleanup functionalitiy
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20061031021655.20510.qmail@web55412.mail.re4.yahoo.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1Geos1-0007jr-00@gondolin.me.apana.org.au>
Date: Tue, 31 Oct 2006 19:21:17 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Era Scarecrow <rtcvb32@yahoo.com> wrote:
> From: Ryan Cecil <rtcvb32@coffey.com>
> 
> Adds the function call cleanup to all crypto/cipher/digest calls. Certain
> select ciphers require a larger dynamic memory allocation, which isn't cleaned
> when closed. The cleanup code will be called to clean those up before being
> released.
> 
> Signed-off-by: Ryan Cecil <rtcvb32@coffey.com>

We have the cra_exit hook which already does this.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
