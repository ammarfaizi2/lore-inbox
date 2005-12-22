Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVLVN5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVLVN5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVLVN5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:57:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6418 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932479AbVLVN5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:57:20 -0500
Date: Thu, 22 Dec 2005 14:57:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
       Michael Madore <michael.madore@gmail.com>,
       David Brownell <david-b@pacbell.net>, Greg KH <gregkh@suse.de>,
       paulmck@us.ibm.com, Gottfried Haider <gohai@gmx.net>,
       luca.risolia@studio.unibo.it, "P. Christeas" <p_christ@hol.gr>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Message-ID: <20051222135718.GA27525@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051222011320.GL3917@stusta.de> <20051222005209.0b1b25ca.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222005209.0b1b25ca.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:52:09AM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > The following bugs in the kernel Bugzilla [1] contain regressions in 
> > 2.6.15-rc compared to 2.6.14 with patches:
> 
> Thanks for tracking this.  Although I fear it won't come to much.

People had been complaining about a lack of testing prior to the final 
release of a kernel.

If this was meant serious, we should try hard to fix all regressions 
reported by people who do test -rc and -git kernels.

> non-bugzilla post-2.6.14 bugs which I've squirelled away include:
> 
> 
> From: Brice Goglin <Brice.Goglin@ens-lyon.org>
> Subject: Linux 2.6.14: Badness in as-iosched

As the subject says, this is not a post-2.6.14 regression.

Besides this, Jens (Cc'ed) sent a patch for it:
  http://lkml.org/lkml/2005/11/20/119

Was there a reason why it wasn't applied?

> From: Charles-Edouard Ruault <ce@ruault.com>
> Subject: [BUG] kernel 2.6.14.2 breaks IPSEC

As the subject says, this is not a post-2.6.14 regression.

And reading the discussion on netdev, it seems this wasn't ever expected 
to work without additional netfilter patches.

> From: Michael Madore <michael.madore@gmail.com>
> Subject: USB handoff, irq 193: nobody cared!

If this is still present, David should look into it:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0511.1/2243.html

> From: Wu Fengguang <wfg@mail.ustc.edu.cn>
> Subject: BUG: spinlock recursion on 2.6.14-mm2 when oprofiling

If this affects Linus' tree, a patch for it is in -mm.

> From: Miles Lane <miles.lane@gmail.com>
> Subject: 2.6.15-rc2-git6 + ipw2200 1.0.8 -- Slab corruption

As the subject says, this is a problem when using an external version of 
this driver.

> From: "Gottfried Haider" <gohai@gmx.net>
> Subject: [2.6.15-rc2] 8139too probe fails (pci related?)

According to the report perhaps not a post-2.6.14 regression.

But anyways, this should be better debugged.

@Gottfried:
Does it work with kernel 2.6.14.4?
Does it work with kernel 2.6.15-rc6?
If it stil fails, can you send a complete dmesg for 2.6.15-rc6?

> From: Steve Work <swork@aventail.com>
> Subject: Multi-thread corefiles broken since April

As the subject says, this is not a post-2.6.14 regression.

> From: Diego Calleja <diegocg@gmail.com>
> Subject: Oops with w9968cf

@Luca, Greg:
  http://lkml.org/lkml/2005/12/12/91

> From: John Reiser <jreiser@BitWagon.com>
> Subject: control placement of vDSO page

This is not a post-2.6.14 regression.

> From: "P. Christeas" <p_christ@hol.gr>
> Subject: No sound from CX23880 tuner w. 2.6.15-rc5

No answer by the submitter when being asked for more information.

> Subject: x86_64 timekeeping buglets
> From: Jim Houston <jim.houston@comcast.net>

Reported against 2.6.13, therefore not a post-2.6.14 regression.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

