Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319195AbSHWTsu>; Fri, 23 Aug 2002 15:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319217AbSHWTsu>; Fri, 23 Aug 2002 15:48:50 -0400
Received: from [195.39.17.254] ([195.39.17.254]:22656 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319195AbSHWTst>;
	Fri, 23 Aug 2002 15:48:49 -0400
Date: Fri, 2 Nov 2001 05:55:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] complain about unknown CLONE_* flags
Message-ID: <20011102055542.N35@toy.ucw.cz>
References: <20020815233802.A30018@kushida.apsleyroad.org> <Pine.LNX.4.44.0208161207450.3782-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0208161207450.3782-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Aug 16, 2002 at 12:17:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ingo, how do you handle this sort of backward compatibility in your
> > latest pthreads library, or don't you do backward compatibility?
> 
> [btw., it's not me doing it but Ulrich Drepper. I'm mostly doing the 'lets
> find out how the kernel could help' side of things.]
> 
> the proper way of doing this is a way of getting fundamental kernel
> capabilities, not the 'probing' of the kernel in various ways. Glibc
> starts looking like old ISA drivers trying to do nonintrusive
> autodetection: 'lets try this port carefully without disturbing state,
> perhaps this feature is there'.
> 
> one way to handle this cleanly would be to add a kernel capabilities
> bitmask to sysconf(), and backport this to all mainstream Linux kernels

I'm afraid that bitmask will get out-of-date. Doing EINVAL seems like a good
way to do this. [Hmm, perhaps we need CLONE_DONT which only checks capabilities
and returns? It still seems better than sysconf...]
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

