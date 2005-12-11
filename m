Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVLKW6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVLKW6S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 17:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVLKW6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 17:58:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25489 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750796AbVLKW6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 17:58:17 -0500
Date: Sun, 11 Dec 2005 14:57:40 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, ashok.raj@intel.com, ak@suse.de,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't attempt to power off if power off is not
 implemented.
Message-Id: <20051211145740.32284a45.pj@sgi.com>
In-Reply-To: <m1k6egavgq.fsf_-_@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
	<20051127135833.GH20775@brahms.suse.de>
	<m1wtiufa9z.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com>
	<m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512021221210.13220@montezuma.fsmlabs.com>
	<m1iru7dlww.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512050014000.6637@montezuma.fsmlabs.com>
	<m1zmncb0n5.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512072158500.2557@montezuma.fsmlabs.com>
	<m1vey0azeu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512072249000.2557@montezuma.fsmlabs.com>
	<m1k6egavgq.fsf_-_@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For architectures like alpha that don't implement the pm_power_off
> variable pm_power_off is declared in linux/pm.h and it is a generic
> part of our power management code, and all architectures should
> implement it.
> 
> ...
> 
> Andrew can you pick this up and put this in the mm tree.  Kernels
> that don't compile or don't power off seem saner than kernels that
> oops or panic.  

Ok - so now you've broken alpha build ;(.

Yes - as your patch comment explains, the alternatives suck worse.

I'll send a patch that provides a NULL pm_power_off pointer for alpha,
which in my 43 seconds of deep analysis of this issue, seems to be the
thing to do for arch's that don't define a useful pm_power_off.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
