Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263711AbUEWW6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUEWW6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 18:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUEWW6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 18:58:49 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:38785 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S263711AbUEWW6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 18:58:47 -0400
Message-Id: <200405232258.i4NMwQJ05566@pincoya.inf.utfsm.cl>
To: vherva@viasys.com
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1 
In-reply-to: Your message of "Sun, 23 May 2004 20:37:39 +0300."
             <20040523173738.GY23361@viasys.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 23 May 2004 18:58:25 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@viasys.com> said:
> On Sun, May 23, 2004 at 12:19:11PM -0400, you [Horst von Brand] wrote:
> > Linus Torvalds <torvalds@osdl.org> said:
> > > Hmm.. This is stuff all over the map, but most interesting (or at least
> > > most "core") is probably the merging of the NUMA scheduler and the anonvma
> > > rmap code. The latter gets rid of the expensive pte chains, and instead
> > > allows reverse page mapping by keeping track of which vma (and offset)  
> > > each page is associated with. Special kudos to Andrea Arcangeli and Hugh
> > > Dickins.
> > > 
> > > 		Linus
> > 
> > Not wanting to start a flamewar, but this sort of massive changes in a
> > _stable_ series has got me quite confused... either 2.6.0 was premature, or
> > the "just stabilize 2.6, new stuff only into 2.7 (when it opens)" got lost
> > somewhere.

> In my view the 2.6 series have been as stable as they should have from the
> user point of view. AFAICT no serious bugs have been introduced during 2.6
> and the application visible API hasn't changed notably.

My experience too, but I'm just an average end-user (sort of), not an
extra-paranoid admin of a critical machine. New features _do_ bring
risks. Are they being controlled enough by staging stuff through -mm? Or is
it now the distribution's job to to final stability triage?

It looks like Andrew Morton is playing the role Alan Cox had during part of
2.5: Checking/filtering/testing "not quite ready" stuff, when he was
supposed to be like Marcelo Tossati: Keeper of the stable series, don't let
anything too risky get even near it.

Perhaps the philosophy changed while I was away from LKML, that's why I'm
asking.

> Does it to any harm if there are largish changes under the hood? Especially
> if they are big improvements?

I welcome them, and surely hacking new stuff is fun. But 2.6 is not a
hacking series, it is supposed to (become) rock stable (soon?).

> As an user, I definetely welcome the new features and improvements if they
> can be introduced without breakage, as seems to be the case. 
> 
> To me, this just goes on to testify to the the expertise of the kernel
> hackers and the viability of the current development model.

Expertise of the kernel hackers, hat off to them. Incredible bunch. But
there _were_ a number of "brown paper bag" releases too...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
