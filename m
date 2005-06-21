Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVFUXMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVFUXMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVFUXFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:05:17 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:11297 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262398AbVFUW4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:56:07 -0400
Date: Tue, 21 Jun 2005 15:55:51 -0700
From: Greg KH <gregkh@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
Message-ID: <20050621225551.GB24289@suse.de>
References: <20050619233029.45dd66b8.akpm@osdl.org> <20050620131451.GA9739@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620131451.GA9739@shadowen.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 02:14:51PM +0100, Andy Whitcroft wrote:
> Having trouble getting 2.6.12-mm1 to compile on my x86 test
> boxes other than a basic PC.  I suspect this patch is to 'blame'.
> 
> > +gregkh-pci-pci-assign-unassigned-resources.patch
> 
> We seem to need to include setup-bus.o for most x86 architectures
> regardless of HOTPLUG.  Not sure if this is the right fix, but it
> seems to work on the systems I have tested.
> 
> -apw
> 
> === 8< ===
> It seems that X86 architectures in general need the setup-bus.o
> not just those with HOTPLUG.  This avoids the following error on
> X86_NUMAQ and x86_64:
> 
>     arch/i386/pci/built-in.o(.init.text+0x15a6): In function `pcibios_init':
>     : undefined reference to `pci_assign_unassigned_resources'
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>

Sounds like a NUMA issue, right?  If you don't have HOTPLUG enabled, X86
should not need setup_bus.  Care to find the real problem here?

thanks,

greg k-h
