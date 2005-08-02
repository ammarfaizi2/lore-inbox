Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVHBVNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVHBVNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVHBVKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:10:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14484 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261778AbVHBVIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:08:42 -0400
Date: Tue, 2 Aug 2005 23:07:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Hicks <mort@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch] remove sys_set_zone_reclaim()
Message-ID: <20050802210746.GA26494@elte.hu>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org> <20050801195426.GA17548@elte.hu> <20050802171050.GG26803@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050802171050.GG26803@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin Hicks <mort@sgi.com> wrote:

> On Mon, Aug 01, 2005 at 09:54:26PM +0200, Ingo Molnar wrote:
> > 
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > >  We could perhaps add a CAP_SYS_ADMIN-only sysctl for this hack,
> > > 
> > > That would be more appropriate.
> > > 
> > > (I'm still not sure what happened to the idea of adding a call to 
> > > "clear out this node+zone's pagecache now" rather than "set this 
> > > noed+zone's policy")
> > 
> > lets do that as a sysctl hack. It would be useful for debugging purposes 
> > anyway. But i'm not sure whether it's the same issue - Martin?
> 
> (Sorry..I was on vacation yesterday)
> 
> Yes, this is the same issue with a different way of making it happen. 
> Setting a zone's policy allows reclaim to happen automatically.
> 
> I'll send in a patch to add a sysctl to do the manual dumping of 
> pagecache really soon.

cool! [ Incidentally, when i found this problem i was looking for 
existing bits in the kernel to write such a patch myself (which i wanted 
to use on non-NUMA to create more reproducable workloads for 
performance-testing) - now i'll wait for your patch. ]

	Ingo
