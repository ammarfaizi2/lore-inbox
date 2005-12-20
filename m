Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVLTPAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVLTPAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVLTPAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:00:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44299 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750726AbVLTPAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:00:35 -0500
Date: Tue, 20 Dec 2005 16:00:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: About 4k kernel stack size....
Message-ID: <20051220150033.GF6789@stusta.de>
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de> <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 09:37:28AM -0500, Mike Snitzer wrote:
> On 12/20/05, Adrian Bunk <bunk@stusta.de> wrote:
> > On Mon, Dec 19, 2005 at 09:52:53PM -0500, Mark Lord wrote:
> > >...
> > > The mainline code paths are undoubtedly fine with 4K stacks.
> > > It's the *error paths* that are most likely to go deeper on the stack,
> > > and those are rarely exercised by anyone.  And those are the paths
> > > that we *really* need to be reliable.
> >
> > "most likely" is a strong sentence, especially considering that the
> > automatic analysis of all possible call chains can and has already
> > identified several such problems (which have now been fixed many months
> > ago).
> >
> > We might not getting 100% security against stack overflows, but that's
> > not fundamentally different from the current situation with 6 kB stacks.
> 
> Given this last statement, why is it that Matt Mackall's suggestion in
> the "Light-weight dynamically extended stacks" thread didn't get any
> _real_ discussion from the big 4K stack advocates?  For all intents
> and purposes, Matt was dismissed with the same Bunk: "Ever since
> neilb's patch there are 0 bugs.. blah blah".  4K, 8K (aka "6 kB")
> aside; having more stack safety in the Linux kernel is a "good thing"
> no?  Aren't dynamic stacks a viable means to imposing 4K (but doing so
> with real safety)?

Besides the fact that I still don't think it's requred, Matt's 
suggestion would work only randomly for functions using more than 1 kB 
stack.

But discussing hypothetical patches is silly - code talks.

If someone sends a patch implementing Mark's suggestion and it gets 
measured that this patch doesn't impose a performance penalty we'd
have a basis for a real discussion.

> Mike

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

