Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSKHVa5>; Fri, 8 Nov 2002 16:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSKHVa5>; Fri, 8 Nov 2002 16:30:57 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11268 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262448AbSKHVa4>;
	Fri, 8 Nov 2002 16:30:56 -0500
Date: Tue, 15 Jan 2002 12:44:28 -0500
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: andrew@pimlott.net, linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20020115174416.GC2015@zaurus>
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <p7365vptz49.fsf@oldwotan.suse.de> <20021026190906.GA20571@pimlott.net> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net> <20021028053004.C2558@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028053004.C2558@wotan.suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The point of my patchkit is to allow the file systems
> who support better resolution to handle it properly. Other filesystems
> are not worse than before when they flush inodes (and better off when
> they keep everything in ram for your build because then they will enjoy 
> full time resolution) 

What about always rounding down even when inode is
in memory? That is both simple and consistent.

> If you really wanted that I would recommend to change make.
> When all nanosecond parts are 0 it is reasonable for make to assume that
> the fs doesn't support finegrained resolution. But I'm not sure it's 
> worth it.

Thats really ugly heuristics. What about filling
nanosecond part with ~0 when unavailable?

			Psvel
