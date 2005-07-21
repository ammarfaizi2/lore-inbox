Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVGUCka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGUCka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 22:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVGUCka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 22:40:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42882 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261576AbVGUCk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 22:40:28 -0400
Message-Id: <200507210020.j6L0Kmjg003659@laptop11.inf.utfsm.cl>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space 
In-Reply-To: Message from Jesper Juhl <jesper.juhl@gmail.com> 
   of "Wed, 20 Jul 2005 14:59:51 +0200." <9a87484905072005596f2c2b51@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 20 Jul 2005 20:20:48 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 7/11/05, Michael S. Tsirkin <mst@mellanox.co.il> wrote:

> [snip]

> > 3e. sizeof
> >         space after the operator
> >         sizeof a

> I don't think that's a hard rule, there's plenty of code that does 
> "sizeof(type)"  and not  "sizeof (type)", and whitespace cleanup
> patches I've done that change "sizeof (type)" into "sizeof(type)" have
> generally been accepted.

It is necessary /not/ to put space between "function name" and '(', because
if it is a function-like macro, it does matter. For uniformity, do it for
functions and operations like sizeof too.

> [snip]
> > 
> > 4. Indentation rules for C
> >         Use tabs, not spaces, for indentation. Tabs should be 8 characters wide.

> A tab is a tab is a tab, how it's displayed is up to the editor
> showing the file.

But editing a file with tab==4 and editing it later with tab==8 guarantees
a mess.

[...]

> > 6. One-line statement does not need a {} block, so dont put it into one
> >         if (foo)
> >                 bar;

> Not always so, if `bar' is a macro adding {} may be safer.

Such macros are /very/ dangerous. That's one reason why multi-line macros
must be wrapped in "do { ... } while(0)"

>                                                            Also
> sometimes adding {} improves readability, which is important.

Or leaves an old C hand wondering what is going on...

> > 7. Comments
> >         Dont use C99 // comments.
> > 
> 
> s/Dont/Don't/
> 
> 
> > 9a. Integer types
> >         int is the default integer type.
> >         Use unsigned type if you perform bit operations (<<,>>,&,|,~).
> >         Use unsigned long if you have to fit a pointer into integer.
> >         long long is at least 64 bit wide on all platforms.
> >         char is for ASCII characters and strings.
> >         Use u8,u16,u32,u64 if you need an integer of a specific size.
> 
> u8,s8,u16,s16,u32,s32,u64,s64

Plus annotations for bitwise and such. See Documentation/sparse.txt
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
