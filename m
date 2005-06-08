Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVFHTZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVFHTZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVFHTZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:25:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:507 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261563AbVFHTZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:25:46 -0400
Subject: Re: How does 2.6 SMP scheduler initially assign a thread to a run
	queue?
From: Steven Rostedt <rostedt@goodmis.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: linux-kernel@vger.kernel.org, helen monte <hzmonte@hotmail.com>,
       lk <linux_kernel@patni.com>
In-Reply-To: <20050608120325.A5554@unix-os.sc.intel.com>
References: <BAY102-F24530D3EE13EBCA2B13336A0FA0@phx.gbl>
	 <000e01c56c27$765c4510$5e91a8c0@patni.com>
	 <20050608120325.A5554@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 08 Jun 2005 15:25:22 -0400
Message-Id: <1118258722.4482.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 12:03 -0700, Siddha, Suresh B wrote:

> > > By the way, in an SMT/hyperthreading processor, does the latest kernel
> > > version assign one run queue per physical CPU, or per virtual 
> > > processor?
> > > 
> > 
> > one run-queue per physical CPU
> 
> No. Each logical processor has its own runqueue.

I think it is also worth mentioning that the sched domains are used to
help keep processes on the same physical CPU. Little cost associated to
moving a process from one logical CPU to a sibling, where as there is a
big cost in moving it to another physical CPU.

-- Steve


