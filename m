Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319369AbSIFUxT>; Fri, 6 Sep 2002 16:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319392AbSIFUwI>; Fri, 6 Sep 2002 16:52:08 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8064 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319389AbSIFUwF>;
	Fri, 6 Sep 2002 16:52:05 -0400
Date: Fri, 6 Sep 2002 11:31:30 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020906113129.E39@toy.ucw.cz>
References: <20020828223939.C816@brodo.de> <Pine.LNX.4.33.0208281400330.16824-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0208281400330.16824-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 28, 2002 at 02:05:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > #3 Then the cpufreq driver is called to actually set the CPU frequency. 
> > 
> > #3 is absolutely ready
> 
> #3 is _not_ ready, if it doesn't include a "policy" part in addition to
> the frequency. That was what I started off talking about: on some CPU's
> you absolutely do _not_ want to set a hard frequency, you want to tell the
> CPU how to behave (possibly together with a frequency _range_).
> 
> Until that is done, no other upper layers can use this low-level 
> functionality, since all upper layers would be forced to come up with a 
> hard frequency goal.
> 
> THAT is the problem. If you want to build infrastructure for upper layers, 
> then that infrastructure has to be able to pass down sufficient 
> information from those upper layers.

So... would you take a patch that passed range down to cpufreq "core"?

Dumb cpus would set speed to upper limit while smart cpus would get all
the info...

									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

