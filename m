Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbTCLPVm>; Wed, 12 Mar 2003 10:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbTCLPVm>; Wed, 12 Mar 2003 10:21:42 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3465 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261719AbTCLPVh>;
	Wed, 12 Mar 2003 10:21:37 -0500
Message-Id: <200303121532.h2CFWctg001873@eeyore.valparaiso.cl>
To: Zack Brown <zbrown@tumblerings.org>
cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Tue, 11 Mar 2003 21:22:25 PST."
             <20030312052225.GO4716@renegade> 
Date: Wed, 12 Mar 2003 11:32:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Brown <zbrown@tumblerings.org> said:
> On Tue, Mar 11, 2003 at 11:47:50PM -0400, Horst von Brand wrote:
> > Zack Brown <zbrown@tumblerings.org> said:
> > > --------------------------------- cut here --------------------------------
> -
> > > 
> > >            Linux Kernel Requirements For A Version Control System    
> > > 
> > > Document version 0.0.1
> > 
> > [...]
> > 
> > > In the context of sharing changesets between repositories, a changeset
> > > consists of a diff between the set of files in the local and remote
> > > repositories.
> > 
> > I don't think it is a good idea to handle differences _between_
> > repositories, as they could be arbitrary and change in time. A change
> > _within_ a repository is well defined.
> 
> But isn't it necessary to excange changesets between repositories? How
> else would a developer choose exactly what changes get merged with a
> remote repository?

Again, _from_ a remote repository. I want control over the stuff I have
here.

The idea should be to be able to browse the changesets at the remote
depository and then pick changesets from there. Or just pull all
outstanding changesets (from the last sychronization point on). But that is
a bit hard... say I clone Linus' tree, and then want to sycnronize with say
DaveM. But DaveM's tree is a few changesets behind Linus', and has extra
stuff. If I'm going promiscuous, I'll add some patches of my own, get some
random stuff from lkml (some of which are picked up later by Linus, others
aren't). I'd later try to get up to date with Andrea's tree, where we again
have the same scenario. And then go to Linus' next point release, who mixed
and matched, and sometimes mangled, changesets from the above in the
meantime... please tell me what the sychronization points for all those
transactions should be. Consider that DaveM might have applied changesets
to his tree in a certain order, and later Linus picked up some of the later
ones, and after some time finally integrated an earlier changeset of
DaveM's (perhaps had to merge it (i.e., adjust it) due to intervening
changes). So you don't even have a "standard order in which changesets are
applied" across the board, and "the same changeset" is different depending
on the three on which it is applied.

So, a changeset is local, or something to be sent out and merged elsewhere
(where due to the merging it loses its former identity). Think traditional
patches: I can create a patch here, give it to you. But what you end
applying is different due to changes at your place. You apply a different
patch.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
