Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268010AbUHNDX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268010AbUHNDX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 23:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUHNDX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 23:23:58 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:1396 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267988AbUHNDXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 23:23:51 -0400
Message-ID: <411D85C3.4030808@yahoo.com.au>
Date: Sat, 14 Aug 2004 13:23:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add scheduler domains for ia64
References: <200408131108.40502.jbarnes@engr.sgi.com>
In-Reply-To: <200408131108.40502.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> Nick, how does this look?  It adds scheduler domain code for ia64 and replaces 
> the patch in Andrew's tree.  It also adds SD_NODE_INIT macros to each arch 
> that has ARCH_HAS_SCHED_DOMAIN so that the balance values are more easily 
> tweaked.  Since the cpu span of the nodes on ia64 is smaller than the whole 
> system, I also removed a WARN_ON in active_load_balance, but I'm not sure if 
> that's correct.

Hi Jesse,
Andrew's latest tree should have a number of improvements and changes
to the sched domains code which you will need to synch up to.

One issue you may have is that Ingo removed the ability to have arch
code override the domain structure due to it being too hazardous for
architectures to use in this form (which I don't entirely disagree with).

Now I guess your patch could go into the generic code because it is
pretty general - however are you guys going to want to do anything
more fancy with these things?

Nick
