Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWGTK4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWGTK4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 06:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWGTK4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 06:56:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44040 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030284AbWGTK4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 06:56:48 -0400
Date: Thu, 20 Jul 2006 12:56:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060720105647.GI25367@stusta.de>
References: <20060711160639.GY13938@stusta.de> <Pine.LNX.4.64.0607131201050.28976@schroedinger.engr.sgi.com> <1152937109.27135.101.camel@localhost.localdomain> <Pine.LNX.4.64.0607142152420.9010@schroedinger.engr.sgi.com> <1153097630.17406.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153097630.17406.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 08:53:50PM -0400, Steven Rostedt wrote:
> On Fri, 2006-07-14 at 21:59 -0700, Christoph Lameter wrote:
> 
> > > Now for the vmstat.h, I just tried removing that, and it seems that this
> > > is a candidate to be removed from mm.h since mm.h compiles fine without
> > > it. But vmstat.h doesn't compile without mm.h.  So it seems that we
> > > should add mm.h to vmstat.h, remove vmstat.h from mm.h and for those .c
> > > files that break, just add vmstat.h to them.
> > 
> > Great if you can detangle that.
> 
> Are you supporting the effort if I send in patches that removes the
> vmstat.h and then goes and tries to find all the places that fail to
> compile because of the removal and adds vmstat.h directly, that the
> patches would get accepted?
> 
> It would probably need to go into -mm for a bit just to find those
> places I missed.
> 
> This wouldn't be a problem to do and can be accomplished rather quickly,
> but I wont waste any time on it if it is doomed at the start.

It sounds good.

I've created a git tree [1] including all my cleanups work, and I'd also 
include your patch.

> -- Steve

cu
Adrian

[1] git://git.kernel.org/pub/scm/linux/kernel/git/bunk/hdrcleanup.git

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

