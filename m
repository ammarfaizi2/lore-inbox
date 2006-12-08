Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425115AbWLHH7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425115AbWLHH7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425116AbWLHH7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:59:35 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:53736 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425115AbWLHH7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:59:34 -0500
Date: Fri, 8 Dec 2006 13:28:21 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061208075821.GA11253@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061207105148.20410b83.akpm@osdl.org> <20061207113700.dc925068.akpm@osdl.org> <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207205407.b4e356aa.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 08:54:07PM -0800, Andrew Morton wrote:
> Could do, not sure. 

AFAICS it will deadlock for sure.

> I'm planning on converting all the locking around here
> to preempt_disable() though.

Will look forward to that patch. Its hard to dance around w/o a 
lock_cpu_hotplug() ..:)

-- 
Regards,
vatsa
