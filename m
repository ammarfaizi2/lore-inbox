Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVISHWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVISHWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVISHWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:22:34 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:11156 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932351AbVISHWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:22:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=fpu91WjUWvzN4xRKswq/C1KMNhsVdxeJMe9utJe2HKam+HFNzT+FwuHAj+BP0/Y31rDEuV9n5IKzFO29qWbiL5ukUfAWhFphZLfneI4fxwTyexo8EbKy2AA4ouqWI2dr42isbCIapjUURz4MXENYOb5W6NlWSDsnhfnUQMprG2w=  ;
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Shaohua Li <shaohua.li@intel.com>
Cc: vatsa@in.ibm.com, Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1127113930.4087.6.camel@linux-hp.sh.intel.com>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
	 <1127111830.4087.3.camel@linux-hp.sh.intel.com>
	 <1127111784.5272.10.camel@npiggin-nld.site>
	 <1127113930.4087.6.camel@linux-hp.sh.intel.com>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 17:22:18 +1000
Message-Id: <1127114538.5272.16.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 15:12 +0800, Shaohua Li wrote:
> On Mon, 2005-09-19 at 16:36 +1000, Nick Piggin wrote:

> > Ah, actually I have a patch which makes all CPU idle threads
> > run with preempt disabled and only enable preempt when scheduling.
> > Would that help?
> It should solve the issue to me. Should we take care of the latency?
> acpi_processor_idle might execute for a long time.
> 

Oh really? I think yes, the latency should be taken care of because
we want to be able to provide good latency even for !preempt kernels.
If a solution can be found for acpi_processor_idle, that would be
ideal.

IMO it always felt kind of hackish to run the idle threads with
preempt on.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
