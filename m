Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWJXRFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWJXRFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWJXRFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:05:06 -0400
Received: from colin.muc.de ([193.149.48.1]:56842 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030434AbWJXRFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:05:05 -0400
Date: 24 Oct 2006 19:05:03 +0200
Date: Tue, 24 Oct 2006 19:05:03 +0200
From: Andi Kleen <ak@muc.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Message-ID: <20061024170503.GA71966@muc.de>
References: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
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

Is that still needed with Eric's latest patches? I suppose not?

-Andi
