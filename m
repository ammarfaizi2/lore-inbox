Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTKXBKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 20:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTKXBKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 20:10:14 -0500
Received: from dp.samba.org ([66.70.73.150]:53697 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263568AbTKXBKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 20:10:11 -0500
Date: Mon, 24 Nov 2003 12:06:12 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       jbarnes@sgi.com, efocht@hpce.nec.com, John Hawkes <hawkes@sgi.com>,
       wookie@osdl.org
Subject: Re: [RFC] generalise scheduling classes
Message-ID: <20031124010612.GB6537@krispykreme>
References: <Pine.LNX.4.56.0311171638140.29083@earth> <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth> <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au> <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au> <3FC0A0C2.90800@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC0A0C2.90800@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We still don't have an HT aware scheduler, which is unfortunate because
> weird stuff like that looks like it will only become more common in 
> future.

Yep. Look at POWER5, 2 cores on a die sharing a l2 cache and 2 threads
on each core. On top of that you have the higher level NUMA
characteristics of the machine. So we need SMT as well as (potentially)
2 levels of NUMA. The overhead of enabling multi levels of NUMA may
outweigh the gains, we need to do some analysis.

Looks like a lot of the other architectures are going multi core multi
thread...

(HT is an intel trademark for what boils down to being SMT)

Anton
