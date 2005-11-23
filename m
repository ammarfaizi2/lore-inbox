Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVKWDLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVKWDLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVKWDLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:11:07 -0500
Received: from ns.suse.de ([195.135.220.2]:41347 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932490AbVKWDLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:11:06 -0500
Date: Wed, 23 Nov 2005 04:11:04 +0100
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-git latest build broken on UP x86-64
Message-ID: <20051123031104.GC20775@brahms.suse.de>
References: <20051122190202.40efabfb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122190202.40efabfb@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 07:02:02PM -0800, Stephen Hemminger wrote:
> This looks new, it happens on Fedora Core 4 with UP x86-64.
> 
> arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: ???ipi_handler??? undeclared (first use in this function)
> arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is reported only once
> arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)
> make[2]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.o] Error 1
> make[2]: Target `__build' not remade because of errors.
> make[1]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr] Error 2
> 
> arch/x86_64/kernel/nmi.c:155: error: ???nmi_cpu_busy??? undeclared (first use in this function)
> arch/x86_64/kernel/nmi.c:155: error: (Each undeclared identifier is reported only once
> arch/x86_64/kernel/nmi.c:155: error: for each function it appears in.)
> make[1]: *** [arch/x86_64/kernel/nmi.o] Error 1
> make[1]: Target `__build' not remade because of errors.
> make: *** [arch/x86_64/kernel] Error 2

Works for me with -git2 and defconfig changed to UP. config please and last changeset.

-Andi
