Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUHMX4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUHMX4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbUHMX4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:56:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35817 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267808AbUHMXzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:55:18 -0400
Date: Sat, 14 Aug 2004 01:55:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Message-ID: <20040813235515.GB28687@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <200408121550.15892.bjorn.helgaas@hp.com> <1092350580.7765.190.camel@dhcppc4> <200408131515.56322.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408131515.56322.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 03:15:56PM -0600, Bjorn Helgaas wrote:
> On Thursday 12 August 2004 4:43 pm, Len Brown wrote:
> > I expect that the the bug is that floppy.c, like other motherboard
> > devices, should take advantage of ACPI for device resource
> > enumeration.
> 
> Adrian, can you try the following patch?  This is very sketchy start
> at using ACPI to enumerate floppies.  This patch only checks for
> a floppy controller (PNP0700) in the ACPI namespace.  If ACPI has
> been disabled, or we actually find a controller, we probe blindly
> for the floppy controller as we did in the past.  If ACPI is enabled
> and we DON'T find a controller, we just exit with -ENODEV.
>...

It fixes my problem.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

