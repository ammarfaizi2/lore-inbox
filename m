Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVJPL4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVJPL4D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 07:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJPL4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 07:56:02 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:54278 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751209AbVJPL4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 07:56:00 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: engler@csl.stanford.edu
Subject: Re: [CHECKER] buffer overflows in net/core/filter.c?
Cc: linux-kernel@vger.kernel.org, engler@cs.stanford.edu, jschlst@samba.org,
       mc@cs.stanford.edu, kaber@trash.net
Organization: Core
In-Reply-To: <200510160936.j9G9aMrb009564@csl.stanford.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1ER77E-0002N0-00@gondolin.me.apana.org.au>
Date: Sun, 16 Oct 2005 21:55:48 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.stanford.edu> wrote:
> 
> But then blow up severely after calling:
> 
> static inline void *skb_header_pointer(const struct sk_buff *skb, int offset,
>                                       int len, void *buffer)
> {
>        int hlen = skb_headlen(skb);
> 
> 
> which increments the data pointer:
> 
>        if (offset + len <= hlen)
>                return skb->data + offset;

This check was fixed 3 months ago with the changeset:

55820ee2f8c767a2833b21bd365e5753f50bd8ce

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
