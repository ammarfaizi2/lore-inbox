Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUAHP3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUAHP3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:29:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1668 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265147AbUAHP3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:29:17 -0500
Date: Thu, 8 Jan 2004 16:28:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Jesper Juhl <juhl@dif.dk>, joe@perches.com, juhl-lkml@dif.dk,
       linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk,
       andrea@e-mind.com, manfred@colorfullife.com
Subject: Re: [PATCH] mm/slab.c remove impossible <0 check - size_t is not signed - patch is against 2.6.1-rc1-mm2
Message-ID: <20040108152822.GC8774@suse.de>
References: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk> <1073531294.2304.18.camel@localhost.localdomain> <Pine.LNX.4.56.0401081032590.10083@jju_lnx.backbone.dif.dk> <20040108021658.0a8aaccc.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108021658.0a8aaccc.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08 2004, Paul Jackson wrote:
> Jason asked:
> > Well, anything wrong in cleaning them [unsigned compare warnings] up?
> 
> It's more important that we write code that will fit in our limited
> human brains than that we write code that will avoid spurious warnings
> from gcc ('spurious' meaning warnings for code that gcc will correctly
> compile anyway).
> 
> Or, see a couple months ago, in a thread with the Subject of:
> 
>   [PATCH] irda: fix type of struct irda_ias_set.attribute.irda_attrib_string.len
> 
> in which Linus wrote:
> > That's why I hate the "sign compare" warning of gcc so much - it warns 
> > about things that you CANNOT sanely write in any other way. That makes 
> > that particular warning _evil_, since it encourages people to write crap 
> > code.

That's fine and has its place, no doubt about that. It doesn't cover the
patch in this thread though. The check is dead code. It's a cosmetic
problem though, gcc should not generate the code checking for < 0.

-- 
Jens Axboe

