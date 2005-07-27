Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVG0Olt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVG0Olt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVG0Olh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:41:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53894 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262289AbVG0Oju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:39:50 -0400
Date: Wed, 27 Jul 2005 16:38:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
Message-ID: <20050727143843.GB26303@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain> <20050727141754.GA25356@elte.hu> <1122474539.29823.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122474539.29823.68.camel@localhost.localdomain>
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

> On Wed, 2005-07-27 at 16:17 +0200, Ingo Molnar wrote:
> > i'd not do this patch, mainly because the '100 priority levels' thing is 
> > pretty much an assumption in lots of userspace code. 
> 
> I must argue though, any user app that assumes 100 is the max prio is 
> already broken.  That's why there are system calls to get the actual 
> range.  Maybe it would be good to change the range to find the apps 
> that break. And then fix them.

a fair number of apps assume that there's _at least_ 100 levels of 
priorities. The moment you have a custom kernel that offers more than 
100 priorities, there will be apps that assume that there are more than 
100 priority levels, and will break if there are less.

	Ingo
