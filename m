Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTLCVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTLCVSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:18:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:39945 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261406AbTLCVSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:18:01 -0500
Date: Wed, 3 Dec 2003 22:14:49 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031203211449.GB11325@alpha.home.local>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <m2k75dzj6n.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2k75dzj6n.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 03, 2003 at 01:26:56PM -0800, Jan Rychter wrote:
> I am terrified of the following scenario, which is extremely probable to
> happen soon:
> 
>   1) 2.4 is being moved into "pure maintenance" mode and people are
>      being encouraged to move to 2.6.
>   2) While people slowly start using 2.6, Linus starts 2.7 and all
>      kernel developers move on to the really cool and fashionable things
>      [3].
>   3) 2.6 bug reports receive little attention, as it's much cooler to
>      work on new features than fix bugs. Bugs are not fashionable.
>   4) In the meantime, third-party vendors are confused and do not
>      support any kernel properly [4].

This was already already discussed when 2.4 was about to born. But finally
people didn't not jump that fast to 2.5 in part because early releases were
not stable enough for all developpers.

> What are my suggestions? Two main points, I guess:
> 
>   1) Please don't stop working (and that does include pulling in new
>      stuff) on 2.4, as many people still have to use it.
> 
>   2) Please don't start developing 2.7 too soon. Go for at least 6
>      months of bug-fixing. During that time, patches with new features
>      will accumulate anyway, so it isn't lost time. But it will at least
>      prevent people from saying "well, I use 2.7.45 and it works for
>      me".

I think the exact opposite. I too have been hit by recurrent API changes in
2.4. For instance, I remember I once wanted to upgrade to the latest tg3
driver because of a problem in production, but this required me to include
NAPI support in the kernel. Not that pleasant on a stable release.

I think that what incitates people to constantly break APIs and backwards
compatibility is the adding of new features in stable kernels, which is
induced by an overly long release cycle. When developpers have fresh ideas
in their head, they need to implement them right now. If you tell them "wait
6 more months before playing with the dev kernel", what happens ? They test
it on the stable one, and once it works, they propose the patch, people like
you and me find it cool, download it, pressure Marcelo to include it because
we're lazy (don't want to do the job twice), then something breaks.

The other solution: start the new devel kernel even before the stable release
so that developpers can start to play again and not only do the dirty boring
job of running after bug reports. A good developper will always try to fix a
problem in a stable kernel before playing with any other nice feature. But he
needs motivation and not frustration. So I'm totally for a permanent
development tree and regular stable releases with only bug fixes. It's about
what we have with 2.4 at the end of its life. One release every 6 months with
intermediate development releases. But in this case, it's the second digit
and not the third which should be incremented every 6 months.

> [5] Please don't tell me to buy an open-source supported 3D card. I've
>     seen such answers before and they are ridiculous. There is no such
>     card on the market if you want anything like reasonable performance.

Open a paypal account to fund development of these drivers under NDA if you
need... How can you require people you don't even know to find specifications
of closed chips on their own time to write a kernel driver for you ? If it
was that simple, I would ask that someone ports Linux to my under-used G400
so that this graphics card with lots of RAM (32 MB) could embed one more
penguin in my system !

Willy

