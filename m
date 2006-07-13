Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWGMAMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWGMAMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWGMAMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:12:41 -0400
Received: from thunk.org ([69.25.196.29]:30862 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751477AbWGMAMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:12:41 -0400
Date: Wed, 12 Jul 2006 20:12:22 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Message-ID: <20060713001222.GJ9040@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Andi Kleen <ak@suse.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com> <m1hd1mafe0.fsf@ebiederm.dsl.xmission.com> <20060712232414.GI9040@thunk.org> <200607130131.46753.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607130131.46753.ak@suse.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 01:31:46AM +0200, Andi Kleen wrote:
> 
> glibc still works, just slower. But I think the best strategy 
> is just to emulate the single sysctl glibc is using and printk
> for the rest.
> 

That sounds reasonable, yes.


> > point is moot.  But at the same time, what is the cost of leaving
> > sys_sysctl in the kernel for an extra 6-12 months, or even longer,
> > starting from now?  
>
> The numerical namespace for sysctl is unsalvagable imho. e.g. distributions
> regularly break it because there is no central repository of numbers
> so it's not very usable anyways in practice.

That may be true, but it doesn't answer the question, what's the cost
of leaving in sys_sysctl in there for now?  

In any case, if we really do want to get rid of it, the next step
should be a working deprecation printk and adding something to
Documentation/feature-removal-schedule.txt.

						- Ted
