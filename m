Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbTCOVLU>; Sat, 15 Mar 2003 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbTCOVLT>; Sat, 15 Mar 2003 16:11:19 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:57223 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S261571AbTCOVLP>;
	Sat, 15 Mar 2003 16:11:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Sat, 15 Mar 2003 22:25:54 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl>
In-Reply-To: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030315212205.CDE923D979@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 15 Mar 03 17:21, Horst von Brand wrote:
> Daniel Phillips <phillips@arcor.de> said:
> > On Thu 13 Mar 03 01:52, Horst von Brand wrote:
>
> [...]
>
> > > I don't think so. As the user sees it, a directory is mostly a
> > > convenient labeled container for files. You think in terms of moving
> > > files around, not destroying one and magically creating an exact copy
> > > elsewhere (even if mv(1) does exactly this in some cases). Also, this
> > > breaks up the operation "mv foo bar/baz" into _two_ changes, and this
> > > is wrong as the file loses its revision history.
> >
> > No, that's a single change to one directory object.
>
> mv some/where/foo bar/baz
>
> How is that _one_ change to _one_ directory object?

Oops, sorry, I didn't read your bar/baz correctly.  Yes, it's two directory 
objects, but it's only one file object, and the history (not including the 
name changes) is attached to the file object, not the directory object.  This 
is implemented via an object id for each file object, something like an inode 
number.

> > > > ...then this part gets much easier.
> > >
> > > ... by screwing it up. This is exactly one of the problems noted for
> > > CVS.
> >
> > CVS doesn't have directory objects.
>
> And it doesn't keep history across moves, as the only way it knows to move
> a file is destroying the original and creating a fresh copy.

Ah, but it does.  Sorry for not explaining the object id thing earlier.

> > Does anybody have a convenient mailing list for this design discussion?
>
> Good idea to move this off LKML

Yup, but nobody has offered one yet, so...

Regards,

Daniel
