Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbUKOTGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUKOTGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbUKOTGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:06:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63386 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261666AbUKOTGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:06:00 -0500
Subject: Re: [PATCH] __init and i386 timers
From: john stultz <johnstul@us.ibm.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041113232203.GA23484@apps.cwi.nl>
References: <20041113232203.GA23484@apps.cwi.nl>
Content-Type: text/plain
Message-Id: <1100545499.21267.29.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Nov 2004 11:04:59 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-13 at 15:22, Andries Brouwer wrote:
> The i386 timers use a struct timer_opts that has a field init
> pointing at a __init function. The rest of the struct is not __init.
> 
> Nothing is wrong, but if we want to avoid having references to init stuff
> in non-init sections, some reshuffling is needed.

Ugh. I understand the goal, but the resulting code indirection turns my
stomach a bit. 

Although do take my criticism lightly, as right off I don't have a
better suggestion other then to just yank the __init attribute from the
initialization functions. I'm just not sure the savings is worth the
added staple-gunned complexity. Might there be a better way?

thanks
-john

