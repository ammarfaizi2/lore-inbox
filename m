Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVCTILV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVCTILV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 03:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVCTILV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 03:11:21 -0500
Received: from mx3.mail.ru ([194.67.23.23]:12816 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S262048AbVCTILS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 03:11:18 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [patch 1/4] crypto/sha256.c: fix sparse warnings
Date: Sun, 20 Mar 2005 11:10:39 +0300
User-Agent: KMail/1.7
Cc: domen@coderock.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <E1DCuuz-0003fC-00@gondolin.me.apana.org.au>
In-Reply-To: <E1DCuuz-0003fC-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503201110.39174.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 March 2005 10:32, Herbert Xu wrote:
> domen@coderock.org wrote:
> > +++ kj-domen/crypto/sha256.c

> > static inline void LOAD_OP(int I, u32 *W, const u8 *input)
> > {
> > -       W[I] = __be32_to_cpu( ((u32*)(input))[I] );
> > +       W[I] = __be32_to_cpu( ((__be32*)(input))[I] );
>
> I don't get any warnings here (sparse version dated 12/03/2005).
> What warnings are you getting exactly?

crypto/sha256.c:61:9: warning: cast to restricted type

Use CHECK="sparse -Wbitwise" to see it.

 Alexey
