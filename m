Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWGFTSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWGFTSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWGFTSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:18:07 -0400
Received: from colin.muc.de ([193.149.48.1]:64777 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750736AbWGFTSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:18:05 -0400
Date: 6 Jul 2006 21:18:04 +0200
Date: Thu, 6 Jul 2006 21:18:04 +0200
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060706191804.GB97717@muc.de>
References: <20060705220425.GB83806@muc.de> <m1odw32rep.fsf@ebiederm.dsl.xmission.com> <20060706130153.GA66955@muc.de> <m18xn621i6.fsf@ebiederm.dsl.xmission.com> <20060706165159.GB66955@muc.de> <m18xn6zkx3.fsf@ebiederm.dsl.xmission.com> <20060706180826.GA95795@muc.de> <1152210898.13734.12.camel@localhost.localdomain> <20060706182729.GA97717@muc.de> <m1fyhey2hc.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fyhey2hc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 01:09:35PM -0600, Eric W. Biederman wrote:
> > Then anything with MMIO or interrupts or anything dynamic 
> > definitely belongs into kernel space agreed.
> 
> Yep we sometimes have to mess with MMIO.

Not on K8 at least, no? 

Maybe we should discuss each chipset separatedly :)

> 
> > But at least on K8 DIMM inventory is purely reading PCI config space on
> > something that doesn't change and doesn't need any locking. 
> > It also doesn't need to do anything complicated, but just look
> > for the right PCI ID.
> 
> Mostly.  Except for the part where you have to figure out the stepping
> of the processor connected to the memory controller to properly decode
> the registers.  AMD should have used the revision field in pci config
> space but...

That's in /proc/cpuinfo

-Andi
