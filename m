Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288117AbSA2Axl>; Mon, 28 Jan 2002 19:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSA2Axb>; Mon, 28 Jan 2002 19:53:31 -0500
Received: from [202.135.142.194] ([202.135.142.194]:16146 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288019AbSA2AxN>; Mon, 28 Jan 2002 19:53:13 -0500
Date: Tue, 29 Jan 2002 11:53:47 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
Message-Id: <20020129115347.197fa696.rusty@rustcorp.com.au>
In-Reply-To: <3C55282C.7D607CFB@zip.com.au>
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com>
	<Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com>
	<3C51FF0C.D3B1E2F7@zip.com.au>
	<3C51FF0C.D3B1E2F7@zip.com.au>
	<200201281018.g0SAIIE22462@Port.imtp.ilyichevsk.odessa.ua>
	<3C55282C.7D607CFB@zip.com.au>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002 02:30:04 -0800
Andrew Morton <akpm@zip.com.au> wrote:

> Denis Vlasenko wrote:
> > 
> > > <thinks of another>
> > >
> > >       s/inline//g
> > 
> > I like this.
> 
> Well, it's a fairly small optimisation, but it's easy.
> 
> I did a patch a while back:  http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/inline.patch
> This is purely against core kernel files:

You *really* want to do the headers, too.  As a hack you could move all the
inlines into kernel/inline.c, and see what happens then.

It's the headers that make it messy as a config option (you don't want
non-inline functions in your .h file, because having multiple copies loses
the cache advantatge.

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
