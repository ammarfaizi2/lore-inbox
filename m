Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290032AbSAXUVK>; Thu, 24 Jan 2002 15:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290060AbSAXUVA>; Thu, 24 Jan 2002 15:21:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290032AbSAXUUn>; Thu, 24 Jan 2002 15:20:43 -0500
Date: Thu, 24 Jan 2002 15:21:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Oliver Xymoron <oxymoron@waste.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.4.44.0201241313420.2839-100000@waste.org>
Message-ID: <Pine.LNX.3.95.1020124151116.1245A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Oliver Xymoron wrote:

> On Thu, 24 Jan 2002, Jeff Garzik wrote:
> 
> > A small issue...
> >
> > C99 introduced _Bool as a builtin type.  The gcc patch for it went into
> > cvs around Dec 2000.  Any objections to propagating this type and usage
> > of 'true' and 'false' around the kernel?
> 
> Ugh, no. C doesn't need booleans, neither do Perl or Python. This is a
> sickness imported from _recent_ C++ by way of Java by way of Pascal. This
> just complicates things.
> 
> > Where variables are truly boolean use of a bool type makes the
> > intentions of the code more clear.  And it also gives the compiler a
> > slightly better chance to optimize code [I suspect].
> 
> Unlikely. The compiler can already figure this sort of thing out from
> context.

IFF the 'C' compiler code-generators start making better code, i.e.,
ORing a value already in a register, with itself and jumping on
condition, then bool will be helpful. Right now, I see tests against
numbers (like 0). This increases the code-size because the 0 is
in the instruction stream, plus the comparison of an immediate
value to a register value (on Intel) takes more CPU cycles.

So, if the compiler, knowing that bool can be only TRUE or
FALSE (implementation-defined 1 or 0), then it can probably
save a few CPU cycles. A good thing about a new type is that
you don't have to use it. Just like enumerated types, if you
don't like them, don't use them. Perfectly good code can be
written without them.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


