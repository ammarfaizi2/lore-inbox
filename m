Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVHEH7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVHEH7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVHEH63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:58:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7066 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262905AbVHEH6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:58:23 -0400
Date: Tue, 1 Jan 2002 11:33:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: tony@atomide.com, linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove i386 dynamic ticks ifdefs
Message-ID: <20020101103339.GC467@openzaurus.ucw.cz>
References: <200507291206.46261.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507291206.46261.kernel@kolivas.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I assume you're maintaining the dyn tick patches for i386 posted on the muru 
> website as your email is listed there. I thought you might be interested in 
> this patch for dyn-ticks which removes most of the #ifdefs out of common code 
> paths as per linux kernel style and moves more code into dyn-tick.c. Most of 
> it is straight forward code reorganisation, but to keep do_timer_interrupt 
> inlined I'd have to move it's code around somewhat. That may be a better 
> option but I've tried to fiddle with the mainline code as little as possible.
> 
> Patch applies to 2.6.12 with patch-dynamic-tick-2.6.12-rc6-050610-1 applied
> 
> cc'ed lkml just for public record of the patch.

Please inline patches...

You broke indentation in one of first hunks, and you probably
want empty functions to be static inline, so that we do not eat
function call overhead.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

