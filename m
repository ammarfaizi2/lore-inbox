Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSAYH2i>; Fri, 25 Jan 2002 02:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290588AbSAYH2S>; Fri, 25 Jan 2002 02:28:18 -0500
Received: from [62.14.144.134] ([62.14.144.134]:47108 "EHLO ragnar-hojland.com")
	by vger.kernel.org with ESMTP id <S290586AbSAYH2I>;
	Fri, 25 Jan 2002 02:28:08 -0500
Date: Fri, 25 Jan 2002 04:52:06 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Timothy Covell <timothy.covell@ashavan.org>
Cc: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020125045206.A2313@ragnar-hojland.com>
In-Reply-To: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org> <200201242228.g0OMSlL06826@home.ashavan.org.> <1011911932.810.23.camel@phantasy> <200201242243.g0OMhAL06878@home.ashavan.org.>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201242243.g0OMhAL06878@home.ashavan.org.>; from timothy.covell@ashavan.org on Fri, Jan 25, 2002 at 04:44:38PM -0600
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 04:44:38PM -0600, Timothy Covell wrote:
> On Thursday 24 January 2002 16:38, Robert Love wrote:
> > On Fri, 2002-01-25 at 17:30, Timothy Covell wrote:
> > > On Thursday 24 January 2002 16:19, Robert Love wrote:
> > > > how is "if (x)" any less legit if x is an integer ?
> > >
> > > What about
> > >
> > > {
> > >     char x;
> > >
> > >     if ( x )
> > >     {
> > >         printf ("\n We got here\n");
> > >     }
> > >     else
> > >     {
> > >         // We never get here
> > >         printf ("\n We never got here\n");
> > >     }
> > > }
> > >
> > >
> > > That's not what I want.   It just seems too open to bugs
> > > and messy IHMO.
> >
> > When would you ever use the above code?  Your reasoning is "you may
> > accidentally check a char for a boolean value."  In other words, not
> > realize it was a char.  What is to say its a boolean?  Or not?  This
> > isn't an argument.  How does having a boolean type solve this?  Just use
> > an int.
> >
> > 	Robert Love
> 
> It would fix this because then the compiler would refuse to compile
> "if (x)"  when x is not a bool.    That's what I would call type safety.
> But I guess that you all are arguing that C wasn't built that way and
> that you don't want it.    

It would actually break this.  if is supposed (and expected) to evaluate
an expression, whatever it will be.  Maybe a gentle warning could be in
place, but refusing to compile is a plain broken C compiler.
-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
