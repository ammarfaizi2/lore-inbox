Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTBNSU7>; Fri, 14 Feb 2003 13:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbTBNSU7>; Fri, 14 Feb 2003 13:20:59 -0500
Received: from almesberger.net ([63.105.73.239]:6158 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264610AbTBNSU6>; Fri, 14 Feb 2003 13:20:58 -0500
Date: Fri, 14 Feb 2003 15:30:39 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030214153039.G2092@almesberger.net>
References: <20030214120628.208112C464@lists.samba.org> <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net> <Pine.LNX.4.44.0302141500540.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302141500540.1336-100000@serv>; from zippel@linux-m68k.org on Fri, Feb 14, 2003 at 03:24:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> If you see these bugs as "unfixable", you already gave up and you end up 
> putting one band-aid over another, each only solving part of the problem.

Yup, that's what I don't like either.

> Please try work with me here and we might find a more general solution.
> I could just post possible solutions, but as long nobody understands the 
> problem, they will be rejected anyway.

Step one is to fix those "unfixable" problems. That's independent
of modules, and I'm convinced that it needs to be done.

I don't want to have to go through lots of subsystems and try to
figure our how to do their locking right, so my plan is to use a
simulator to exercise such obscure race conditions, and once the
Oops has been shown live and in color, leave the actual fixes to
the maintainers of the respective code. (And eventually, also
leave the bug hunt to others. I'm lousy at maintenance-type of
work.)

I expect to have that simulator ready for useful work on UP in
about one week. SMP will come later. (For a sneak preview, you
can look at umlsim.sourceforge.net, which has the (old) kernel
side, and at netbb/dumpbb/README.UMLSIM in netbb from
www.almesberger.net/netbb, which describes some of the
user-space side (basically a script-driven debugger).)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
