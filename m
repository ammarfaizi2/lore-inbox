Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317177AbSEXP55>; Fri, 24 May 2002 11:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSEXP5j>; Fri, 24 May 2002 11:57:39 -0400
Received: from imladris.infradead.org ([194.205.184.45]:28681 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317183AbSEXP4r>; Fri, 24 May 2002 11:56:47 -0400
Date: Fri, 24 May 2002 16:55:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Jan Kara <jack@suse.cz>,
        Nathan Scott <nathans@sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020524165514.A20631@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Jan Kara <jack@suse.cz>, Nathan Scott <nathans@sgi.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CEE51A4.9010308@evision-ventures.com> <E17BHfh-0006lp-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 05:12:05PM +0100, Alan Cox wrote:
> > > Of course you can.  Even the latest OpenLinux release (shipping 2.4.13-ac)
> > > uses a libc4/a.out based installer fo space reasons.  Not to forget the
> > > old quake1 binary from some redhat 4.x CD I run from time to time :)
> > 
> > OK thanks for the *substantial* answer. That was the reason I was asking about.
> > Somehow this is of course surprising me of course.
> 
> So why didn't you -test- the theory before suggesting it. It btw goes beyond
> Libc4. Currently we have almost 100% compatibility back to libc 2.2.2. The
> dated libc before that doesn't work because we dropped some very very
> early obscure versions of a few syscalls.
> 
> Is it too much to ask that you go and look through the syscall tables of
> old and new kernels ? 

For 2.5 I have some plans to make obsolete syscalls depend on CONFIG_COMPAT_*,
this allows to compile big and bloated kernel for compatiblity and smaller
kernels without that (e.g. for embedded devices).  And in fact we have quite
a loft of cruft that can go away for setups only having very modern userspace..

