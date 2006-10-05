Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWJEXLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWJEXLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWJEXLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:11:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:27807 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932393AbWJEXLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:11:51 -0400
To: kmannth@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] make mach-generic/summit.c compile on UP
References: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz>
	<1160080292.5664.9.camel@keithlap>
From: Andi Kleen <ak@suse.de>
Date: 06 Oct 2006 01:11:44 +0200
In-Reply-To: <1160080292.5664.9.camel@keithlap>
Message-ID: <p73bqoqz7bj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keith mannthey <kmannth@us.ibm.com> writes:

> On Thu, 2006-10-05 at 19:16 +0200, Jiri Kosina wrote:
> > Hi,
> > 
> > arch/i386/mach-generic/summit.c doesn't compile (neither in current 
> > mainline git tree, nor in 2.6.18-mm3) when CONFIG_SMP is not set:
> > 
> > In file included from arch/i386/mach-generic/summit.c:17:
> > include/asm/mach-summit/mach_apic.h: In function 'apicid_to_node':
> > include/asm/mach-summit/mach_apic.h:91: error: 'apicid_2_node' undeclared (first use in this function)
> > include/asm/mach-summit/mach_apic.h:91: error: (Each undeclared identifier is reported only once
> > include/asm/mach-summit/mach_apic.h:91: error: for each function it appears in.)
> > Is the patch below correct?
> 
> Well I guess it would fix the apicid_2_node build error but I can't
> think of a single good reason to be in a config where you would need any
> of the summit code in UP.

The reason I allowed it originally was that it would allow UP distribution
boot kernels to find all devices on Summit where you need the special
APIC drivers etc. for that.

But then distributions are mostly switching to SMP kernels by default
anyways so it's a bit obsolete.

-Andi
