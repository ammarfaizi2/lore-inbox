Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVHVUmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVHVUmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVHVUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:42:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28311
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751126AbVHVUmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:42:32 -0400
Date: Mon, 22 Aug 2005 13:42:26 -0700 (PDT)
Message-Id: <20050822.134226.35468933.davem@davemloft.net>
To: jasonuhl@sgi.com
Cc: tony.luck@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PRINTK_TIME woes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050822203306.GA897956@dragonfly.engr.sgi.com>
References: <200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
	<20050822.132052.65406121.davem@davemloft.net>
	<20050822203306.GA897956@dragonfly.engr.sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Uhlenkott <jasonuhl@sgi.com>
Date: Mon, 22 Aug 2005 13:33:06 -0700

> On Mon, Aug 22, 2005 at 01:20:52PM -0700, David S. Miller wrote:
> > Not really, when I'm debugging TCP events over gigabit
> > these timestamps are exceptionally handy.
> 
> Yes, but how many of those figures are really significant?  I strongly
> suspect that the overhead of printk() is high enough, even when we're
> just spewing to the dmesg buffer and not the console, that we have a
> lot more precision than accuracy at nanosecond resolution.

I turn off VC logging, and I turn off disk sync'ing, so it goes
straight to the page cache.

I really do need sub-microsecond timings when I put a lot of
printk tracing into the stack.

This is a useful feature, please do not labotomize it just because
it's difficult to implement on ia64.  Just make a
"printk_get_timestamp_because_ia64_sucks()" interface or something
like that :-)
