Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWJEVTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWJEVTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWJEVTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:19:04 -0400
Received: from twin.jikos.cz ([213.151.79.26]:19075 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751389AbWJEVTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:19:02 -0400
Date: Thu, 5 Oct 2006 23:18:53 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: keith mannthey <kmannth@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make mach-generic/summit.c compile on UP
In-Reply-To: <1160080292.5664.9.camel@keithlap>
Message-ID: <Pine.LNX.4.64.0610052308000.12556@twin.jikos.cz>
References: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz>
 <1160080292.5664.9.camel@keithlap>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, keith mannthey wrote:

> > In file included from arch/i386/mach-generic/summit.c:17:
> > include/asm/mach-summit/mach_apic.h: In function 'apicid_to_node':
> > include/asm/mach-summit/mach_apic.h:91: error: 'apicid_2_node' undeclared (first use in this function)
> > include/asm/mach-summit/mach_apic.h:91: error: (Each undeclared identifier is reported only once
> > include/asm/mach-summit/mach_apic.h:91: error: for each function it appears in.)
> > Is the patch below correct?
> Well I guess it would fix the apicid_2_node build error but I can't
> think of a single good reason to be in a config where you would need any
> of the summit code in UP.  Perhaps a kconfig or makefile change in the
> right spot would be better. 

Yes, this was in fact a product of a random .config (but allowed by 
Kconfig rules). There should definitely be a Kconfig rule not allowing 
having this non-working .config settings.

I guess that probably making CONFIG_X86_GENERIC dependent on CONFIG_SMP 
would not be good, because the mach-default/ makes sense even on UP, am I 
right?

Thanks,

-- 
Jiri Kosina
