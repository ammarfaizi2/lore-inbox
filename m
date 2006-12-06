Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759847AbWLFDaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759847AbWLFDaE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 22:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759856AbWLFDaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 22:30:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48406 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759847AbWLFDaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 22:30:01 -0500
Date: Tue, 5 Dec 2006 20:30:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061205203013.7073cb38.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612060348150.1868@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org>
	<Pine.LNX.4.64.0612060348150.1868@scrub.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 6 Dec 2006 03:59:41 +0100 (CET) Roman Zippel <zippel@linux-m68k.org> wrote:
> Hi,
> 
> On Mon, 4 Dec 2006, Andrew Morton wrote:
> 
> > [dyntick]
> > 
> >  Shall merge, I guess.  My confidence is low, but it's Kconfigurable and it
> >  needs to get sorted out.
> 
> IMO it least at needs one more iteration to address the comments that 
> were made (not just mine), in the short term the less it touches 
> unconditionally the less I care right now.

I don't have a clue which review comments remain unaddressed - do you recall?

I never saw an item-by-item accounting of my own (extensive) review
comments, actually.  And then an avalanche of new stuff got sent and I
didn't have time to go through it all at the same level of detail.

So yeah, I don't have a lot of confidence from that POV either.  But otoh,
I'm confident that Ingo and Thomas will competently and promptly address
regressions, so the risk factor isn't too bad.  And changing APIC and
timekeeping code sure is risky.

Yes, I too am wobbly about a 2.6.20 merge.  But otoh I doubt if much will
get changed if it sits in -mm for another two months.  As long as it's
heading in the right direction and doesn't break things when it is
configged-off then OK.

> In the long term IMO this might need a major rework, the basic problem I 
> have is that I don't see how this usable beyond dynticks/hrtimer, e.g. how 
> to dynamically manage multiple timer.

I'm not sure I understand that.  Are you referring to multiple,
concurrently-operating hardware clock sources?  <wonders how that could
work> If so, that's more a clocksource thing than a dynticks/hrtimer thing,
isn't it?

