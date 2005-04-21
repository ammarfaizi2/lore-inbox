Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVDVITo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVDVITo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 04:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVDVITo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 04:19:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61369 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261708AbVDVITn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 04:19:43 -0400
Date: Thu, 21 Apr 2005 21:47:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Roland Dreier <roland@topspin.com>, Troy Benjegerdes <hozer@hozed.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050421194706.GE475@openzaurus.ucw.cz>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <4263DBBF.9040801@ammasso.com> <52is2kawsi.fsf@topspin.com> <4263E53E.3090107@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263E53E.3090107@ammasso.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    Timur> Why do you call mlock() and get_user_pages()?  In our 
> >    code,
> >    Timur> we only call mlock(), and the memory is pinned.  We have a
> >    Timur> test case that fails if only get_user_pages() is called,
> >    Timur> but it passes if only mlock() is called.
> >
> >What if a buggy/malicious userspace program doesn't call mlock()?
> 
> Our library calls mlock() when the apps requests memory to be 
> "registered".  We then call munlock() when the app requests the 
> memory to be unregistered.  All apps talk to our library for all 
> services.  No apps talk to the driver directly.

That does not cover "malicious" part.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

