Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVLISWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVLISWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVLISVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:21:52 -0500
Received: from fsmlabs.com ([168.103.115.128]:62392 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S964850AbVLISVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:21:47 -0500
X-ASG-Debug-ID: 1134152502-18681-26-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Fri, 9 Dec 2005 10:27:14 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
X-ASG-Orig-Subj: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer
 interrupts on C3 state
Subject: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer
 interrupts on C3 state
In-Reply-To: <20051209095243.A22139@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0512091025540.26307@montezuma.fsmlabs.com>
References: <20051208181040.C32524@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com>
 <20051209044938.A26619@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com>
 <20051209095243.A22139@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6177
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Venkatesh Pallipadi wrote:

> On Fri, Dec 09, 2005 at 09:35:36AM -0800, Zwane Mwaikambo wrote:
> > > +void switch_ipi_to_APIC_timer(void *cpumask);
> > > Called by acpi processor driver again to reset to APIC_timer when C3 is not 
> > > supported by the CPU.
> > 
> > Well i was more curious as to where in the patchset the 
> > switch_ipi_to_APIC_timer is used;
> > 
> > zwane@montezuma linux-2.6-hg-x86_64 {0:1} grep switch_ipi_to_APIC_timer /tmp/patch[1234]
> > /tmp/patch2:+void switch_ipi_to_APIC_timer(void *cpumask);
> > /tmp/patch2:+void switch_ipi_to_APIC_timer(void *cpumask)
> > /tmp/patch2:+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
> > /tmp/patch4:+void switch_ipi_to_APIC_timer(void *cpumask)
> > /tmp/patch4:+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
> > /tmp/patch4:+void switch_ipi_to_APIC_timer(void *cpumask);
> > 
> > Or will it only be used in future?
> > 
> 
> That calls for updated patch 2/3 (That was a typo on my original patch :()

Thanks Venki, i'll have a look at the rest too.
