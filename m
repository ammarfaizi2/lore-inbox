Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVEXPZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVEXPZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVEXPZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:25:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63647 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262108AbVEXPYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:24:10 -0400
Date: Tue, 24 May 2005 17:23:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com, Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
Message-ID: <20050524152351.GA10489@elte.hu>
References: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk> <42933D71.8060706@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42933D71.8060706@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:


> I've visited these issues before. It all boils down to a simple 
> question: is it worth making the kernel so much more complicated for 
> such a minority when 90% of the problems encountered in the field 
> revolve around the necessity of responding to an interrupt in a 
> deterministic fashion?
>
> And for those 90% of cases, a simple hyper-visor/nanokernel layer is 
> good enough. For the remaining 10% of cases, that's where something 
> like the rt-preempt or RTAI become necessary. [...]

just to make sure, by "much more complicated" are you referring to the 
PREEMPT_RT feature? Right now PREEMPT_RT consists of 8000 new lines of 
code (of which 2000 is debugging code) and 2000 lines of modified kernel 
code. One of the primary goals i had was to keep it simple and robust.

That's more than 3 times smaller than UML and it's almost an order of
magnitude smaller than a nanokernel codebase i just checked, and it
boots/works on just about everything where the stock Linux kernel boots.
I challenge you to write a nanokernel/hypervisor with a comparable
feature-set in that many lines of code.

anyway, as always, the devil is in the details. I certainly dont suggest 
that nanokernels/hypervisors are not nice (to the contrary!), or that 
all component technologies of the -RT patchset will be accepted into 
Linux. PREEMPT_RT started out as an experiment to reduce scheduling 
latencies within the constraints of the Linux kernel. It is not an 
all-or-nothing feature, it's more of a collection of incremental 
patches. It is one, nonexclusive way of doing things.

	Ingo
