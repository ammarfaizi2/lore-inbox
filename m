Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267755AbTBRL5S>; Tue, 18 Feb 2003 06:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBRL5R>; Tue, 18 Feb 2003 06:57:17 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:60687 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267755AbTBRL5R>; Tue, 18 Feb 2003 06:57:17 -0500
Date: Tue, 18 Feb 2003 13:06:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030218042042.R2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302181252570.1336-100000@serv>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org>
 <20030218042042.R2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Feb 2003, Werner Almesberger wrote:

> I don't think we'll make much progress if we keep on mixing issues
> of interface correctness, current module constraints, and possible
> module interface changes, all that with performance considerations
> and minimum invasive migration plans thrown in. So I'd suggest the
> following sequence:
> 
>  1) do we agree that the current registration/deregistration
>     interfaces are potential hazards for their users, be they
>     modules or not ?
>  2) one we agree with this, we can look for mechanisms that
>     solve this, again for general users, which may or may not
>     be modules
>  3) last but not least, we can look at what this means for
>     modules (and that's where beautiful tools like
>     "module_put_return" (thanks !), or also ideas about
>     module_exit redesign have their place)
>  4) "the root of all evil ...". Okay, and now to which level
>     of hell would all this shoot our performance ? (And back
>     we go to step 2.)

Basically I can agree with this, although I'd like to avoid that we 
iterate too much over these steps, as it would too easily divert the 
discussion to other things, so I'd rather take smaller steps and keep the 
scope a bit broader.
Another point is the perfomance, which is not that important right now. 
I'm more interested in the general complexity, it's simply easier to 
optimize a simple design than a very complex design.

bye, Roman

