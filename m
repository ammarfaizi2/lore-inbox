Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSJWQmT>; Wed, 23 Oct 2002 12:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSJWQmT>; Wed, 23 Oct 2002 12:42:19 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:42204 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262646AbSJWQmS>;
	Wed, 23 Oct 2002 12:42:18 -0400
Date: Wed, 23 Oct 2002 09:48:08 -0700
To: Slavcho Nikolov <snikolov@okena.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: feature request - why not make netif_rx() a pointer?
Message-ID: <20021023164808.GG24123@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021023003959.GA23155@bougret.hpl.hp.com> <004c01c27a99$927b8a30$800a140a@SLNW2K>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004c01c27a99$927b8a30$800a140a@SLNW2K>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 09:39:12AM -0400, Slavcho Nikolov wrote:
> Unfortunately, I cannot assume that every L2 (or maybe I can, we'll see) is
> ethernet and I definitely cannot know in advance that every L3 is IP.
> Nor can the assumption be made that netfilter has been built into the
> kernel.

	So, you thing assuming a modified netif_rx is different than
assuming netfilter support ?
	Your idea is just too dangerous.

> If I define my own private protocol handler (to catch all), I see cloned
> skb's
> which is not what I want. I tried that and dropped each one of them in the
> handler, yet traffic continued to flow unimpeded (so I must have dropped
> clones).

	For this to work, you need to modify the driver. The driver
generates a private packet type or protocol, and you will be the only
to to catch it.

> As for GPL, I hope that commercial enterprises be allowed to utilize
> business models
> which do not necessarily consist in providing services around free software.
> The more replaceable hooks you provide to filesystems and network stacks,
> the better.

	You can still use *BSD, Windows, VxWorks or else, which are
very capable OSes. Nobody forces you to use Linux.

> S.N.

	Jean
