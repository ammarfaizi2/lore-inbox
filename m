Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVKAJKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVKAJKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVKAJKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:10:36 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51603
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964996AbVKAJKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:10:35 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: New (now current development process)
Date: Tue, 1 Nov 2005 03:09:43 -0600
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       ak@suse.de, rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010309.44013.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 18:13, Linus Torvalds wrote:
> On Mon, 31 Oct 2005, Andrew Morton wrote:
> > Are you sure these kernels are feature-equivalent?
>
> They may not be feature-equivalent in reality, but it's hard to generate
> something that has the features (or lack there-of) of old kernels these
> days. Which is problematic.
>
> But some of it is likely also compilers. gcc does insane padding in many
> cases these days.
>
> And a lot of it is us just being bloated. Argh.
>
>   Linus

Matt Mackall!  Tiny tree!  Yay rah cool!

http://selenic.com/tiny/2.6.14-tiny1-broken-out.tar.bz2

Rob

P.S. There's a reason I'm trying to make a real working development system 
based on busybox and uclibc.  I think things like live CDs should be using 
that, not the GNU packages.

There seems to be a periodic trend, where ever few years open source programs 
get feature-laden enough that somebody forks off (or starts over) a version 
that has the sole virtue of being smaller and simpler.  From glibc->uClibc, 
gnome/kde->xfce, OpenSSH->dropbear, gnu->busybox...  Of course mozilla had to 
do this twice (Galleon, then Firefox) to get something remotely reasonable, 
but oh well.

(And it'd be really NICE if tcc became a reasonable replacement for gcc.  
Guess what the bloated memory-thrashing load that selectively triggers the 
OOM killer (when swappiness=0 but not when swappiness=60) I reported earlier 
is?  Building gcc 4.0.2, genattrtab and compiling the resulting 
insn-attrab.c.  It won't run in "only" 128 megs of ram at the best of 
times...)

Rob
