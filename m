Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290206AbSAXUkB>; Thu, 24 Jan 2002 15:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290229AbSAXUjw>; Thu, 24 Jan 2002 15:39:52 -0500
Received: from waste.org ([209.173.204.2]:29861 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S290206AbSAXUjh>;
	Thu, 24 Jan 2002 15:39:37 -0500
Date: Thu, 24 Jan 2002 14:39:26 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.3.95.1020124151116.1245A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Richard B. Johnson wrote:

> On Thu, 24 Jan 2002, Oliver Xymoron wrote:
>
> > On Thu, 24 Jan 2002, Jeff Garzik wrote:
> >
> > > A small issue...
> > >
> > > C99 introduced _Bool as a builtin type.  The gcc patch for it went into
> > > cvs around Dec 2000.  Any objections to propagating this type and usage
> > > of 'true' and 'false' around the kernel?
> >
> > Ugh, no. C doesn't need booleans, neither do Perl or Python. This is a
> > sickness imported from _recent_ C++ by way of Java by way of Pascal. This
> > just complicates things.
> >
> > > Where variables are truly boolean use of a bool type makes the
> > > intentions of the code more clear.  And it also gives the compiler a
> > > slightly better chance to optimize code [I suspect].
> >
> > Unlikely. The compiler can already figure this sort of thing out from
> > context.
>
> IFF the 'C' compiler code-generators start making better code, i.e.,
> ORing a value already in a register, with itself and jumping on
> condition, then bool will be helpful. Right now, I see tests against
> numbers (like 0). This increases the code-size because the 0 is
> in the instruction stream, plus the comparison of an immediate
> value to a register value (on Intel) takes more CPU cycles.

The compiler _will_ turn if(a==0) into a test of a with itself rather than
a comparison against a constant. Since PDP days, no doubt.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

