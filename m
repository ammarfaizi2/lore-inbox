Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVLIReF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVLIReF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVLIReF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:34:05 -0500
Received: from cantor.suse.de ([195.135.220.2]:56263 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932515AbVLIReD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:34:03 -0500
Date: Fri, 9 Dec 2005 18:34:01 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [RFC][PATCH 2/3]i386,x86-64 Handle missing local APIC timer interrupts on C3 state
Message-ID: <20051209173401.GG11190@wotan.suse.de>
References: <20051208181040.C32524@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090003460.26307@montezuma.fsmlabs.com> <20051209044938.A26619@unix-os.sc.intel.com> <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512090933540.26307@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> zwane@montezuma linux-2.6-hg-x86_64 {0:1} grep switch_ipi_to_APIC_timer /tmp/patch[1234]
> /tmp/patch2:+void switch_ipi_to_APIC_timer(void *cpumask);
> /tmp/patch2:+void switch_ipi_to_APIC_timer(void *cpumask)
> /tmp/patch2:+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
> /tmp/patch4:+void switch_ipi_to_APIC_timer(void *cpumask)
> /tmp/patch4:+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
> /tmp/patch4:+void switch_ipi_to_APIC_timer(void *cpumask);
> 
> Or will it only be used in future?

It should be used in drivers/acpi/processor_* before enabling C3.
Or at least it was that way in some earlier patches Venki sent
around.

-Andi
