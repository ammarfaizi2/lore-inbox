Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUIHN3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUIHN3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUIHN0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:26:51 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:6887 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268345AbUIHNYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:24:13 -0400
Date: Wed, 8 Sep 2004 09:28:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
In-Reply-To: <20040908130136.GB20132@elte.hu>
Message-ID: <Pine.LNX.4.53.0409080909380.15087@montezuma.fsmlabs.com>
References: <20040908111751.GA11507@elte.hu> <Pine.LNX.4.53.0409080814570.15087@montezuma.fsmlabs.com>
 <20040908130136.GB20132@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Ingo Molnar wrote:

> at a quick glance your patch doesnt seem to cover the following locking
> primitives: read_lock_irqsave(), read_lock_irq(), write_lock_irqsave,
> write_lock_irq(). Also, i think your 2.6.6 patch doesnt apply anymore
> because it clashes with your very nice out-of-line spinlocks patch that
> went into -BK recently ;)

Yes i intentionally avoided rwlocks, in that case i think write_lock_* 
would be the one to work on, but this is all covered by CONFIG_PREEMPT and 
your patch now.

Thanks,
	Zwane
