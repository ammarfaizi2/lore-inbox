Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264845AbTE1TTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTE1TTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:19:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2706 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264845AbTE1TTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:19:16 -0400
Date: Wed, 28 May 2003 12:32:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rick Lindsley <ricklind@us.ibm.com>
cc: Erich Focht <efocht@hpce.nec.com>, Andi Kleen <ak@suse.de>,
       LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension 
Message-ID: <30280000.1054150332@[10.10.2.4]>
In-Reply-To: <200305281814.h4SIEgj02186@owlet.beaverton.ibm.com>
References: <200305281814.h4SIEgj02186@owlet.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Can you define what you mean by big vs small? I presume you mean RSS?
>     There are several factors that come into play here, at least:
>     
>     1. RSS (and which bits of this lie on which node)
>     2. CPU utilisation of the task
>     3. Task duration
>     4. Cache warmth
>     5. the current balance situation.
> 
> Along the same lines, would it make sense to *permit* imbalances for some
> classes of tasks?  It may be worth it, for example, to let three threads
> sharing a lot of data to saturate one cpu because what they lose from
> their self-competition is saved from the extremely warm cache.
> 
> So you leave cpu0 at 7 tasks even though cpu1 only has 4, because the 7 are
> "related" and the 4 are "dissimilar"?  The equation changes dramatically,
> perhaps, once their is an idle cpu, but if everything is busy does it make
> sense to weight the items in the runqueues in any way?

It'd make sense ... but I think it would be a bitch to implement ;-) 
How do you know when it's worth it?

M.

