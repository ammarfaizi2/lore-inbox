Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWKBVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWKBVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbWKBVk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:40:56 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41635 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751257AbWKBVk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:40:56 -0500
Date: Fri, 3 Nov 2006 03:10:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gautham Shenoy <ego@in.ibm.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
Message-ID: <20061102214034.GB3407@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20061101225925.GA17363@redhat.com> <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org> <20061101161723.f132d208.akpm@osdl.org> <20061102190450.GB23489@in.ibm.com> <Pine.LNX.4.64.0611021129470.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611021129470.25218@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 11:30:20AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 3 Nov 2006, Dipankar Sarma wrote:
> > 
> > IMO, the right thing to do would be to convert lock_cpu_hotplug() to
> > a get_cpu_hotplug()/put_cpu_hotplug() type semantics and use a more
> > scalable implementation underneath (as opposed to a global
> > semaphore/mutex).
> 
> Yes, I think Gautham's patch-series basically did exactly that, no? Except 
> it kept the old name.

Yes, atleast that is the idea - turn it into a scalable refcount model
as opposed to a global lock.

Thanks
Dipankar
