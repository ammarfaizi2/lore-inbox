Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVHRXDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVHRXDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 19:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVHRXDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 19:03:51 -0400
Received: from mail.suse.de ([195.135.220.2]:63659 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932361AbVHRXDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 19:03:50 -0400
Date: Fri, 19 Aug 2005 01:03:49 +0200
From: Andi Kleen <ak@suse.de>
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64]
Message-ID: <20050818230349.GC22993@wotan.suse.de>
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel> <p73u0hmsy83.fsf@verdi.suse.de> <1124405533.14825.24.camel@home-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124405533.14825.24.camel@home-lap>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 03:52:13PM -0700, Sean Bruno wrote:
> With earlier kernels(2.6.11) I was able to boot my machine with ACPI
> enabled, but most devices(sound, onboard ethernet, SATA controllers,
> USB) were unusuable but they were detected.  I was able to work around
> this issue by disabling ACPI in my system BIOS.  

Keeping it on and using pci=noacpi might be better.

> available.  Since 2.6.12, when I re-activate ACPI in my system BIOS, I
> can't boot my machine as it gives me an error about no IOMMU and having
> 6GB of RAM.  This error was not listed in the dmesg posted before as I
> can't boot my machine past this error.
> 
> Here is the exact output when booting 2.6.13 with ACPI enabled:
> 
> Decompressing Linux ... Done
> Booting the kernel
> PCI-DMA:  More that 4GB of RAM and no IOMMU
> PCI-DMA:  32bit PCI IO may malfunction.<6>PCI-DMA:  Disabling IOMMU

This has nothing to do with ACPI. The problem here is that you 
didn't enable the IOMMU code in the kernel .config

-Andi
