Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTIAScj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTIAScf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:32:35 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:12188 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263670AbTIASbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:31:53 -0400
Date: Mon, 01 Sep 2003 11:31:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v10
Message-ID: <6860000.1062441073@[10.10.2.4]>
In-Reply-To: <3F52A546.9020608@cyberone.com.au>
References: <3F5044DC.10305@cyberone.com.au> <1806700000.1062361257@[10.10.2.4]> <1807550000.1062362498@[10.10.2.4]> <3F52A546.9020608@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Kernbench: (make -j vmlinux, maximal tasks)
>>>                              Elapsed      System        User         CPU
>>>              2.6.0-test4       45.87      116.92      571.10     1499.00
>>>       2.6.0-test4-nick10       46.91      114.03      584.16     1489.25
>>> 
>> 
>> Actually, now looks like you have significantly more idle time, so perhaps
>> the cross-cpu (or cross-node) balancing isn't agressive enough:
>> 
> 
> Yeah, there is a patch for this in mm that is not in mine. It should
> help both mine and mainline though...

Not convinced of that - mm performs worse than mainline for me.
 
> Looks like mine is still context switching a bit more by the increased
> user time but its probably nearly acceptable now.

Yeah, is odd, you have more user time, but also more idle time. schedstats
should measure context switch rates, balances, etc.

M.

