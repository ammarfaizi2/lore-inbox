Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUCJEU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 23:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCJEU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 23:20:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32414 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261935AbUCJEUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 23:20:25 -0500
Date: Tue, 9 Mar 2004 23:21:03 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jouni Malinen <jkmaline@cc.hut.fi>
cc: Clay Haapala <chaapala@cisco.com>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <20040310034014.GA3739@jm.kir.nu>
Message-ID: <Xine.LNX.4.44.0403092318370.29034-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Jouni Malinen wrote:

> +static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
> +{
> +	u32 flags;
> +	if (tfm->__crt_alg->cra_digest.dia_setkey == NULL)
> +		return -1;

In both patches, these 'return -1' statements should be -EINVAL, or 
whatever is appropriate (probably -ENOSYS for this one).


- James
-- 
James Morris
<jmorris@redhat.com>


