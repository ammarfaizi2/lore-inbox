Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWHVMcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWHVMcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWHVMcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:32:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:16876 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751386AbWHVMcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:32:45 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060822101028.GB5052@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
	 <1156245036.6482.16.camel@Homer.simpson.net>
	 <20060822101028.GB5052@in.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 14:41:14 +0000
Message-Id: <1156257674.4617.8.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 15:40 +0530, Srivatsa Vaddagiri wrote:
> On Tue, Aug 22, 2006 at 11:10:36AM +0000, Mike Galbraith wrote:
> > Doesn't seem to work here, but maybe I'm doing something wrong.
> > 
> > I set up cpuset "all" containing cpu 0-1 (all, 1.something cpus I have;)
> 
> You are assigning all the CPUs to the cpuset "all" and then making it an
> exclusive/metered cpuset?

Yeah.

> I dont think I am handling that case well (yet), primarily because usage of 
> remaining tasks (which are not in cpuset "all", "mikeg" & "root") is not 
> accounted/controlled. Note that those remaining tasks will be running on one of 
> the CPUs assigned to "all". What needs to happen is those remaining tasks need 
> to be moved to a separate group (and a runqueue), being given some left-over 
> CPU quota (which is left over from assignment of quota to mikeg and root), 
> which is not handled in the patches (yet). One of the reason why I havent 
> handled it yet is that there is no easy way to retrieve list of tasks attached 
> to a cpuset.

I try it with everything in either root or mikeg.

> Can you try assigning (NUM_CPUS-1) cpus to "all" and give it a shot?
> Essentially you need to ensure that only tasks chosen by you are running in 
> cpus given to "all" and other child-cpusets under it.

Sure.

	-Mike

