Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282877AbRLGR5p>; Fri, 7 Dec 2001 12:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282893AbRLGR5g>; Fri, 7 Dec 2001 12:57:36 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:31250 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S282877AbRLGR53>; Fri, 7 Dec 2001 12:57:29 -0500
Date: Fri, 7 Dec 2001 18:57:26 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Greg Hennessy <gsh@cox.rr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <9uqcsn$270$1@24-28-205-10.mf3.cox.rr.com>
Message-ID: <Pine.LNX.4.33.0112071840040.13546-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Greg Hennessy wrote:

> In article <9upmqm$7p4$1@penguin.transmeta.com>,
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > Isn't somebody ashamed of glibc and willing to try to fix it? It might
> > be as simple as just testing a static flag "have I used pthread_create"
> > or even a function pointer that gets switched around at pthread_create..
> 
> As the person who started this thread, I'll say that I'm willing to
> test new alternatives, Redhat engineers gave me a newer kernel to see
> if it helped (it didn't) and if someone can give me (or point me to) a
> glibc with better io I'm glad.
> 
> Right now I have to explain to my boss why my $4K pentium computers do
> io faster than my $20K itanium computer. And since our major software
> code is 3rd party, we can't rewrite the appilcation.

As I understand it, they just told you that the benchmark you use gives
uncorrect data on the itanium box. IIRC, you said that users were
complaing about poor performance, so I think you should investigate on
the application(s) you need instead of bonnie. Try and collect more real
world data (if possible) or at least use some other benchmarks.

If it turns out that the (hi-end, I presume) application you're using
it's both disk I/O bound and it actually uses putc(), then maybe the
problem it's just using 3rd party applications without sources... all you
have to explain to your boss is that you know what the problem is, and how
to fix it, and that the "fix" is really easy (... if only you had the
source). Add those 20K to the TCO of your closed source application.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

