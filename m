Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313930AbSDPWhy>; Tue, 16 Apr 2002 18:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313932AbSDPWhx>; Tue, 16 Apr 2002 18:37:53 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:29193 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S313930AbSDPWhw>; Tue, 16 Apr 2002 18:37:52 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020416222156.GB20464@turbolinux.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.12-20020311 ("Toxicity") (UNIX) (Linux/2.4.18-686-smp (i686))
Message-Id: <E16xba3-0005tw-00@gondolin.me.apana.org.au>
Date: Wed, 17 Apr 2002 08:37:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:
> On Apr 16, 2002  23:34 +0200, bert hubert wrote:
>> 
>> Your uptime wraps to zero after 49 days. I think 'top' gets confused.

> Trivially fixed with the existing 64-bit jiffies patches.  As it is,
> your uptime wraps to zero after 472 days or something like that if you
> don't have the 64-bit jiffies patch, which is totally in the realm of
> possibility for Linux servers.

Why are we still measuring uptime using the tick variable? Ticks != time.
Surely we should be recording the boot time somewhere (probably on a
file system), and then comparing that with the current time?
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
