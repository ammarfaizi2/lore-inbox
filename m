Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSFXOg5>; Mon, 24 Jun 2002 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSFXOg4>; Mon, 24 Jun 2002 10:36:56 -0400
Received: from n123.ols.wavesec.net ([209.151.19.123]:39296 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S313508AbSFXOg4>;
	Mon, 24 Jun 2002 10:36:56 -0400
Date: Sat, 22 Jun 2002 10:34:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <landley@trommello.org>
Cc: zaimi@pegasus.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: kernel upgrade on the fly
Message-ID: <20020622083411.GF102@elf.ucw.cz>
References: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu> <20020619010945.6725B7D9@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619010945.6725B7D9@merlin.webofficenow.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Nothing is impossible for anyone impervious to reason, and you might suprise 
> us (it'd make a heck of a graduate project).  Hot migration isn't IMPOSSIBLE, 
> it's just a flipping pain in the ass.  But the issue's a bit threadbare in 
> these parts (somewhere between "are we there yet mommy?" and "can I buy a 
> pony?"). 

Actually, getting a pony is easy compared to *this* ;-).

> The SANE answer always has been to just schedule some down time for the box.  
> The insane answer involves giving an awful lot of money to Sun or IBM or some 
> such for hot-pluggable backplanes.  (How do you swap out THE BACKPLANE?  
> That's an answer nobody seems to have...)

You have two back backplanes and you use the other one during the switch?

> Clusters.  Migrating tasks in the cluster, potentially similar problem.  Look 
> at mosix and the NUMA stuff as well, if you're actually serious
> about this.  
> You have to reduce a process to its vital data, once all the resources you 
> can peel away from it have been peeled away, swapped out, freed, etc.  If you 
> can suspend and save an individual running process to a disk image (just a 
> file in the filesystem), in such a way that it can be individually re-loaded 
> later (by the same kernel), you're halfway there.  No, it's not as easy as it 
> sounds. :)

Actually, if you can select few "important" processes, and only care
about them, it can be done from userspace. Martin Mares did something
like that, involving ptrace() and lots of limitations.

> > I can see the advantage of such a thing when a server can have the kernel
> > upgraded (major or minor upgrade) without disrupting the ongoing services
> > (ok, maybe a small few-seconds delay). Another instance would be to
> > switch between different kernels in the /boot/ directory (for testing
> > purposes, etc.) without rebooting the machine.
> 
> See "belling the cat".  Yeah, it's a great idea.  The implementation's the 
> tricky bit.

My dictionary is too weak for this.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
