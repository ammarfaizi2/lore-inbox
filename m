Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTDXWin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTDXWin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:38:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:46469 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264455AbTDXWim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:38:42 -0400
Date: Thu, 24 Apr 2003 15:39:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Davidsen <davidsen@tmr.com>, Andrew Theurer <habanero@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ricklind@us.ibm.com
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
Message-ID: <1667780000.1051223948@flay>
In-Reply-To: <Pine.LNX.3.96.1030424162544.11351D-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030424162544.11351D-100000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry if I misunderstand, but if HT is present, I would think that you
> would want to start the child of a fork on the same runqueue, because the
> cache is loaded, and to run the child first because in many cases the
> child will do and exac. At that point it is probable that the exec'd
> process run on another CPU would leave the cache useful to the parent.
> 
> I fully admit that this is "seems to me" rather than measured, but
> protecting the cache is certainly a good thing in general.

We don't do balance on exec for SMP. I think we should ;-)
AFAIK, fork always stays on the same runqueue anyway.

>> The key is that we want to agressively steal when 
>> nr_active(remote) - nr_active(idle) > 1 ... not > 0.
>> This will implicitly *never* happen on non HT machines, so it seems
>> like a nice algorithm ... ?
> 
> Is it really that simple? 

Well, *I* think so (obviously) ;-)
Feel free to poke holes in the argument ...

M.

