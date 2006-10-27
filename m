Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946125AbWJ0CfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946125AbWJ0CfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946127AbWJ0CfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 22:35:10 -0400
Received: from colin.muc.de ([193.149.48.1]:49931 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1946125AbWJ0CfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 22:35:09 -0400
Date: 27 Oct 2006 04:35:07 +0200
Date: Fri, 27 Oct 2006 04:35:07 +0200
From: Andi Kleen <ak@muc.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Message-ID: <20061027023507.GA58088@muc.de>
References: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com> <20061024170503.GA71966@muc.de> <86802c440610260204t4620d25t2d2e40895203b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610260204t4620d25t2d2e40895203b17@mail.gmail.com>
User-Agent: Mutt/1.4.1i
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

Eric, do you ack the patch? 

-andi
