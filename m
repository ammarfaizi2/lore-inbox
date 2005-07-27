Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVG0O1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVG0O1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVG0O1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:27:18 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19099 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262276AbVG0O0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:26:45 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050727141754.GA25356@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <20050727141754.GA25356@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 10:26:35 -0400
Message-Id: <1122474396.29823.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 16:17 +0200, Ingo Molnar wrote:
> i'd not do this patch, mainly because the '100 priority levels' thing is 
> pretty much an assumption in lots of userspace code. The patch to make 
> it easier to redefine it is of course fine and was accepted, but i dont 
> think we want to make it explicit via .config.
> 
> It's a bit like with the 3:1 split: you can redefine it easily via 
> include files, but it's not configurable via .config, because many 
> people would just play with it and would see things break.
> 
> so unless there's really a desire from distributions to actually change 
> the 100 RT-prio levels (and i dont sense such a desire), we shouldnt do 
> this.

Perfectly understood.  I've had two customers ask me to increase the
priorities for them, but those where custom kernels, and a config option
wasn't necessary. But since I've had customers asking, I thought that
this might be something that others want.  But I deal with a niche
market, and what my customers want might not be what everyone wants.
(hence the RFC in the subject).

So if there are others out there that would prefer to change their
priority ranges,  speak now otherwise this patch will go by the waste
side.

-- Steve


