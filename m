Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285570AbRLGViJ>; Fri, 7 Dec 2001 16:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285569AbRLGVhz>; Fri, 7 Dec 2001 16:37:55 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:33541 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S285566AbRLGVhe>; Fri, 7 Dec 2001 16:37:34 -0500
Date: Fri, 7 Dec 2001 22:37:31 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Greg Hennessy <gsh@cox.rr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <9ur9ml$5jp$1@24-28-205-10.mf3.cox.rr.com>
Message-ID: <Pine.LNX.4.33.0112072223560.13546-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Greg Hennessy wrote:

> In article <Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>,
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > bonnie is a _benchmark_. It's meant for finding bad performance. Changing
> > it to make it work better when performance is bad is _pointless_. You've
> > now made the whole point of bonnie go away.
> 
> It isn't just bonnie showing bad performance. My application shows it,
> bonnie shows it, and tiobench shows it. I think the focus on putc
> may be too intense. It isn't suprizing to me that either the kernel
> or glibc may not be optimised on ia64, I'm just trying to figure out
> how to get better io rates out of my itanium machine.

Does a simple 'dd' show the problem? I mean,

time dd if=/dev/zero of=/somelargefile count=somelargenumber bs=8k

is it much slower on the itanium, too? dd doesn't use putc(), I hope.

Just for comparison, I've run the following command here:

# time dd if=/dev/zero of=/u2/test count=250000 bs=8k
250000+0 records in
250000+0 records out
0.14user 12.95system 1:23.15elapsed 15%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (117major+18minor)pagefaults 0swaps

(Almost idle box, 256MB RAM, UDMA disk, 2.2.x kernel)

You may try with a bigger file, expecially if you have more RAM.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

