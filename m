Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVACAjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVACAjs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVACAjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:39:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18701 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261360AbVACAjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:39:02 -0500
Date: Mon, 3 Jan 2005 01:38:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: William Lee Irwin III <wli@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103003857.GJ4183@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <20050102214211.GM29332@holomorphy.com> <20050102221534.GG4183@stusta.de> <20050103001917.GO29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103001917.GO29332@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 04:19:17PM -0800, William Lee Irwin III wrote:
> On Sun, Jan 02, 2005 at 01:42:11PM -0800, William Lee Irwin III wrote:
> >> This is not optimism. This is experience. Every ``stable'' kernel I've
> >> seen is a pile of incredibly stale code where vi'ing any file in it
> >> instantly reveals numerous months or years old bugs fixed upstream.
> >> What is gained in terms of reducing the risk of regressions is more
> >> than lost by the loss of critical examination and by a long longshot.
> 
> On Sun, Jan 02, 2005 at 11:15:34PM +0100, Adrian Bunk wrote:
> > The main advantage with stable kernels in the good old days (tm) when 4 
> > and 6 were even numbers was that you knew if something didn't work, and 
> > upgrading to a new kernel inside this stable kernel series had a 
> > relatively low risk of new breakages. This meant one big migration every 
> > few years and relatively easy upgrades between stable series kernels.
> 
> This never saved anyone any pain. 2.4.x was not the stable kernel
> you're painting it to be until 2.4.20 or later, and by the time it
> became so the fixes for major regressions that occurred during 2.3.x
> were deemphasized and ignored for anything prior to 2.6.x.

I don't know which specific regressions you have in mind, but for
> 95% of the users 2.4 is a pretty usable kernel.

> On Sun, Jan 02, 2005 at 11:15:34PM +0100, Adrian Bunk wrote:
> > Nowadays in 2.6, every new 2.6 kernel has several regressions compared 
> > to the previous one, and additionally obsolete but used code like 
> > ipchains and devfs is scheduled for removal making upgrades even harder 
> > for many users.
> 
> My experience tells me that the number of regressions in 2.6.x compared
> to purportedly ``far stabler'' kernels is about the same or (gasp!)
> less. So the observable advantage of the ``frozen'' or ``stable'' model
> is less than or equal to zero.
> 
> Frankly, kernel hacking is a difficult enough task (not that I
> personally find it so) that frivolous patches are not overwhemingly
> numerous. The ``barrier'' you're erecting is primarily acting as a
> barrier to fixes, not bugs.

My point is different.

Perhaps the number of fixes for bugs equals the number of new bugs
in 2.6 . 

But it's not about the number of bugs alone. The question is the number 
of regressions compared to a previous kernel in this series.

2.4 -> 2.6 is a major migration.

2.4.27 -> 2.4.28 is a kernel upgrade that is very unlikely to cause 
problems.

Compared to this, 2.6.9 -> 2.6.10 is much more likely to break an 
existing setup that worked in 2.6.9 .

> On Sun, Jan 02, 2005 at 11:15:34PM +0100, Adrian Bunk wrote:
> > There's the point that most users should use distribution kernels, but 
> > consider e.g. that there are poor souls with new hardware not supported 
> > by the 3 years old 2.4.18 kernel in the stable part of your Debian 
> > distribution.
> 
> Again, the loss of critical examination far outweighs the purported
> defense against regressions. The most typical result of playing the fix
> backporting game for extended periods of time is numerous rounds of
> months-long bughunts for bugs whose fixes were merged years ago upstream.
> When the bugs are at long last found, they are discovered to fix the
> problems of hundreds of users until the next such problem surfaces.

The main question is, whether it might be possible to make a very short 
2.7 line (< 6 months).

Imagine e.g. a feature freeze for 2.6 now. Then 2.7 starts with a 
feature freeze for 2.7 one or two months later. During this time, all 
the changes that do now flood into 2.6 would go into 2.7, and then 
there are a few months of stabilizing 2.7 .

It's quite the opposite of the current 2.6 model, but a quick 2.8 should 
also avoid this problem you describe.

Basically, in this proposal (if it started today), what was expected to 
be called 2.6.11 will be called 2.7.0, and 2.6.11 will be a bugfix-only 
kernel (considering the amount of changes more like the current -ac than 
the latest -mm).

> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

