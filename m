Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVK2Pmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVK2Pmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVK2Pmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:42:45 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:59068 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751384AbVK2Pmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:42:44 -0500
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com, nando@ccrma.Stanford.EDU, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com, akpm@osdl.org
In-Reply-To: <20051129145022.GE19515@wotan.suse.de>
References: <20051124150731.GD2717@elte.hu>
	 <1132952191.24417.14.camel@localhost.localdomain>
	 <20051126130548.GA6503@elte.hu>
	 <1133232503.6328.18.camel@localhost.localdomain>
	 <20051128190253.1b7068d6.akpm@osdl.org>
	 <1133235740.6328.27.camel@localhost.localdomain>
	 <20051128200108.068b2dcd.akpm@osdl.org> <20051129064420.GA15374@elte.hu>
	 <p73mzjngwim.fsf@verdi.suse.de>
	 <1133273971.6328.49.camel@localhost.localdomain>
	 <20051129145022.GE19515@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 10:42:34 -0500
Message-Id: <1133278954.6328.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 15:50 +0100, Andi Kleen wrote:
> On Tue, Nov 29, 2005 at 09:19:31AM -0500, Steven Rostedt wrote:
> > > And in practice the CPU will run so hot that only benchmarkers like it.
> > 
> > Why would it run hot?  What's the difference between polling and doing
> > other things.  How many transistors does it take to poll?
> 
> It will prevent the CPU from going into sleep states and essentially
> keep most of it enabled.  

Well, there's one thing that my patch _does_ help with.  (And it has
just helped me now).  If you boot up with idle=poll and forget about it,
you can check what idle routine is being used and switch out of poll
without rebooting. (like I'm doing right now :-)

-- Steve

