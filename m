Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316108AbSEJUP1>; Fri, 10 May 2002 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316109AbSEJUP0>; Fri, 10 May 2002 16:15:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56548 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316108AbSEJUPZ>;
	Fri, 10 May 2002 16:15:25 -0400
Date: Fri, 10 May 2002 16:15:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: Re: [PATCH] iget-locked [2/6]
In-Reply-To: <Pine.LNX.4.33.0205101258160.16160-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0205101614260.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Linus Torvalds wrote:

> 
> On Fri, 10 May 2002, Alexander Viro wrote:
> > 
> > No problems, except for putting exports in inode.c.  ISTR Linus saying that
> > additional files with exports seriously increase the build time...  Linus?
> 
> A few additional ones are fine - especially for "core" stuff like inode.c 
> I don't see any problem at all.
> 
> And keeping EXPORT_SYMBOL close to the place that defines it makes some 
> things clearer. I would certainly not mind moving some of the 
> kernel/ksym.c stuff out to the places that actually define the functions.
> 
> If it becomes an issue where _most_ files in export symbols, our build 
> times will suck, but fs/inode.c is certainly central enough that I don't 
> find any problem with it.

OK.  BTW, would you accept ->getattr() patchset if I start to feed it to
you today?

