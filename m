Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVEaJPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVEaJPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVEaJPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:15:21 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:38101 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261451AbVEaJPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:15:16 -0400
Date: Tue, 31 May 2005 11:14:37 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, James Bruce <bruce@andrew.cmu.edu>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <429BBC2D.70406@yahoo.com.au>
Message-Id: <Pine.OSF.4.05.10505311107160.31148-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005, Nick Piggin wrote:

> [...]
> Whenever you or anyone else try to complicate the Linux kernel
> with hard-RT stuff, [...]

The more I look at Ingo's RT patch the more I see a cleanup. It is the old
maybe-preemptive way which is a mess. There is so much the kernel
developer have to think off wrt. locking. Too many kind of contexts,
per cpu variables, miriads of locking types. When I started to look at it
I thought: What a mess. 
PREEMPT_RT basicly boils it down to: everything are threads, the only way
to protect data is to use a mutex or use RCU. In short: Linux with
PREEMPT_RT is much easier to understand and develop than with !PREEMPT_RT.

Esben

