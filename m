Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVKUWNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVKUWNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVKUWNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:13:06 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:58628 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751137AbVKUWND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:13:03 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ricknu-0@student.ltu.se (Richard Knutsson)
Subject: Re: [PATCH -mm2] net: Fix compiler-error on dgrs.c when !CONFIG_PCI
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, jgarzik@pobox.com, ashutosh.naik@gmail.com
Organization: Core
In-Reply-To: <43824066.4080109@student.ltu.se>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EeJu8-0006vr-00@gondolin.me.apana.org.au>
Date: Tue, 22 Nov 2005 09:12:52 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>
> We need it even if pci_register_driver() and pci_register_driver() is 
> empty shells. And instead of removing #endif CONFIG_PCI for 

I don't think so.  Please see my previous patch where pci_register_driver
is not called at all if CONFIG_PCI is not defined.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
