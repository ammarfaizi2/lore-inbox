Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWGMMPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWGMMPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWGMMPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:15:43 -0400
Received: from ns.suse.de ([195.135.220.2]:35554 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932227AbWGMMPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:15:42 -0400
From: Andi Kleen <ak@suse.de>
To: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Date: Thu, 13 Jul 2006 14:15:48 +0200
User-Agent: KMail/1.9.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com> <200607130131.46753.ak@suse.de> <20060713001222.GJ9040@thunk.org>
In-Reply-To: <20060713001222.GJ9040@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607131415.49075.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 02:12, Theodore Tso wrote:
> On Thu, Jul 13, 2006 at 01:31:46AM +0200, Andi Kleen wrote:
> > glibc still works, just slower. But I think the best strategy
> > is just to emulate the single sysctl glibc is using and printk
> > for the rest.
>
> That sounds reasonable, yes.
>
> > > point is moot.  But at the same time, what is the cost of leaving
> > > sys_sysctl in the kernel for an extra 6-12 months, or even longer,
> > > starting from now?
> >
> > The numerical namespace for sysctl is unsalvagable imho. e.g.
> > distributions regularly break it because there is no central repository
> > of numbers so it's not very usable anyways in practice.
>
> That may be true, but it doesn't answer the question, what's the cost
> of leaving in sys_sysctl in there for now?

For once linux/sysctl.h is one of the biggest source of patch rejects.
The sooner it goes the better.

>
> In any case, if we really do want to get rid of it, the next step
> should be a working deprecation printk 

It was in there for months already.

> and adding something to 
> Documentation/feature-removal-schedule.txt.

That is what Eric's patch did.

-Andi
