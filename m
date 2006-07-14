Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWGNOP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWGNOP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWGNOP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:15:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:58567 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030453AbWGNOP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:15:56 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch, take 3] PCI: use ACPI to verify extended config space on x86
Date: Fri, 14 Jul 2006 16:15:41 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200607141000_MC3-1-C4FF-945F@compuserve.com>
In-Reply-To: <200607141000_MC3-1-C4FF-945F@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141615.41338.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 15:57, Chuck Ebbert wrote:
> In-Reply-To: <1152869988.3159.25.camel@laptopd505.fenrus.org>
> 
> On Fri, 14 Jul 2006 11:39:48 +0200, Arjan van de Ven wrote:
> 
> > > Extend the verification for PCI-X/PCI-Express extended config
> > > space pointer. Checks whether the MCFG address range is listed
> > > as a motherboard resource, per the PCI firmware spec.
> > 
> > I'm still not quite happy about this; the entire point of the check is
> > that we CAN'T trust the ACPI implementation, and want a second opinion.
> > This patch basically asks the ACPI implementation if we can trust the
> > ACPI implementation. I'm not sure that's a good idea.
> > And I understood that most issues went away with the more relaxed check
> > that is in gregkh's tree already (if not in mainline, I should check
> > that). 
> 
> The more-relaxed check is in mainline.  I wrote it, but it didn't even
> fix the problem on my own machine. 

Why did you submit it then when it didn't work?

> This did. 
> 
> According to Rajesh, the spec doesn't require the MCFG space to be
> e820-reserved, so that's not really a valid check.

Anyways Rajesh's patch is probably the way to go. If the ACPI
implementatin is self consistent it can be probably trusted.

The e820 check was just a heuristic and it clearly wasn't a good one. 

-Andi
 
