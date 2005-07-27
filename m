Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVG0OSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVG0OSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVG0OSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:18:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20101 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262249AbVG0OSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:18:09 -0400
Date: Wed, 27 Jul 2005 16:17:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
Message-ID: <20050727141754.GA25356@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122473595.29823.60.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> The following patch makes the MAX_RT_PRIO and MAX_USER_RT_PRIO 
> configurable from the make *config.  This is more of a proposal since 
> I'm not really sure where in Kconfig this would best fit. I don't see 
> why these options shouldn't be user configurable without going into 
> the kernel headers to change them.

i'd not do this patch, mainly because the '100 priority levels' thing is 
pretty much an assumption in lots of userspace code. The patch to make 
it easier to redefine it is of course fine and was accepted, but i dont 
think we want to make it explicit via .config.

It's a bit like with the 3:1 split: you can redefine it easily via 
include files, but it's not configurable via .config, because many 
people would just play with it and would see things break.

so unless there's really a desire from distributions to actually change 
the 100 RT-prio levels (and i dont sense such a desire), we shouldnt do 
this.

	Ingo
