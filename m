Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTJEAzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 20:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTJEAzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 20:55:43 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13701
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262844AbTJEAzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 20:55:40 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: andersen@codepoet.org, "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Date: Sat, 4 Oct 2003 19:52:09 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030914064144.GA20689@codepoet.org> <bk30f1$ftu$2@tangens.hometree.net> <20030915055721.GA6556@codepoet.org>
In-Reply-To: <20030915055721.GA6556@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310041952.09186.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 September 2003 00:57, Erik Andersen wrote:
> On Mon Sep 15, 2003 at 12:17:37AM +0000, Henning P. Schmiedehausen wrote:
> > Erik Andersen <andersen@codepoet.org> writes:
> > >When you are done making noise, please explain how a closed
> > >source binary only product that runs within the context of the
> > >Linux kernel is not a derivitive work and therefore not subject
> > >to the terms of the GPL, per the definition given in the kernel
> > >COPYING file that grants you your limited rights for copying,
> > >distribution and modification.
> >
> > "Because Linus said so".
>
> It does not say "Because Linus said so" in the Linux kernel
> COPYING file, which is the only official document that grants
> legal permission to copy, distribute and/or modify the kernel.

Linus clearly and publicly stated his position on binary only kernel modules 
almost exactly one year ago:

http://groups.google.com/groups?selm=Pine.LNX.4.44.0210170958340.6739-100000%40home.transmeta.com.lucky.linux.kernel

He basically said there IS no module exception to the GPL, it's just a 
question of what is and is not a derived work.

The kernel developers have marked up portions of the API to indicate "we 
consider anything that needs to access this deeply internal bit to be a 
derived work, hence subject to the GPL".  That's what GPL_ONLY _means_.  
Needing to re-export that therefore opens you up to a lawsuit.  (Whether you 
can defend yourself in court from that lawsuit is always an open question, 
but by adding GPL_ONLY markup the developers made their intent much more 
clear, which is unlikely to help you convince a judge of your interpretation 
if you explicitly undo that markup and then claim the license doesn't apply 
to you...)

Here's the relevant section of the above posting from Linus:

-----

I will re-iterate my stance on the GPL and kernel modules:

  There is NOTHING in the kernel license that allows modules to be 
  non-GPL'd. 

  The _only_ thing that allows for non-GPL modules is copyright law, and 
  in particular the "derived work" issue. A vendor who distributes non-GPL 
  modules is _not_ protected by the module interface per se, and should 
  feel very confident that they can show in a court of law that the code 
  is not derived.

  The module interface has NEVER been documented or meant to be a GPL 
  barrier. The COPYING clearly states that the system call layer is such a 
  barrier, so if you do your work in user land you're not in any way 
  beholden to the GPL. The module interfaces are not system calls: there 
  are system calls used to _install_ them, but the actual interfaces are
  not.

  The original binary-only modules were for things that were pre-existing 
  works of code, ie drivers and filesystems ported from other operating 
  systems, which thus could clearly be argued to not be derived works, and 
  the original limited export table also acted somewhat as a barrier to 
  show a level of distance.
