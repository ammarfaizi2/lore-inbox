Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290098AbSAKUhq>; Fri, 11 Jan 2002 15:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290107AbSAKUhh>; Fri, 11 Jan 2002 15:37:37 -0500
Received: from [195.66.192.167] ([195.66.192.167]:9478 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S290098AbSAKUhQ>; Fri, 11 Jan 2002 15:37:16 -0500
Message-Id: <200201112035.g0BKZSE24843@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Linus Torvalds <torvalds@transmeta.com>,
        Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
Date: Fri, 11 Jan 2002 22:35:29 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0201111038170.3952-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201111038170.3952-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 January 2002 16:40, Linus Torvalds wrote:
> I'll apply it to the 2.5.x tree - it's not as if it can hurt anything (it
> will actually generate better code, as a signed divide is slightly more
> complex than just a shift due to rounding issues, and gcc doesn't know
> that the inode length will always be non-negative).
>
> Whether it is worth working around in 2.4.x I don't have any real opinion
> on, but I doubt it is worthwhile to compile 2.4.x with gcc-3.0.x anyway.
> But again, applying it won't hurt.

I don't consider kernel compilation as a developer-only activity:
we certainly don't expect Aunt Tillie to compile kernels, but it's expected 
almost every server admin will want/need to do it.

Keeping two versions of GCC (one for 2.4 kernel, other for everyday use) is 
something I don't like. Imagine what we will have around New Year 2003: 2.5 
is still devel, 2.4 is stable, GCC 3.1+ is out and stable. Most people will 
be glad to have 2.4 compilable by GCC 3.1 IMHO.

The fact that kernels compiled with GCC 3 are _bigger_ than ones compiled 
with 2.96 is really annoys me. Will keep an eye on this as GCC 3 stabilize...
--
vda
