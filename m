Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVI0Poe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVI0Poe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVI0Pod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:44:33 -0400
Received: from colo.lackof.org ([198.49.126.79]:13530 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S964978AbVI0Pod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:44:33 -0400
Date: Tue, 27 Sep 2005 09:51:03 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
Message-ID: <20050927155103.GA9294@colo.lackof.org>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net> <20050927044840.GA21108@colo.lackof.org> <20050926215245.7a1be7fa.rdunlap@xenotime.net> <20050927052128.GB21108@colo.lackof.org> <17209.3427.936263.463751@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17209.3427.936263.463751@alkaid.it.uu.se>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 11:14:11AM +0200, Mikael Pettersson wrote:
> Grant Grundler writes:
>  > Yeah, my preference would be PCI_MSI only depend on Local APIC.
>  > (Note that having a Local APIC implies having an IO APIC as well
> 
> Not true. Lots of systems have a local APIC but no I/O APICs.

Eh?!!!
Do systems with Local APIC still have IRQ lines going to the CPU?
How does PCI IRQ line otherwise generate an interrupt?

> However, having an I/O APIC pretty much implies having a local APIC.

Ok - That sounds right for x86 and is true for ia64.
parisc has IO SAPICs but no local APIC.

parisc and (IIRC) alpha has the functional equivalent of Local APIC
but the implementation details are different. ie they can't share
code with x86/ia64.

thanks,
grant
