Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRGJOQB>; Tue, 10 Jul 2001 10:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266378AbRGJOPv>; Tue, 10 Jul 2001 10:15:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:348 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266377AbRGJOPh>; Tue, 10 Jul 2001 10:15:37 -0400
Date: Tue, 10 Jul 2001 16:15:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Chris Wedgwood <cw@f00f.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: msync() bug
Message-ID: <20010710161533.T1594@athlon.random>
In-Reply-To: <20010709170835.J1594@athlon.random> <20010711012524.A31799@weta.f00f.org> <3B4B0B1F.92EC5C0E@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4B0B1F.92EC5C0E@uow.edu.au>; from andrewm@uow.edu.au on Wed, Jul 11, 2001 at 12:03:11AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 12:03:11AM +1000, Andrew Morton wrote:
> Linus included the test for non-null page->mapping
> as well.  I wonder why.

I think it is because if you try hard you can map a dma page via
/dev/mem and then the driver can release the dma page (at rmmod for
example) before you munmap /dev/mem, and then the page goes in the
freelist and it is allocated as pagecache.

Andrea
