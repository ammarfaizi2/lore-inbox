Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSKJCMz>; Sat, 9 Nov 2002 21:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbSKJCMz>; Sat, 9 Nov 2002 21:12:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11336 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262959AbSKJCMy>; Sat, 9 Nov 2002 21:12:54 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com>
	<m1of8ycihs.fsf@frodo.biederman.org>
	<1036894347.22173.6.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 19:16:58 -0700
In-Reply-To: <1036894347.22173.6.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1k7jmcgo5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sun, 2002-11-10 at 01:37, Eric W. Biederman wrote:
> > The reasons I don't jump on board:
> > - It does not handle multiple segments.
> >   Without multiple segments I think I simply out essential complexity
> >   of the problem.  A bzImage has at least 2.
> 
> Thats a matter for user space and the unpacker
> 
> > - vmalloc is artificially limited to 128MB.
> 
> Just grabbing a load of pages and using kmap/scatter gather by hand is
> not

To use kmapped memory I need to setup a page table to do the final copy.
And to setup a page table I need to know where the memory is going to be copied
to.

So my gut impression at least says an interface that ignores where
the image wants to live just adds complexity in other places, and
makes for an interface that is hard to maintain long term, because
you depend on a lot of kernel implementation details, which are likely
to change in arbitrary ways.

Eric

