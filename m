Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUIQQmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUIQQmB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIQP0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:26:52 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:63697 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268838AbUIQOms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:42:48 -0400
Date: Fri, 17 Sep 2004 20:23:50 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, hari@in.ibm.com,
       Rusty Russell <rusty@rustcorp.com.au>, suparna@in.ibm.com,
       fastboot@osdl.org, ebiederm@xmission.com, litke@us.ibm.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [Fastboot] Re: [PATCH][4/6]Register snapshotting before kexec boot
Message-ID: <20040917145350.GA4750@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com> <20040915125322.GC15450@in.ibm.com> <20040915125422.GD15450@in.ibm.com> <20040915125525.GE15450@in.ibm.com> <20040915142722.46088ad5.akpm@osdl.org> <20040916081138.GB4594@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916081138.GB4594@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 08:41:13AM +0000, Dipankar Sarma wrote:
> On Wed, Sep 15, 2004 at 02:27:22PM -0700, Andrew Morton wrote:
> > Is dodgy wrt CPU hotplug, but there's not a lot we can do about that
> > in this context, I expect.  Which is a shame, given that CPU hotplug
> > is a likely time at which to be taking a crashdump ;)
> 
> If Hari disables preemption during this entire section of code,
> he should be safe from CPU hotplug, AFAICS. The stop machine
> threads will never get to run on that CPU.

This will work for CPU remove, not CPU add, since the later
is not atomic (yet). 

Rusty, do you think it would be worthwhile making CPU add atomic?
I can give it a shot :)

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
