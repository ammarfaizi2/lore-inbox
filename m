Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUKRPOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUKRPOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKRPMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:12:37 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:41386 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262405AbUKRPKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:10:35 -0500
Message-ID: <419CBB4A.2020207@nortelnetworks.com>
Date: Thu, 18 Nov 2004 09:10:02 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Werner Almesberger <wa@almesberger.net>, Chris Ross <chris@tebibyte.org>,
       Andrea Arcangeli <andrea@novell.com>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /	all_unreclaimable
 braindamage
References: <20041105200118.GA20321@logos.cnet>	 <200411051532.51150.jbarnes@sgi.com>	 <20041106012018.GT8229@dualathlon.random>	 <1099706150.2810.147.camel@thomas> <20041117195417.A3289@almesberger.net>	 <419BDE53.1030003@tebibyte.org> <20041117210410.R28844@almesberger.net>	 <419BECB0.70801@tebibyte.org> <20041117221419.S28844@almesberger.net>	 <419C5B45.2080100@tebibyte.org>  <20041118070137.T28844@almesberger.net> <1100789078.2635.73.camel@thomas>
In-Reply-To: <1100789078.2635.73.camel@thomas>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:

> Hmm, what about embedded boxes without swap ? There you have only one
> choice. Kill anything appropriate. 

I worked on a project that took the opposite approach from the "I'm a suspect" 
flag mentioned earlier.  Processes could request immunity from the OOM killer as 
long as they were under a specified memory usage.  Critical apps were thus 
protected as long as they were sane, while noncritical stuff could be killed at 
will.

Chris
