Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272330AbRIEVxy>; Wed, 5 Sep 2001 17:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272340AbRIEVxq>; Wed, 5 Sep 2001 17:53:46 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:6357 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S272330AbRIEVx1>; Wed, 5 Sep 2001 17:53:27 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE0ED@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Subject: RE: lilo vs other OS bootloaders was: FreeBSD makes progress
Date: Wed, 5 Sep 2001 14:18:51 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Helge Hafting [mailto:helgehaf@idb.hist.no]
> > I'm not advocating anything similar for Linux, I'm just 
> saying it's an
> > interesting thought experiment - what if the SMP-ness of a 
> machine was
> > abstracted from the kernel proper? How much of the kernel 
> really cares, or
> > really *should* care about SMP/UP?
> You would also get rid of performance.  The agnostic kernel would be
> slower than simply running the SMP kernel on UP.
> 
> Here's why:
> You can easily make an "agnostic kernel & modules" by changing the
> spinlocks to function calls.  Then you'll provide a null stub 
> call site
> for running UP, and the real spinlock code for running SMP.
> Unfortunately, this gives the overhead of a function call, 
> both for SMP
> and for UP.  This overhead is usually _bigger_ than the overhead of a
> inlined spinlock.

Obviously moving the spinlock behind a function call would be slower.
However, I'm not sure whether this would really hurt overall kernel
performance, for two reasons: First, I would think that the requirement to
use the lock instruction would overshadow any function call overhead.
Second, I would guess that minimization of the time the kernel spins on held
locks is much more important than whether acquiring an unheld lock takes 4
instructions or 8.

Anyways, if I ever go back for my masters degree I think modularizing SMP/UP
(and looking at the performance impact) would be an interesting thesis
project ;-)

Regards -- Andy
