Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281552AbRKQAjn>; Fri, 16 Nov 2001 19:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281647AbRKQAjd>; Fri, 16 Nov 2001 19:39:33 -0500
Received: from ns.suse.de ([213.95.15.193]:39693 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281552AbRKQAjW>;
	Fri, 16 Nov 2001 19:39:22 -0500
Date: Sat, 17 Nov 2001 01:39:21 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jeff Golds <jgolds@resilience.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <3BF5B05F.9F727DD8@resilience.com>
Message-ID: <Pine.LNX.4.30.0111170133290.32578-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Jeff Golds wrote:

> > Burning out a fuse to make the switch from MP->XP may affect more
> > than just the cpuid capabilities. The fact is _we don't know_
> Right, so why assume it doesn't work?

Because there are cases where it. does. not. work.

> People with "true" SMP CPUs can have problems as well.  Does this mean
> SMP CPUs are not SMP capable?  If only one person is having problems,
> chances are there's a problem someplace.

Such problems get researched, and warnings such as the one in
my patch get added. Take a look through smpboot.c and friends.
We support a lot of broken hardware, but there's a difference between
broken (buggy) and running something outside of its specification.

>  Could it be a faulty motherboard?

The reason we have DMI table scanning on boot up.

>  Mismatched CPUs?

Another unsupported configuration we should at least warn about.
Note however, that some quad systems allow 2 different pairs.

>  Bad memory?

The reason memtest86 came to be.

>  Bad CPU?

See errata workarounds in smpboot.c & setup.c

>  Bad power supply?

Running underrated PSUs on modern hw is asking for trouble.
Unless you think AMD approved PSUs are another marketing gimmik
to make people pay out more.

>  There's an awful lot of variables here.

Sure. And this eliminates one such variable.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

