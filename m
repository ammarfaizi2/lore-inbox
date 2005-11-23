Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVKWUf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVKWUf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVKWUfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:35:51 -0500
Received: from ns.suse.de ([195.135.220.2]:30863 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932392AbVKWUe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:34:57 -0500
Date: Wed, 23 Nov 2005 21:34:56 +0100
From: Andi Kleen <ak@suse.de>
To: Ronald G Minnich <rminnich@lanl.gov>
Cc: yhlu <yinghailu@gmail.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linuxbios@openbios.org, yhlu <yhlu.kernel@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123203456.GQ20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com> <4384CFCD.9010304@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384CFCD.9010304@lanl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:23:41PM -0700, Ronald G Minnich wrote:
> yeah, this is the great thing about ACPI, it has put us into a whole new 
>  era of copyrighted stuff. ACPI tables describe hardware, and are 
> copyright bios vendors. The question of which ACPI bits we can use in 
> linuxbios is unresolved. AMD has committed to open-source ACPI tables, 
> but ... what about companies like nvidia? unknown. And, to add to the 
> fun, the mainboard vendors don't own their own ACPI tables -- the BIOS 
> vendors do. So the mainboard vendor has their hardware design encoded 
> into ACPI tables, which are copyright the bios vendor, not the mainboard 
> vendor.

I don't think it's as bad as you describe. Once you have a free reference
DSL it shouldn't be very difficult to vary it for specific
platforms. I guess that is what the proprietary BIOS writers are doing too. 

Some systems have very complex ACPI tables, but for others they 
can be quite simple and a lot of the complexity can be just ignored.

I suppose you could even write a generic translator from mptables to ACPI 
tables (although I suspect more and more setups cannot be described
in the old tables) 

BTW there are other reasons now to support ACPI, like the MCFG tables
that are needed for extended config space accesses (necessary
e.g. for PCI Express error handling) or the HPET table for the HPET timer.

-Andi
