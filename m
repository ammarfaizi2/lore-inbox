Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbTCLU1x>; Wed, 12 Mar 2003 15:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbTCLU1x>; Wed, 12 Mar 2003 15:27:53 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:31500 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261937AbTCLU1u>; Wed, 12 Mar 2003 15:27:50 -0500
Message-Id: <200303122037.h2CKboc7031958@pincoya.inf.utfsm.cl>
To: Daniel Phillips <phillips@arcor.de>
cc: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Message from Daniel Phillips <phillips@arcor.de> 
   of "Wed, 12 Mar 2003 17:13:39 +0100." <20030312160948.7FA05106EBE@mx12.arcor-online.net> 
Date: Wed, 12 Mar 2003 16:37:50 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> said:
> On Wed 12 Mar 03 16:32, Horst von Brand wrote:
> > ...a changeset is local, or something to be sent out and merged elsewhere
> > (where due to the merging it loses its former identity). Think traditional
> > patches: I can create a patch here, give it to you. But what you end
> > applying is different due to changes at your place. You apply a different
> > patch.

> This is why changesets need to be first-class objects in the repository,

Right.

> that can be versioned,

Versioned how? Have different versions of a changeset? Don't see the point.


>                        segmented

Here I disagree. The changeset should be seen as a (conceptually atomic)
change to the _local_ repository. The "conceptually atomic" part is from
Linus' style of "break up your megapatch into self-contained pieces, do one
step at a time". The changeset must make local sense if you want to be able
to undo, see what it changes, handle dependencies, ... Locally, what was
changed remotely (generating the changeset in the first place) is useless
(as the context isn't here).

>                                  and recombined.

Recombined how? Take changesets A and B, create C from half of each? Better
keep A, B, and create another one that gets rid of the junk. Or do a C from
scratch (perhaps by applying A and B as patches, fixing up the mess, and
declaring the resulting change a changeset).

It does make sense to group changesets, but not this way AFAICS.

>                                                  I'd be able to pull 
> slightly differing changesets from a variety of sources, *merge
> the changesets* and carry the result forward in my repository.  This
> way, no changeset needs to lose its identity until I explicity want it
> to.

This is doing merging among changesets, not merging changesets into the
repository. I'd prefer the later (as it reduces this special-purpose
operation to others that have to be there anyway).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
