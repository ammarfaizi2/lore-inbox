Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbTHJOqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269555AbTHJOqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:46:18 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:50700 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S269523AbTHJOqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:46:17 -0400
Date: Mon, 11 Aug 2003 00:46:01 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: Matt Mackall <mpm@selenic.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
In-Reply-To: <20030809131715.17a5be2e.davem@redhat.com>
Message-ID: <Mutt.LNX.4.44.0308110035090.7218-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, David S. Miller wrote:

> > Also, I posted to cryptoapi-devel that I need a way to disable the
> > unconditional padding on the hash functions.
> 
> James, comments?

Yes, a flag could be added for crypto_alloc_tfm() which disables padding
for digests (e.g. CRYPTO_TFM_DIGEST_NOPAD).

Given that there are a still a number of unresolved issues, e.g. making
the crypto api (or a subset thereof) mandatory, perhaps it would be more 
appropriate to slate these changes for 2.7 and then backport to 2.6 once 
stable.


- James
-- 
James Morris
<jmorris@intercode.com.au>


