Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVLOWaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVLOWaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVLOWaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:30:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16651 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751157AbVLOW37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:29:59 -0500
Date: Thu, 15 Dec 2005 23:30:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051215223000.GU23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215140013.7d4ffd5b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:00:13PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This patch was already sent on:
> > - 11 Dec 2005
> > - 5 Dec 2005
> > - 30 Nov 2005
> > - 23 Nov 2005
> > - 14 Nov 2005
> 
> Sigh.  I saw the volume of email last time and though "gee, glad I wasn't
> cc'ed on that lot".

If you substract the "this breaks my binary-only M$ Windows driver" 
emails there's not much volume left.

> Supporting 8k stacks is a small amount of code and nobody has seen a need
> to make changes in there for quite a long time.  So there's little cost to
> keeping the existing code.
> 
> And the existing code is useful:
> 
> a) people can enable it to confirm that their weird crash was due to a
>    stack overflow.
> 
> b) If I was going to put together a maximally-stable kernel for a
>    complex server machine, I'd select 8k stacks.  We're still just too
>    squeezy, and we've had too many relatively-recent overflows, and there
>    are still some really deep callpaths in there.

a1) People turn off 4k stacks and never report the problem / noone 
    really debugs and fixes the reported problem.

Me threatening people with enabling 4k stacks for everyone already 
resulted in several fixes.

An how many weird crashes with _different_ causes have you seen?
It could be that there are only _very_ few problems that noone really 
debugs brcause disabling 4k stacks fixes the issue.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

