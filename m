Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSGXLzu>; Wed, 24 Jul 2002 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSGXLzu>; Wed, 24 Jul 2002 07:55:50 -0400
Received: from unthought.net ([212.97.129.24]:21911 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S317005AbSGXLzk>;
	Wed, 24 Jul 2002 07:55:40 -0400
Date: Wed, 24 Jul 2002 13:58:50 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Martin Brulisauer <martin@uceb.org>
Cc: Joshua MacDonald <jmacd@namesys.com>, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Message-ID: <20020724115850.GS11081@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Martin Brulisauer <martin@uceb.org>,
	Joshua MacDonald <jmacd@namesys.com>, neilb@cse.unsw.edu.au,
	linux-kernel@vger.kernel.org
References: <3D3E75E9.28151.2A7FBB2@localhost> <3D3EA294.30758.3567B82@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D3EA294.30758.3567B82@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 12:50:28PM +0200, Martin Brulisauer wrote:
...
> So it is.
> 
> At kernel level nothing will stop me to halt() the cpu, if I realy want 
> to. It is important to understand that tools (and all compilers are
> just tools) will not enable me to write correct code. 

That is a lame argument.

We've just seen that very competent people can make really silly
mistakes because of generic code without type safety.

*IF* the code had type safety, such silly mistakes would be caught at
compile time.

Now there are arguments for and against implementations such as the type
safe list implementation.  But an argument against type-safety is
rediculous.  If the language does not allow for type safety in any
convenient manner, so be it, but type-safety really is useful for
avoiding silly mistakes, and this should be exploited whenever the
language (and clever *use* of the language) allows for it.

> > 
> > I can say a lot of good and bad things about C++, but at least it lets you do
> > this kind of thing with type safety and without ugly macros.
> > 
> Yes. That's absolutely true for C++. But the kernel is implemented 
> in C and C is "only" kind of a high-level-assembler language. It is

No, C has types.  It is not just portable assembly.

Why do you think it allows for typed pointers and not just void* or
even long?

> ment to be open - on purpose. There exist other languages that 
> have these kinds of concepts you bring in (I would not use C++ as 
> the best example - take OBERON/MODULA or EIFFEL). But these 
> languages are not made to implement an operating system 
> (remember the reason K&R have specified and implemented C?).

Wrong.  Look at Atheos for an example.  There is *nothing* you can do in
C that you cannot do in C++ with equal or better performance (there is C
code that is not valid C++, but it's small semantic details and scope
rules, re-writing is simple).

But this is of course irrelevant, as there are other good reasons for
not rewriting the kernel in any other language.

> 
> What I realy dislike is the approach to bring in any OO concepts 
> into the C language the linux kernel bases on. Keep the code as 
> simple and homogenous as possible (or try to rewrite it in OO).

Who is talking about OO ???

What Joshua presented is a C implementation of a list using
parameterized types using macros (instead of templates as could have
been used in C++).  Parameterized types has nothing what so ever in any
way to do with OO  (it goes well with some OO concepts, but that's an
entirely different story).

> 
> The way I see this discussion is: Every software problem has it's 
> proper language to be solved in. And for this, Linus decided it to be 
> C.

Yes. And I think that was a very clever decision - even if there had
been proper C++ compilers at the time (which there wan't, because the
language wasn't even standardized until 1998).

But did Linus decide to use "crappy C" or "error-prone C", or is there
some chance that the most generic code could perhaps be implemented in
"robust C" ?

Macros are not a pretty solution, but it is as I see it the only way to
achieve type safety in generic code.  If someone else out there has
other suggestions, please let me know - I actually like to be proven
wrong (because that means I learn something new).

I'd take macro-hell in generic code over void* hell in every single
list-using part of the kernel any day.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
