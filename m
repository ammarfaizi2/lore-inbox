Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUJKVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUJKVfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUJKVfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:35:51 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:30219 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S269266AbUJKVfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:35:37 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: stsp@aknet.ru (Stas Sergeev)
Subject: Re: [patch] allow write() on SOCK_PACKET sockets
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Organization: Core
In-Reply-To: <416AC048.6040805@aknet.ru>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CH7o3-0004M4-00@gondolin.me.apana.org.au>
Date: Tue, 12 Oct 2004 07:34:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
> 
> Unless I am really missing something, there
> seem to be no reason why the SOCK_PACKET code
> does not allow to use write() or send() when
> the socket was bound, and insists on using
> sendto(). SOCK_RAW code, in comparison, allows
> write() after bind().

It is counter-intuitive to allow write after bind().  AFAIK RAW
only allows write after connect(), not bind().

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
