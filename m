Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132915AbRAKTCD>; Thu, 11 Jan 2001 14:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132998AbRAKTBx>; Thu, 11 Jan 2001 14:01:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17393 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132915AbRAKTBQ>;
	Thu, 11 Jan 2001 14:01:16 -0500
Date: Thu, 11 Jan 2001 14:01:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <20010111125604.A17177@redhat.com>
Message-ID: <Pine.GSO.4.21.0101111358530.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Wed, Jan 10, 2001 at 12:11:16PM -0800, Linus Torvalds wrote:
> > 
> > That said, we can easily support the notion of CLONE_CRED if we absolutely
> > have to (and sane people just shouldn't use it), so if somebody wants to
> > work on this for 2.5.x...
> 
> But is it really worth the pain?  I'd hate to have to audit the entire
> VFS to make sure that it works if another thread changes our
> credentials in the middle of a syscall, so we either end up having to
> lock the credentials over every VFS syscall, or take a copy of the
> credentials and pass it through every VFS internal call that we make.

COW. Pthreads are simply irrelevant here - if you want set*id in one
thread to change the credentials of the rest you can do it in libpthreads.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
