Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUATHam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 02:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUATHam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 02:30:42 -0500
Received: from [66.35.79.110] ([66.35.79.110]:16298 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S265244AbUATHal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 02:30:41 -0500
Date: Mon, 19 Jan 2004 23:30:32 -0800
From: Tim Hockin <thockin@hockin.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rusty Russell <rusty@au1.ibm.com>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
Message-ID: <20040120073032.GB12638@hockin.org>
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400CD4B5.6020507@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 06:11:49PM +1100, Nick Piggin wrote:
> I thought hotplug is allowed to fail? Thus you can have a hung system.
> Or what if the hotplug script itself becomes TASK_UNRUNNABLE? What if the
> process needs a guaranteed scheduling latency?

I guess a hotplug script MAY fail.  I don't think it's a good idea to make
your CPU hotplug script fail.  May and Misght are different.  It's up to the
implementor whether the script can get into a failure condition.

The hotplug script can only become unrunnable if you yank out all the CPUs
on the system.  I'd assume it would have an affinity of 0xffffffff.

What if <which> process needs guaranteed scheduling latency?  Do we really
_guarantee_ scheduling latency *anywhere*?

