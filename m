Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318071AbSG2WnJ>; Mon, 29 Jul 2002 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSG2WnJ>; Mon, 29 Jul 2002 18:43:09 -0400
Received: from [195.223.140.120] ([195.223.140.120]:1560 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318071AbSG2WnJ>; Mon, 29 Jul 2002 18:43:09 -0400
Date: Tue, 30 Jul 2002 00:47:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: oopsen with rc3-aa3
Message-ID: <20020729224737.GJ1201@dualathlon.random>
References: <20020729174238.GA1919@714-cm.cps.unizar.es> <20020729181020.GU1201@dualathlon.random> <20020729223539.GA1936@714-cm.cps.unizar.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729223539.GA1936@714-cm.cps.unizar.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 12:35:39AM +0200, J.A. Magallon wrote:
> On 20020729 Andrea Arcangeli wrote:
> > On Mon, Jul 29, 2002 at 07:42:38PM +0200, J.A. Magallon wrote:
> > > Hi.
> > > 
> > > The new code in rc3aa3 makes a dual Xeon box hang on boot just
> > > when stating migration threads. I get two simultaneous oops, one
> > > for migration_thread=1 and =2. Decoded oops for one of them:
> > 
> > can you find out the exact line of C code that oopses (i.e. what it is
> > supposed to be edx)? If you can't find it please send me the disassembly
> > of the function load_balance, thanks.
> > 
> 
> Assembler listing for load_balance attached, got by objdump -d in
> /usr/src/linux/vmlinux (correct procedure ?).

it's not attached but never mind :) and yes it's the correct procedure.

btw, is it an hyperthreading cpu? Had you any problem with aa2?

> 
> > Also please try to reproduce with Ingo's latest, I merged a few fixes
> > for the migration thread startup from his latest update.
> >
> 
> Does this mean I can merge Ingo's updates in -aa ? Don't they use any
> infrastructure not present in 2.4 ?

I just merged all Ingo's updates, except the new features like
SCHED_BATCH and SCHED_IDLE, I don't feel they're needed in 2.4 and now
the o1 is finally stable after the last fixes that apparently improved
tbench of another 10% and that should avoid the sluggish behaviour under
high load in smp and now that sched_yield doesn't hang anymore by
refiling to the expired queue. I only skept those two features (they're
not even in 2.5 yet).

Andrea
