Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWJXJGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWJXJGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWJXJGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:06:23 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:26978 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030244AbWJXJGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:06:22 -0400
Date: Tue, 24 Oct 2006 11:06:19 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Message-ID: <20061024090619.GD4943@rhun.haifa.ibm.com>
References: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 09:15:31PM -0700, yhlu wrote:
> in phys flat mode, when using set_xxx_irq_affinity to irq balance from
> one cpu to another,  _assign_irq_vector will get to increase last used
> vector and get new vector. this will use up the vector if enough
> set_xxx_irq_affintiy are called. and end with using same vector in
> different cpu for different irq. (that is not what we want, we only
> want to use same vector in different cpu for different irq when more
> than 0x240 irq needed). To keep it simple, the vector should be reused
> instead of getting new vector.
> 
> Also according to Eric's review, make it more generic to be used with
> flat mode too.
> 
> This patch need to be applied over Eric's irq: cpu_online_map patch.
> 
> 
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Muli Ben-Yehuda <muli@il.ibm.com>
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

Boots fine and survives a quick stress test.

Cheers,
Muli
