Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267326AbSKPSQg>; Sat, 16 Nov 2002 13:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbSKPSQg>; Sat, 16 Nov 2002 13:16:36 -0500
Received: from gasko.hitnet.RWTH-Aachen.DE ([137.226.181.85]:33042 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S267326AbSKPSQf>;
	Sat, 16 Nov 2002 13:16:35 -0500
Date: Sat, 16 Nov 2002 19:23:17 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David.Mosberger@acm.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021116182317.GA22083@gondor.com>
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com> <08a601c28bbb$2f6182a0$760010ac@edumazet> <20021114141310.A25747@infradead.org> <ugel9oavk4.fsf@panda.mostang.com> <1037298675.16000.47.camel@irongate.swansea.linux.org.uk> <15827.61722.800066.756875@panda.mostang.com> <1037303532.15996.59.camel@irongate.swansea.linux.org.uk> <1037304844.16003.63.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037304844.16003.63.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 08:14:04PM +0000, Alan Cox wrote:
> On Thu, 2002-11-14 at 19:52, Alan Cox wrote:
> > On Thu, 2002-11-14 at 18:53, David Mosberger-Tang wrote:
> > > But that's excactly the point.  The hugepage interface returns a
> > > different kind of virtual memory.  There are tons of programs out
> > > there using mmap().  If such a program gets fed a path to the
> > > hugepagefs, it might end up with huge pages without knowing anything
> > > about huge pages.  For the most part, that might work fine, but it
> > > could lead to subtle failures.
> > 
> > Your argument makes sense. You are arguing
> Makes no sense rather 8)

Sorry, I didn't follow the whole discussion, so my argument may make no
sense at all, too. :-)

If I understand David correctly, he doesn't worry about programs that
want to use huge pages, but about programs just using mmap just to
access some file. If they get called with a file that behaves subtly
different than usual files, that may lead to failures or even security
holes.

But that's no argument to keep the syscalls, if you decide to implement
hugepagefs. The existance of the syscalls doesn't prevent bugs created
or triggered by hugepagefs.

Jan

