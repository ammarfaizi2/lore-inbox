Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbQKVI5t>; Wed, 22 Nov 2000 03:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130486AbQKVI5j>; Wed, 22 Nov 2000 03:57:39 -0500
Received: from [212.32.186.211] ([212.32.186.211]:55191 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129868AbQKVI50>; Wed, 22 Nov 2000 03:57:26 -0500
Date: Wed, 22 Nov 2000 09:27:07 +0100 (CET)
From: Urban Widmark <urban@svenskatest.se>
To: Peter Samuelson <peter@cadcamlab.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
In-Reply-To: <20001121191432.H2918@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0011220921130.24451-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Peter Samuelson wrote:

[someone wrote, and I am keeping it :) ]
> > > >   void foo (void)
> > > >   {
> > > >     if (0)
> > > >       printk(KERN_INFO "bar");
> > > >   }
> > > > 

[snip]

> Jakub Jelinek claims to have fixed this particular bug in the last week
> or so, although I have not downloaded and compiled recent CVS to verify
> this.  (Didn't someone at some point have a cgi frontend to
> CVS-snapshot 'gcc -S'?  I can't find it now.)

It is linked from the "Reporting bugs" page on the gcc site.
http://www.codesourcery.com/gcc-compile.shtml

And as far as I can tell the assembly output of compiling "foo" does not
contain the "bar" string (without using any -O at all ...)

GCC: (GNU) 2.97 20001121 (experimental)

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
