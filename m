Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUAaClH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 21:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbUAaClH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 21:41:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:41344 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264365AbUAaClF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 21:41:05 -0500
Date: Sat, 31 Jan 2004 02:41:00 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040131024100.GA9236@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <m1ekthx9ju.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ekthx9ju.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> With the x86-64 optimized vsyscall the syscall number does
> not need to be placed into a register, because you have used
> the proper entry point.  For any syscall worth tuning in
> user space I suspect that level of optimization would be
> beneficial.  A fast call path that does not waste a register.

The cost of loading a constant into a register is _much_ lower than
the cost of indirect jumps which we have been discussing.

-- Jamie
