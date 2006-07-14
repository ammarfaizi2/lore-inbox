Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWGNOEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWGNOEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWGNOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:04:23 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:23493 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030453AbWGNOEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:04:22 -0400
Date: Fri, 14 Jul 2006 09:57:54 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch, take 3] PCI: use ACPI to verify extended config
  space on x86
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607141000_MC3-1-C4FF-945F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1152869988.3159.25.camel@laptopd505.fenrus.org>

On Fri, 14 Jul 2006 11:39:48 +0200, Arjan van de Ven wrote:

> > Extend the verification for PCI-X/PCI-Express extended config
> > space pointer. Checks whether the MCFG address range is listed
> > as a motherboard resource, per the PCI firmware spec.
> 
> I'm still not quite happy about this; the entire point of the check is
> that we CAN'T trust the ACPI implementation, and want a second opinion.
> This patch basically asks the ACPI implementation if we can trust the
> ACPI implementation. I'm not sure that's a good idea.
> And I understood that most issues went away with the more relaxed check
> that is in gregkh's tree already (if not in mainline, I should check
> that). 

The more-relaxed check is in mainline.  I wrote it, but it didn't even
fix the problem on my own machine. This did.

According to Rajesh, the spec doesn't require the MCFG space to be
e820-reserved, so that's not really a valid check.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
