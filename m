Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266038AbUFPAlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUFPAlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUFPAlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:41:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:7567 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266038AbUFPAlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:41:18 -0400
Date: Tue, 15 Jun 2004 17:39:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Atul Sabharwal <atul_sabharwal@linux.jf.intel.com>
Cc: linux-kernel@vger.kernel.org, atul.sabharwal@intel.com
Subject: Re: [Announce] Non Invasive Kernel Monitor for threads/processes
Message-ID: <20040615173951.E22989@build.pdx.osdl.net>
References: <40CF4233.70709@linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40CF4233.70709@linux.jf.intel.com>; from atul_sabharwal@linux.jf.intel.com on Tue, Jun 15, 2004 at 11:38:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Atul Sabharwal (atul_sabharwal@linux.jf.intel.com) wrote:
> We have been working with a solution for non-intrusively trapping on lifetime
> of processes/threads. This is useful for management applications running in
> telecom and enterprise data centers that need to monitor a set of threads/
> processes.
> 
> Project Goal::
> ~~~~~~~~~~~~~~
> To create a kernel patch that  shall support methods to non-intrusively monitor
> processes/threads at the kernel level.  It would use a notfication mechanism in
> the kernel that allows registration of events of interest regarding processes/
> threads.  Events of interest could be the following : Process creation (fork), 
> Process exit(exit), Process calls(exec), thread creation & thread exit. 

These spots are already hooked via LSM and audit (the latter is capable
of communicating such events to userspace via netfilter) Was that not
sufficient somehow?  In fact, the netfilter queuing will probably fair
better than sigqueue which fairly limited.  Might be worth looking into
that.  Did you look at the task ornament patch floating about from David
Howells?  If new code is needed, that patch looks more generically useful.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
