Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSEHI3D>; Wed, 8 May 2002 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSEHI3C>; Wed, 8 May 2002 04:29:02 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27664 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312254AbSEHI3B>; Wed, 8 May 2002 04:29:01 -0400
Date: Wed, 8 May 2002 10:29:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Clifford White <ctwhite@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 question: Can a process have > 3GB memory?
Message-ID: <20020508102934.Z31998@dualathlon.random>
In-Reply-To: <OF4EFD903E.F8196584-ON87256BB2.007DEC69@boulder.ibm.com> <1020812936.2079.31.camel@bigsur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 04:08:55PM -0700, Robert Love wrote:
> On Tue, 2002-05-07 at 16:03, Clifford White wrote:
> 
> > We are working with a database that requires a large amount of memory
> > allocated by a single process.
> > This is on an Intel 32-bit platform.
> > We'd like to go > 3GB of memory per process.
> > Is this possible on a 32-bit machine? I have been reading the various
> > 'highmem' discussions, but that's kernel page tables...
> > Or is this a glibc issue, and not proper for a kernel-list question?
> > Any pointers would be appreciated. The Intel ESMA (Extended Server Memory
> > Arch) page states that it's possible, but.....how?
> 
> You can go to 3.5GB, anything more and stuff starts getting real tight
> and not very nice.  You can only do 3.5/0.5 on non-PAE, though - PAE
> requires segments to be aligned on 1GB-boundaries.
> 
> The attached patch (for which credit goes elsewhere - Ingo or Randy, I
> think?) implements the full range of 1 to 3.5GB user space partitioning,

actually I'm the one who wrote the 3.5G config option both in 2.2 and
recently I forward ported it to 2.4 due the number of requests I was
getting.

> selectable at compile-time.
> 
> 	Robert Love
> 




Andrea
