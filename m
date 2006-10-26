Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161418AbWJZSLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161418AbWJZSLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161417AbWJZSLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:11:00 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:49415 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161418AbWJZSK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:10:59 -0400
Date: Thu, 26 Oct 2006 20:10:55 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Message-ID: <20061026181055.GT4868@rhun.haifa.ibm.com>
References: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com> <20061024170503.GA71966@muc.de> <86802c440610260204t4620d25t2d2e40895203b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610260204t4620d25t2d2e40895203b17@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 02:04:57AM -0700, Yinghai Lu wrote:
> Andi,
> please check the revised patch: It can be appied to current linus't tree.
> 
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
> It also check if new domain and old domain is equal, to avoid extra 
> operation.

Works fine for mee.

Cheers,
Muli
