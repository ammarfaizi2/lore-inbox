Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbTCRIHP>; Tue, 18 Mar 2003 03:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbTCRIHP>; Tue, 18 Mar 2003 03:07:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54286 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262243AbTCRIHO>; Tue, 18 Mar 2003 03:07:14 -0500
Date: Tue, 18 Mar 2003 09:18:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>, akpm@digeo.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't refill pcp lists during SWSUSP.
Message-ID: <20030318081809.GB10472@atrey.karlin.mff.cuni.cz>
References: <1047945372.1714.19.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047945372.1714.19.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's another patch (the last for a little while, I promise!). It stops
> the pcp lists from being refilled while SWSUSP is running. Despite the
> comment in the page, drain_local_pages does only need to get called once
> right now, but I have patches coming that will (DV) change that. This
> patch is thus groundwork for them.

This adds external (and pretty  ugly) dependency of swsusp on the
outside. And as it still needs to drain_local_pages(), nothing is
gained. I believe it is better to just call drain_local_pages few
times. Magic hooks "if suspending, don't do this" seem like wrong
approach to me.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
