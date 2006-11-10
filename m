Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946023AbWKJINs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946023AbWKJINs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424379AbWKJINs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:13:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29652 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424287AbWKJINr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:13:47 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
	<200611092317.26459.s0348365@sms.ed.ac.uk>
	<m1ejsbnagm.fsf@ebiederm.dsl.xmission.com>
	<20061110075640.GA15611@flint.arm.linux.org.uk>
Date: Fri, 10 Nov 2006 01:13:16 -0700
In-Reply-To: <20061110075640.GA15611@flint.arm.linux.org.uk> (Russell King's
	message of "Fri, 10 Nov 2006 07:56:40 +0000")
Message-ID: <m11woblnxf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> On Thu, Nov 09, 2006 at 10:21:13PM -0700, Eric W. Biederman wrote:
>> Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:
>> > Eric, do you have a list of the remaining users? It'd be good to know for 
>> > people using Linux in an embedded environment, where they may want to switch
>> > off the option, but only if it doesn't break their userspace.
>> 
>> They are very very few.  The ones I recall are kudzu, radvd, and
>> libpthreads (which doesn't care).  
>
> Let's not forget that on ARM it's used to get the MMIO region which
> is used for PIO emulation by glibc.  Without it, glibc can't detect
> where this region is.

Is that on all subarches or just some of them?

But given the scarcity of the list this is certainly one of the
significant known users.

Eric
