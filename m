Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRD1Hrl>; Sat, 28 Apr 2001 03:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbRD1Hrc>; Sat, 28 Apr 2001 03:47:32 -0400
Received: from 13dyn184.delft.casema.net ([212.64.76.184]:62218 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132536AbRD1Hr0>; Sat, 28 Apr 2001 03:47:26 -0400
Message-Id: <200104280747.JAA03559@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <3AE9DC22.597D94F5@sgi.com> from LA Walsh at "Apr 27, 2001 01:52:50
 pm"
To: LA Walsh <law@sgi.com>
Date: Sat, 28 Apr 2001 09:47:20 +0200 (MEST)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh wrote:
> Rogier Wolff wrote:
> 
> > > > On Linux any swap adds to the memory pool, so 1xRAM would be
> > > > equivalent to 2xRAM with the old old OS's.
> > >
> > > no more true AFAIK
> >
> > I've always been trying to convice people that 2x RAM remains a good
> > rule-of-thumb.
> 
> ---
>     Ug.  I like to view swap as "low grade memory" -- i.e. I really
> should spend 99.9% of my time in RAM -- if I spill, then it means
> I'm running too much/too big for my computer and should get more RAM --
> meanwhile, I suffer with performance degradation to remind me I'm really
> exceeding my machine's physical memory capacity.

Agreed. However, with current growing memory sizes, people are
suggesting: "I ran with 32Mb RAM and 64Mb swap until a year ago, so
128Mb ram should allow me to run swapless". I disagree.

The price-difference between RAM and disk is such (*) that if you
follow the guideline of swap=2xRAM, you're still spending 20 to 50
times as much on the RAM as you are on the disk space for swap.

Even if the swap is going to be idle 99.9% of the time, the investment
allows you to say "gosh what is the machien slow today. It might be
swapping" instead of "Why the heck has the machine crashed (#) all of
a sudden."

			Rogier. 

(*) And remains like that!

(#) Even if we have a good OOM killer, you might find the machine in a
non-workable state.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
