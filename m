Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVANHzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVANHzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 02:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVANHzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 02:55:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:9119 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261536AbVANHzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 02:55:36 -0500
Date: Thu, 13 Jan 2005 23:55:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, paul@linuxaudiosystems.com,
       nickpiggin@yahoo.com.au, lkml@s2y4n2c.de, rlrevell@joe-job.com,
       arjanv@redhat.com, joq@io.com, chrisw@osdl.org, hch@infradead.org,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050113235534.L24171@build.pdx.osdl.net>
References: <1105669451.5402.38.camel@npiggin-nld.site> <200501140240.j0E2esKG026962@localhost.localdomain> <20050113191237.25b3962a.akpm@osdl.org> <20050114065701.GG2940@waste.org> <20050113230423.3b14fa33.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050113230423.3b14fa33.akpm@osdl.org>; from akpm@osdl.org on Thu, Jan 13, 2005 at 11:04:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > The closest thing to concensus I've seen yet was a new rlimit for
> >  scheduling with code from Chris Wright.
> 
> hmm, yes.  It doesn't feel like an rlimity thing to me, unless the rlimit
> actually _limits_ something.  Say, minimum permissible nice level.  But
> scheduling policy sounds more like a capability than an rlimit.

It's had a few incarnations with minor tweaks.  But they each did
provide a limit, an upper bound, on how the user could prioritize it's
task with the scheduler (both nice values and rt priorities).

> >  We really ought not get in
> >  the habit of adding new rlimits though.
> 
> How come?  It's a real pita that the standard shells don't appear to have a
> way of setting an unknown rlimit.  But what else?

It's got that slippery slope feeling.  When do you decided that you're
just punting everything to an rlimit and it becomes an unmanaged mess?
However, in this case, at least it's easy to justify cpu time as a
resource.  I'll repost in the AM...sleep calls.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
