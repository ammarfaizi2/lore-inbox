Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSCHWnB>; Fri, 8 Mar 2002 17:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290919AbSCHWmv>; Fri, 8 Mar 2002 17:42:51 -0500
Received: from zok.SGI.COM ([204.94.215.101]:19372 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289813AbSCHWml>;
	Fri, 8 Mar 2002 17:42:41 -0500
Date: Fri, 8 Mar 2002 14:40:24 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop null ptr deference in __alloc_pages
In-Reply-To: <37610000.1015624249@flay>
Message-ID: <Pine.LNX.4.33.0203081356060.18968-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Martin J. Bligh wrote:

> >> I should have also mentioned that:
> >>
> >> 1) I shouldn't need the SGI patch, though it might help performance.
> >
> > Why shouldn't you need it ? It is NUMA generic, and totally arch
> > independent.
>
> I just mean the kernel shouldn't panic if I don't have it.
That is true...


> > And it actually helps performance. I also allows the kernel to have a
> > single memory allocation path. I think it is cleaner than calling _alloc_pages()
> > from numa.c
> >
> >> 2) The kernel panics without my fix, and runs fine with it.
> > I hope so  :-)
> > But your fix is at the same time useless and harmless for UMA machines.
>
> Yup, though I suppose we could shave off a couple of nanoseconds by
> surrounding my little check with #ifdef CONFIG_NUMA.
>
> > OTOH, the SGI patch doesn't modify __alloc_pages(). I think I'm a little
> > too picky here...
>
> With the #ifdef, I won't really do this either (at least for the code generated).
>
> The SGI patch is probably a good thing, and I'll pick it up and try it
> sometime soon. The only real problem is that it's not in the mainline
> already. Until such time as it gets there, the fix I posted is trivial,
> and easily seen to be correct (well, I'm biased ;-) ), and should get
> shoved into the mainline much easier.
You're right. It's on -aa kernels, so it'll get in mainline soon.

Cheers,
Samuel.



