Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbSJASDX>; Tue, 1 Oct 2002 14:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262519AbSJASDL>; Tue, 1 Oct 2002 14:03:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54196 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262512AbSJASCp>;
	Tue, 1 Oct 2002 14:02:45 -0400
Date: Tue, 1 Oct 2002 20:04:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Richard.Zidlicky@stud.informatik.uni-erlangen.de, zippel@linux-m68k.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4 mm trouble [possible lru race]
Message-ID: <20021001180442.GI5755@suse.de>
References: <Pine.LNX.4.44L.0210011356300.653-100000@duckman.distro.conectiva> <E17wQXN-0005vL-00@starship> <20021001173119.GY3867@suse.de> <E17wRKZ-0005vf-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17wRKZ-0005vf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Daniel Phillips wrote:
> On Tuesday 01 October 2002 19:31, Jens Axboe wrote:
> > On Tue, Oct 01 2002, Daniel Phillips wrote:
> > > On Tuesday 01 October 2002 18:56, Rik van Riel wrote:
> > > > On Tue, 1 Oct 2002, Daniel Phillips wrote:
> > > > > On Tuesday 01 October 2002 16:20, Richard.Zidlicky@stud.informatik.uni-erlangen.de wrote:
> > > > > > no preempt or anything fancy, m68k vanila 2.4.19 (well almost).
> > > > >
> > > > > Vanilla would be CONFIG_SMP=y, is that what you have?
> > > > 
> > > > Somehow I doubt Linux supports m68k SMP machines ;)
> > > 
> > > CONFIG_SMP=y works perfectly well on single cpu machines - it forces
> > > the spinlocks to actually exist.  It's not supposed to change any
> > > behaviour, but you never know.  Behaviour is obviously changing here.
> > 
> > Again, m68k was the target.
> 
> Sure fine, no good reason to be cryptic about it though.
> 
>    #error "m68k doesn't do SMP yet"
> 
> So SMP must be off or the compile would abort.  Well, the only interesting

There's no CONFIG_SMP in the m68k arch config.in. Anyways, enough
beating of dead horse :)

-- 
Jens Axboe

