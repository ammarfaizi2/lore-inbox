Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282630AbRKZXM6>; Mon, 26 Nov 2001 18:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282632AbRKZXMq>; Mon, 26 Nov 2001 18:12:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3590 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282630AbRKZXMd>; Mon, 26 Nov 2001 18:12:33 -0500
Date: Mon, 26 Nov 2001 15:06:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <3C02C6F2.71A581AB@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0111261505330.10731-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Jeff Garzik wrote:
>
> FWIW Al Viro pointed out to me yesterday that block_xxx are really
> nothing but helpers...  Depending on them doing or not doing certain
> things is IMHO ok...

They _are_ helpers, but I was actually _this_ close to removing the
kmap/kunmap from them a few weeks ago when we fixed the NFS uses of the
same. People should NOT depend on those kinds of subtle internal things.

		Linus

