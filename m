Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVFBHPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFBHPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVFBHPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:15:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18304 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261588AbVFBHPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:15:05 -0400
Date: Thu, 2 Jun 2005 09:14:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Freezer Patches.
Message-ID: <20050602071431.GA1841@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost> <20050601130205.GA1940@openzaurus.ucw.cz> <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz> <1117665934.19020.94.camel@gaston> <20050601230235.GF11163@elf.ucw.cz> <1117676753.10888.105.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117676753.10888.105.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > swsusp1 should not need any special casing of sync, right? We can
> > > > simply do sys_sync(), then freeze, or something like that. We could
> > > > even remove sys_sync() completely; it is not needed for correctness.
> 
> Wrong. I guess you're only trying it on a machine that isn't actually
> doing anything :). I've forgotten whether it was this freezer
> implementation or the last, but we've been testing freezing processes
> when the load average exceeds 100. If you have a thread that is syncing
> and another that's submitting I/O continually (think dd, for example),
> you want this.

If sys_sync() is not working, *fix sys_sync()*. [BTW I see that
problem before and I think it is being worked on.] I'm *not* going to
work around it in refrigerator.

								Pavel

