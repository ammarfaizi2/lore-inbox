Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269384AbUICIRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269384AbUICIRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUICIOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:14:45 -0400
Received: from [64.147.162.83] ([64.147.162.83]:34745 "EHLO
	thunderbolt.ipaska.net") by vger.kernel.org with ESMTP
	id S269380AbUICIKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:10:44 -0400
Date: Fri, 3 Sep 2004 18:09:30 +1000
From: Luke Yelavich <luke@audioslack.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040903080930.GA30814@luke-laptop.yelavich.home>
References: <20040902215728.GA28571@elte.hu> <1094162812.1347.54.camel@krustophenia.net> <20040902221402.GA29434@elte.hu> <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094197233.19760.115.camel@krustophenia.net>
User-Agent: Mutt/1.4.2.1i
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thunderbolt.ipaska.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - audioslack.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 05:40:34PM EST, Lee Revell wrote:
> On Fri, 2004-09-03 at 03:05, Ingo Molnar wrote:
> > another question - any objections against me rebasing the VP patch to
> > the current -mm tree and keeping it there exclusively until all possible
> > merges are done? It would probably quite some work to create a complete
> > patch for the upstream or BK tree during that process, as small patches
> > start to flow in the VP => -mm => BK direction. Would any of the regular
> > VP users/testers be wary to use the -mm tree?
> > 
> 
> None here.  Assuming the SMP issues are resolved, then the only
> remaining issues on UP will probably be with various drivers, those
> fixes should apply just as easily to -mm as vanilla.
> 
> As far as I am concerned the VP patches are stable enough for the
> audio-centric distros to start distributing VP kernel packages, these
> will certainly be using the vanilla kernel.  I think the PlanetCCRMA and
> AGNULA people are planning to start distributing test VP-kernel packages
> as soon as the patches stabilize.  IIRC Nando is on vacation this week.

I certainly have intensions of making test kernels available in my repository
in a separate testing branch. I don't really mind for myself what tree the
patch is based on, but I feel that the patches may get more testing if they
are against vanilla, rather than against another tree, as users 
may consider the patch to be more stable. On the other hand, it is not hard for
packagers like myself to do the leg work, and we can also provide a pre-patched
kernel source for those who still want to roll their own.

> I will make an announcement on LAD that as of R0 the VP patches should
> be stable and are ready for wider testing.  You may want to wait until
> after the initial slew of bug reports before rebasing VP against MM.  I
> suspect most of the problems with be driver specific, and most of the
> fixes will apply equally to -mm and vanilla.

Well with Lee's help, I think I have identified an ICE1712 sound driver issue,
but this is yet to be determined.

> I have added Luke (AudioSlack), Free (AGNULA), and Nando (CCRMA) to the
> cc: list.  They would be in the best position to answer your question.

I will go with whatever is decided, as I am prepared to do the legwork for my
repository users.
-- 
Luke Yelavich
http://www.audioslack.com
luke@audioslack.com
