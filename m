Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSHXQNI>; Sat, 24 Aug 2002 12:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHXQNI>; Sat, 24 Aug 2002 12:13:08 -0400
Received: from bitmover.com ([192.132.92.2]:3076 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S316519AbSHXQNH>;
	Sat, 24 Aug 2002 12:13:07 -0400
Date: Sat, 24 Aug 2002 08:11:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org, bitkeeper-announce@bitmover.com
Subject: Re: BKWeb Feature request [Was: BK license change]
Message-ID: <20020824081141.D17092@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, bitkeeper-announce@work.bitmover.com
References: <200208240039.g7O0dZf12300@work.bitmover.com> <20020824171245.C1889@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020824171245.C1889@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Aug 24, 2002 at 05:12:45PM +0200
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible somehow to sort the cset(s) according to the time they were
> applied to the local tree, and not when they were originally committed?

If this is a correct statement of what you want, we're building it:

    Instead of seeing events in time order of creation, you want to
    see the events in order of arrival in a particular repository.

I agree that the current view is useless when what you want to know is
when did this change finally make it into the tree?

We're working on a "stack" of incoming events.  BK/Web will use this to
give you the display you want and bk undo will be able to use this to
roll your repository backwards by "popping" the stack.  You could do

	while true
	do	bk undo -sf
	done

and when it gets done, you'll have no repository, it will have popped it
away.  bk unpull will just be come a special case of popping the stack.

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
