Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316099AbSEJUBD>; Fri, 10 May 2002 16:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316101AbSEJUBC>; Fri, 10 May 2002 16:01:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14603 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316099AbSEJUBB>; Fri, 10 May 2002 16:01:01 -0400
Date: Fri, 10 May 2002 13:00:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, <linux-kernel@vger.kernel.org>,
        <trond.myklebust@fys.uio.no>, <reiserfs-dev@namesys.com>
Subject: Re: [PATCH] iget-locked [2/6]
In-Reply-To: <Pine.GSO.4.21.0205101554540.19226-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0205101258160.16160-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 May 2002, Alexander Viro wrote:
> 
> No problems, except for putting exports in inode.c.  ISTR Linus saying that
> additional files with exports seriously increase the build time...  Linus?

A few additional ones are fine - especially for "core" stuff like inode.c 
I don't see any problem at all.

And keeping EXPORT_SYMBOL close to the place that defines it makes some 
things clearer. I would certainly not mind moving some of the 
kernel/ksym.c stuff out to the places that actually define the functions.

If it becomes an issue where _most_ files in export symbols, our build 
times will suck, but fs/inode.c is certainly central enough that I don't 
find any problem with it.

		Linus

