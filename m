Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275968AbTHOMhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275969AbTHOMhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:37:34 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:47744 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S275968AbTHOMhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:37:32 -0400
From: jlnance@unity.ncsu.edu
Date: Fri, 15 Aug 2003 08:37:08 -0400
To: mouschi@wi.rr.com, linux-kernel@vger.kernel.org
Subject: Re: Interesting VM feature?
Message-ID: <20030815123708.GA2231@ncsu.edu>
References: <13dedd139cb9.139cb913dedd@rdc-kc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13dedd139cb9.139cb913dedd@rdc-kc.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:17:07PM -0500, mouschi@wi.rr.com wrote:

> What this mempool wants to do is to be able to
> allocate a block of memory and tell the kernel which
> pages from it can be outright discarded, instead of
> swapped out when memory starts to get crowded. 

I think you might be able to get what you want with madvise() or perhaps
by mmap()ing new clean pages on top of the pages you want to throw away.

> I'm going to keep reading. If this is already
> implemented, or if the efficiency gains would be
> nil, somebody yell at me before I start crashing my

I would not implement this unless you either know you have a problem
with your mempool swap speed or you are bored.  I doubt it is going
to help a lot, and it will certainly simplify your code to leave it
out.  If you later find that you have performance problems you can
look into this again.

Thanks,

Jim
