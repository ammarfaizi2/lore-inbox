Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270553AbRHITBo>; Thu, 9 Aug 2001 15:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270554AbRHITBg>; Thu, 9 Aug 2001 15:01:36 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:26249 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S270553AbRHITBT>;
	Thu, 9 Aug 2001 15:01:19 -0400
Message-Id: <m15UkT9-000PT6C@amadeus.home.nl>
Date: Thu, 9 Aug 2001 08:43:03 +0100 (BST)
From: arjan@fenrus.demon.nl
To: kaos@ocs.com.au (Keith Owens)
Subject: Re: Duplicate symbols in -ac JFFS2
cc: linux-kernel@vger.kernel.org
In-Reply-To: <6361.997313081@ocs3.ocs-net>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <6361.997313081@ocs3.ocs-net> you wrote:
> In 2.4.7-ac9, if both ppp deflate and JFFS2 are built into the kernel,
> there are lots of duplicate symbols.

> drivers/net/ppp_deflate.o(.data+0x0): multiple definition of `deflate_copyright'
> fs/jffs2/jffs2.o(.data+0x20): first defined here
> drivers/net/ppp_deflate.o: In function `deflateInit_':
> drivers/net/ppp_deflate.o(.text+0x0): multiple definition of `deflateInit_'
> ...

> What happened to the idea of puttting the deflate code in its own
> object with exported symbols, instead of duplicating it in each
> directory?

Well the PPP one is different due to RFC-ishness...
The rest could be merged most likely.
