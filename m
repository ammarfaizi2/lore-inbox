Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbTIDCrr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbTIDCrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:47:45 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:17539 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264532AbTIDCqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:46:17 -0400
Date: Wed, 3 Sep 2003 19:46:08 -0700
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030904024608.GH5227@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <31190000.1062604245@[10.10.2.4]> <20030904004943.GB5227@work.bitmover.com> <200309040421.16939.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309040421.16939.phillips@arcor.de>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 04:21:16AM +0200, Daniel Phillips wrote:
> On Thursday 04 September 2003 02:49, Larry McVoy wrote:
> > It's much better to have a bunch of OS's and pull
> > them together than have one and try and pry it apart.
> 
> This is bogus.  The numbers clearly don't work if the ccCluster is made of 
> uniprocessors, so obviously the SMP locking has to be implemented anyway, to 
> get each node up to the size just below the supposed knee in the scaling 
> curve.  This eliminates the argument about saving complexity and/or work.

If you thought before you spoke you'd realize how wrong you are.  How many
locks are there in the IRIX/Solaris/Linux I/O path?  How many are needed for
2-4 way scaling?  

Here's the litmus test: list all the locks in the kernel and the locking
hierarchy.  If you, a self claimed genius, can't do it, how can the rest
of us mortals possibly do it?  Quick.  You have 30 seconds, I want a list.
A complete list with the locking hierarchy, no silly awk scripts.  You have
to show which locks can deadlock, from memory.

No list?  Cool, you just proved my point.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
