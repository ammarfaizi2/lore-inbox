Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267701AbTBRHLq>; Tue, 18 Feb 2003 02:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTBRHLq>; Tue, 18 Feb 2003 02:11:46 -0500
Received: from almesberger.net ([63.105.73.239]:3848 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267701AbTBRHLn>; Tue, 18 Feb 2003 02:11:43 -0500
Date: Tue, 18 Feb 2003 04:20:42 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Roman Zippel <zippel@linux-m68k.org>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030218042042.R2092@almesberger.net>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218050349.44B092C04E@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Feb 18, 2003 at 03:54:12PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grr, I hate this. I just typed a long reply to your posting, and
wanted to finish it with a reminder that the issue is more general
than just modules, so that we shouldn't look at modules yet. Then
I realized of course that everything above was about modules :-(

I don't think we'll make much progress if we keep on mixing issues
of interface correctness, current module constraints, and possible
module interface changes, all that with performance considerations
and minimum invasive migration plans thrown in. So I'd suggest the
following sequence:

 1) do we agree that the current registration/deregistration
    interfaces are potential hazards for their users, be they
    modules or not ?
 2) one we agree with this, we can look for mechanisms that
    solve this, again for general users, which may or may not
    be modules
 3) last but not least, we can look at what this means for
    modules (and that's where beautiful tools like
    "module_put_return" (thanks !), or also ideas about
    module_exit redesign have their place)
 4) "the root of all evil ...". Okay, and now to which level
    of hell would all this shoot our performance ? (And back
    we go to step 2.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
