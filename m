Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132429AbRDJQm6>; Tue, 10 Apr 2001 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132434AbRDJQmr>; Tue, 10 Apr 2001 12:42:47 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:39435 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132429AbRDJQmp>;
	Tue, 10 Apr 2001 12:42:45 -0400
Date: Tue, 10 Apr 2001 18:42:37 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: richard offer <offer@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build -->/usr/src/linux
Message-ID: <20010410184237.A20969@pcep-jamie.cern.ch>
In-Reply-To: <3AD079EA.50DA97F3@rcn.com> <20010408161620.A21660@flint.arm.linux.org.uk> <3AD0A029.C17C3EFC@rcn.com> <9aqmgo$8f6ol$1@fido.engr.sgi.com> <10104091601.ZM401478@sgi.com> <20010410160825.A20555@pcep-jamie.cern.ch> <lk@tantalophile.demon.co.uk> <1010410093615.ZM1231@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010410093615.ZM1231@sgi.com>; from offer@sgi.com on Tue, Apr 10, 2001 at 09:36:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard offer wrote:
> * > uname does not always provide useful information (cross compiling). Even
> * > if you're building the same ISA, you maybe in a chroot'ed environment.
> * >
> * > Can we please not assume that everybody only ever builds native...
> *
> * Nobody is assuming that.  If you're hard enough to do a cross compile,
> * you can build external modules using "make KERNEL_RELEASE=2.4.2
> * KERNEL_SOURCE=/home/jamie/cross_compiling/kernel ARCH=mips64" or
> * whatever.
> 
> Applications make that assumption all the time.
> 
> Yes, this is the kernel mail list, but applications use kernel services. By
> tacitly agreeing that you get the kernel headers from /lib/modules/`uname
> -r`/build/include that's what people will code into their makefiles.

_Applications_ should not use kernel headers at all.  For ioctls, they
should ship with copies of the definitions they need.  That's been made
clear as crystal many times on this list, and it should be in the FAQ if
it isn't already.

> Saying "oh, but applications should do that" isn't much of a argument,
> as there isn't a better way of working out where a set of kernel
> headers are.  And "oh but applications should be using /usr/include/"
> doesn't cut it. There are times when you really do need to be able to
> build things outside of the kernel tree that are kernel specific.

Sorry, I don't understand your message.

Are you saying, for third-party kernel modules, "oh well, use `uname
-r`", "don't use `uname -r`", "use something else" or "I don't have any
suggestions"?

-- Jamie
