Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967101AbWKVGfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967101AbWKVGfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 01:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967105AbWKVGfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 01:35:47 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:16328 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S967101AbWKVGfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 01:35:46 -0500
Date: Wed, 22 Nov 2006 11:43:51 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: Re: [PATCH 1/4] Extend notifier_call_chain to count nr_calls made.
Message-ID: <20061122061351.GA4046@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114121832.GA31787@in.ibm.com> <20061114122050.GB31787@in.ibm.com> <20061120221941.e2c379b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120221941.e2c379b3.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
	
On Mon, Nov 20, 2006 at 10:19:41PM -0800, Andrew Morton wrote:

> > +
> > +		if (nr_calls)
> > +			*nr_calls ++;
> 
> This gets
> 
> kernel/sys.c: In function 'notifier_call_chain':
> kernel/sys.c:164: warning: value computed is not used
> 
> 
> And indeed, this code doesn't work.
> 
> What happened?

I didn't get the warnings because my test box still has the prehistoric
version 3.4.4 of gcc. 
I compiled the code with gcc 4.1.1 and got the warnings.

The code does not work because of my carelessness. 
It should have been (*nr_calls)++ in the first place. I apologise.

Thanks for fixing it.

Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
