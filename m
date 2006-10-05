Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWJEWY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWJEWY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWJEWY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:24:56 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:36332 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932333AbWJEWYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:24:55 -0400
Subject: Re: [PATCH] make mach-generic/summit.c compile on UP
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Jiri Kosina <jikos@jikos.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610052308000.12556@twin.jikos.cz>
References: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz>
	 <1160080292.5664.9.camel@keithlap>
	 <Pine.LNX.4.64.0610052308000.12556@twin.jikos.cz>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 05 Oct 2006 15:24:53 -0700
Message-Id: <1160087093.5664.14.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 23:18 +0200, Jiri Kosina wrote:
> On Thu, 5 Oct 2006, keith mannthey wrote:
> 
> > > In file included from arch/i386/mach-generic/summit.c:17:
> > > include/asm/mach-summit/mach_apic.h: In function 'apicid_to_node':
> > > include/asm/mach-summit/mach_apic.h:91: error: 'apicid_2_node' undeclared (first use in this function)
> > > include/asm/mach-summit/mach_apic.h:91: error: (Each undeclared identifier is reported only once
> > > include/asm/mach-summit/mach_apic.h:91: error: for each function it appears in.)
> > > Is the patch below correct?
> > Well I guess it would fix the apicid_2_node build error but I can't
> > think of a single good reason to be in a config where you would need any
> > of the summit code in UP.  Perhaps a kconfig or makefile change in the
> > right spot would be better. 
> 
> Yes, this was in fact a product of a random .config (but allowed by 
> Kconfig rules). There should definitely be a Kconfig rule not allowing 
> having this non-working .config settings.
> 
> I guess that probably making CONFIG_X86_GENERIC dependent on CONFIG_SMP 
> would not be good, because the mach-default/ makes sense even on UP, am I 
> right

Yea I am pretty sure CONFIG_X86_GENERIC is ment to boot UP and SMP
kernels. 
  
 Maybe just moving apicid_2_node to a UP safe location would be a good
way to go as well.  I overlooked the fact that CONFIG_X86_GENERIC wasn't
always SMP. 

Thanks,
  Keith 

