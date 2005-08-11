Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVHKXoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVHKXoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVHKXoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:44:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751116AbVHKXoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:44:07 -0400
Date: Thu, 11 Aug 2005 16:43:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch 3/8] [PATCH] x86_64: Fixing smpboot timing problem
Message-ID: <20050811234343.GF7762@shell0.pdx.osdl.net>
References: <20050811225445.404816000@localhost.localdomain> <20050811225609.058881000@localhost.localdomain> <20050811233302.GA8974@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811233302.GA8974@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> >  static void __cpuinit tsc_sync_wait(void)
> >  {
> >  	if (notscsync || !cpu_has_tsc)
> >  		return;
> > -	printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n", smp_processor_id(),
> > -			boot_cpu_id);
> > -	sync_tsc();
> > +	sync_tsc(boot_cpu_id);
> 
> I actually found a bug in this today. This should be sync_tsc(0), not sync_tsc(boot_cpu_id)
> Can you just fix it in your tree or should I submit a new patch? 

I'll fix it locally.  Thanks for the heads-up.
-chris
