Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVADQ6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVADQ6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVADQyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:54:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25613 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261708AbVADQxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:53:03 -0500
Date: Tue, 4 Jan 2005 17:53:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104165301.GF3097@stusta.de>
References: <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104153445.GH2708@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 07:34:45AM -0800, William Lee Irwin III wrote:
> On Tue, Jan 04, 2005 at 04:57:38AM -0800, William Lee Irwin III wrote:
> >> No amount of testing coverage will ever suffice. You're trying to
> >> empirically establish the nonexistence of something, which is only
> >> possible to repudiate, and never to verify.
> 
> On Tue, Jan 04, 2005 at 04:08:10PM +0100, Adrian Bunk wrote:
> > I claim:
> > The less and the less invasive patches go into the kernel, the less 
> > likely are breakages.
> > "enough" shouldn't say "mathematically exactly proven that no 
> > regressions exist" but more something like the pretty small number of 
> > regressions in recent 2.4 kernels.
> 
> The less that happens, the less likely it is for anything to happen.
> You're effectively arguing that very little should happen.
> 
> This cannot be, because pure bugfixing activity alone would overwhelm
> the limits on levels of activity you endorse. When it comes to design
> flaws, a single fix for such would swamp the limits on activity you've
> imposed for a significant portion of a year.

My opinion is to fork 2.7 pretty soon and to allow into 2.6 only the 
amount of changes that were allowed into 2.4 after 2.5 forked.

Looking at 2.4, this seems to be a promising model.

> If you want more stability and fewer regressions, look for methods of
> getting more peer review for patches, not fewer patches.

This is only one source of problems, that increases with the amount of 
changes and decreases with the amount of review.

Another source is the interaction of correct patches with other code. An 
example are (were?) the problems with 4kB stacks on i386 with XFS.

And then there are issues that are not bugs in the code, but user errors 
that have to be avoided. An example is CONFIG_BLK_DEV_UB in 2.6.9, which 
even the Debian kernel maintainers got wrong in the first kernel 
packages they did put into Debian unstable.

> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

