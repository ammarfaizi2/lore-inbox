Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTIMQym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTIMQym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:54:42 -0400
Received: from gprs148-167.eurotel.cz ([160.218.148.167]:16001 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261670AbTIMQyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:54:39 -0400
Date: Sat, 13 Sep 2003 18:54:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: richard.brunner@amd.com
Cc: ak@suse.de, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030913165425.GC527@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C0638B19A@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B19A@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  > > What's wrong with the current status quo that just says 
> > >  > > "Athlon prefetch is broken"?
> > >  > It doesn't fix user space for once.
> > > 
> > > And for another, it cripples the earlier athlons which 
> > > don't have this
> > > errata. Andi's fix at least makes prefetch work again on 
> > > those boxes.
> > > It's also arguable that prefetch() helps the older K7's 
> > > more than the
> > > affected ones.
> > 
> > All Athlons have this Errata. I can trigger it on an old
> > 900Mhz pre XP Athlon too. You just have to use 3dnow prefetch
> > instead of SSE prefetch.
> > 
> > BTW the older Athlons currently don't use prefetch because 
> > the alternative
> > patcher does not handle 3dnow style prefetch.
> > 
> 
> Avoiding prefetch for all Athlons and earlier Opterons/Athlon64
> even in the kernel can really tank performance. And as Andi says
> it still doesn't solve user mode from hitting the errata.

How much speedups can be expected from prefetch? 5%?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
