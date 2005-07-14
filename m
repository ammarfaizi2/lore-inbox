Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVGNTy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVGNTy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVGNTyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:54:53 -0400
Received: from cantor.suse.de ([195.135.220.2]:63136 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261707AbVGNTyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:54:24 -0400
Date: Thu, 14 Jul 2005 21:54:23 +0200
From: Andi Kleen <ak@suse.de>
To: "Ronald G. Minnich" <rminnich@lanl.gov>
Cc: Andi Kleen <ak@suse.de>, Li-Ta Lo <ollie@lanl.gov>,
       yhlu <yinghailu@gmail.com>, Stefan Reinauer <stepan@openbios.org>,
       discuss@x86-64.org, LinuxBIOS <linuxbios@openbios.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [LinuxBIOS] NUMA support for dual core Opteron
Message-ID: <20050714195422.GJ23737@wotan.suse.de>
References: <2ea3fae10507141058c476927@mail.gmail.com> <1121365786.3317.6.camel@logarithm.lanl.gov> <20050714184821.GJ23619@wotan.suse.de> <Pine.LNX.4.58.0507141303210.22630@enigma.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507141303210.22630@enigma.lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 01:04:26PM -0600, Ronald G. Minnich wrote:
> 
> 
> On Thu, 14 Jul 2005, Andi Kleen wrote:
> 
> > However you'll likely need ACPI for other reasons anyways, e.g. for
> > better power saving.
> 
> bummer. What the BIOS vendors are doing (to lock in proprietary BIOS, some
> say)  is making ACPI tables copyright the BIOS vendor, not the motherboard 
> vendor. So LinuxBIOS will have to reverse engineer their own, somehow. 

You don't need full support, many of it is optional and will
fall back to the old methods if not available. e.g. you can
probably leave out most of the PCI support if you don't want to support
PCI hotplug. Longer term it might be needed again for power management
though.

Doing PST objects for power saving shouldn't be that difficult, but you
need knowledge of the CPUs from their data sheet (and some testing 
if the power regulators on the mobo can take all the transitions) 
But it shouldn't be very motherboard specific.

However that said there is a lot of useful information
in the FADT and some other tables and I definitely plan to use more of it 
in the future.

-Andi

