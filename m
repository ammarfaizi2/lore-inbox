Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263907AbTICP5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTICPzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:55:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:35548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263683AbTICPwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:52:03 -0400
Message-Id: <200309031551.h83Fpu413835@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: UP Regression (was) Re: Scaling noise 
In-Reply-To: Message from Nick Piggin <piggin@cyberone.com.au> 
   of "Wed, 03 Sep 2003 16:55:55 +1000." <3F55907B.1030700@cyberone.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Sep 2003 08:51:56 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[snip]
.
> 
> I don't think anyone advocates sacrificing UP performance for 32 ways, but
> as he says it can happen .1% at a time.
> 
> But it looks like 2.6 will scale well to 16 way and higher. I wonder if
> there are many regressions from 2.4 or 2.2 on small systems.
> 
> 
On the Scalable Test Platform, running osdl-aim-7,  for the
UP case, 2.4 is a bit better than 2.6, this is consistent across
many runs. For SMP, 2.6 is better, but the delta is rather
small, until we get to 8 CPUS. We have a lot of un-parsed data from other
tests - might be some trends there also.
See http://developer.osdl.org/cliffw/reaim/index.html 
2.4 kernels are at the bottom of the page.

Run #   PLM #  Kernel                   workload        Max JPM  max    host
1-way                                                            lusers
 278671 2083    patch-2.4.23-pre2       new_dbase       1066.75  18      
stp1-003
278835  2087    2.6.0-test4-mm5         new_dbase       995.74   17      
stp1-003
2-way
278690  2083    patch-2.4.23-pre2       new_dbase       1300.01  22      
stp2-000
278854  2087    2.6.0-test4-mm5         new_dbase       1340.96  22      
stp2-000
4-way
278437  2075    patch-2.4.23-pre1       new_dbase       5268.41  80      
stp4-000
278805  2084    2.6.0-test4-mm4         new_dbase       5355.73  88      
stp4-000
8-way
278651  2083    patch-2.4.23-pre2       new_dbase       6790.01  112     
stp8-002
 278722 2084    2.6.0-test4-mm4         new_dbase       8189.51  136     
stp8-001

cliffw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


