Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSI0PuD>; Fri, 27 Sep 2002 11:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSI0PuD>; Fri, 27 Sep 2002 11:50:03 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:772 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261750AbSI0PuC>; Fri, 27 Sep 2002 11:50:02 -0400
Date: Fri, 27 Sep 2002 17:55:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andi Kleen <ak@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put modules into linear mapping
In-Reply-To: <p73d6qzsav0.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0209271745230.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27 Sep 2002, Andi Kleen wrote:

> > Why is i386 only? This is generic code and other archs will benefit from
> > it as well (or at least it won't hurt).
>
> Because some arcitectures have a different module_map() (e.g. x86-64 or
> sparc64)

As I already said in the last mail, these functions look like vmalloc
reimplementations.

> and because the VMALLOC_START/END trick doesn't work on all.

Where doesn't it work? vmalloc wouldn't work there either.

> > > +void *alloc_exact(unsigned int size)
> >
> > Wouldn't it be better to add a gfp argument?
>
> I don't see a need for it. GFP_ATOMIC doesn't make sense for > order 0,
> and > order 0 is the only case that is interesting for alloc_exact.
> GFP_DMA is not needed here, and GFP_HIGHUSER neither supports > order 0
> properly (because of kmap)

If it's supposed to be a generic function, it makes sense, otherwise we
could just put it into module.c.

bye, Roman

