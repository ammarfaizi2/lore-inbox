Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbRE2N6X>; Tue, 29 May 2001 09:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbRE2N6P>; Tue, 29 May 2001 09:58:15 -0400
Received: from [200.1.19.3] ([200.1.19.3]:56589 "EHLO pincoya.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262313AbRE2N6D>;
	Tue, 29 May 2001 09:58:03 -0400
Message-Id: <200105291354.f4TDsvvU024757@pincoya.inf.utfsm.cl>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Edgar Toernig <froese@gmx.de>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup) 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Tue, 29 May 2001 12:54:18 +0200." <01052912541919.06233@starship> 
Date: Tue, 29 May 2001 09:54:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> said:
> On Monday 28 May 2001 03:26, Horst von Brand wrote:
> > Daniel Phillips <phillips@bonn-fries.net> said:
> > > On Sunday 27 May 2001 15:32, Edgar Toernig wrote:
> >
> > [...]
> >
> > > > you break UNIX fundamentals.  But I'm quite relieved now because
> > > > I'm pretty sure that something like that will never go into the
> > > > kernel.
> > >
> > > OK, I'll take that as "I couldn't find a piece of code that breaks,
> > > so it's on to the legal issues".
> >
> > It boggles my (perhaps underdeveloped) mind to have things that are
> > files _and_ directories at the same time.

> They are not, the device file and the directory are different objects 
> that have the same name.  In C, "foo" and "struct foo" can appear in 
> the same scope but they are different objects.  This must have seemed 
> to be a strange idea at first.  Here we have "foo" (a device) and 
> "directory foo" (the device's properties).

They have the exact same name, how is anybody going to distinguish them?

> When I first saw Linus mention the idea I did a double-take, I thought 
> it was a strange idea and my first reaction was, it would break all 
> kinds of things.  But when I started examining cases I was unable to 
> find any real problems.  When I asked code examples of breakage none of 
> the supplied examples survived scrutiny.  Then, when I looked through 
> SUS I didn't find any prohibition.

I isn't allowed either...

> > The last time this was
> > discussed was for handling forks (a la Mac et al) in files, and it
> > was shot down.
> 
> Do you have the subject line?  It might save us some time ;-)

Nope, sorry.

> I seem to recall that the fork idea died because it was thought to 
> require changes to userspace programs such as tar and find.  The 
> magicdev idea doesn't require such changes, none that I've seen so far.

tar(1) of /dev should blow up in exactly the same way, AFAICS...

Everybody just knows a device is a device, a file is a file, and a
directory is a directory. Standards notwithstanding, this is how things
work, and have worked for a _long_ time; with absolutely no warning that
the assumption might become wrong sometime or be wrong on some strange
beast (you didn't find anything in your search). I'd suspect nobody
bothered to cast this in stone because nobody even considered such a
twisted possibility.

Take it up with somebody on the standards commitees, they (should) have
looked long and hard at the nooks and cranies in the standard, and so are
in a better position to comment than we here are.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
