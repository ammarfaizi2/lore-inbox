Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTJ1RcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTJ1RcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:32:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:43909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264057AbTJ1RcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:32:02 -0500
Date: Tue, 28 Oct 2003 09:26:12 -0800
From: cliff white <cliffw@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: mhf@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
Message-Id: <20031028092612.68d1c80d.cliffw@osdl.org>
In-Reply-To: <3F9DAF2C.8010308@cyberone.com.au>
References: <200310261201.14719.mhf@linuxmail.org>
	<20031027145531.2eb01017.cliffw@osdl.org>
	<3F9DAF2C.8010308@cyberone.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 10:50:04 +1100
Nick Piggin <piggin@cyberone.com.au> wrote:

> 
> 
> cliff white wrote:
> 
> >On Tue, 28 Oct 2003 05:52:45 +0800
> >Michael Frank <mhf@linuxmail.org> wrote:
> >
> >
> >>To my surprise 2.6 - which used to do better then 2.4 - does no longer 
> >>handle these test that well.

> >STP id Kernel Name         MaxJPM      Change  Options
> >281669 linux-2.6.0-test8   7014.42      0.0    
> >281671 linux-2.6.0-test8   8294.94     +18.26%  elevator=deadline
> >
> >The -mm kernels don't show this big delta. We also do not see this delta on
> >smaller machines
> >
> 
> I'm working with Randy to fix this. Attached is what I have so far. See how
> you go with it.

So far, looks quite good. ( i know 2.4.18 is wierd for some, but they were
hot off the stp, so i used 'em )

4-cpu
STP id Kernel Name         MaxJPM      Change  Options
282391 linux-2.4.18        5250.23     0.00	
282413 Nick's patch	   5484.95     4.27   elevator=deadline
282413 Nick's patch        5416.51     3.06

282395 linux-2.4.18        6581.17     0.0
282415 Nick's patch        8293.95     20.6
282415 Nick's patch        8484.95     22.43 elevator=deadline

And, the graph is nice and flat!
http://khack.osdl.org/stp/282416/results/jpm.png

Full results: http://developer.osdl.org/cliffw/reaim/index.html

Any test detail: http://khack.osdl.org/stp/<STP id>

cliffw

> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
