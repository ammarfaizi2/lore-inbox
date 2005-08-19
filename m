Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVHSQLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVHSQLp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVHSQLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:11:45 -0400
Received: from iron.pdx.net ([207.149.241.18]:42916 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S1751215AbVHSQLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:11:45 -0400
Subject: Re: 2.6.13-rc6-git10 test report [x86_64](WITHOUT NVIDIA MODULE)
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Peter Buckingham <peter@pantasys.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <430601C5.5080505@pantasys.com>
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel>
	 <p73u0hmsy83.fsf@verdi.suse.de> <1124405533.14825.24.camel@home-lap>
	 <20050818230349.GC22993@wotan.suse.de> <1124410753.14825.32.camel@home-lap>
	 <4305FCF1.6020905@pantasys.com> <20050819154639.GL22993@wotan.suse.de>
	 <4306002F.4000000@pantasys.com> <20050819155332.GM22993@wotan.suse.de>
	 <430601C5.5080505@pantasys.com>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 09:11:42 -0700
Message-Id: <1124467902.14825.41.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 08:59 -0700, Peter Buckingham wrote:
> Andi Kleen wrote:
> > On Fri, Aug 19, 2005 at 08:52:15AM -0700, Peter Buckingham wrote:
> > 
> >>Andi Kleen wrote:
> >>
> >>>At least his original error message can only happen when  CONFIG_GART_IOMMU
> >>>is disabled.
> >>>
> >>>PCI-DMA:  More that 4GB of RAM and no IOMMU                                
> >>>PCI-DMA:  32bit PCI IO may malfunction.<6>PCI-DMA:  Disabling IOMMU        
> >>
> >>Yeah, I agree. In the later dmesgs, though, it seems to be enabled.
> > 
> > 
> > Those don't show any failure.
> 
> no they don't. basically it just says your bios hasn't configured enough 
> IOMMU space, so the kernel is going to do it anyway. it's really just a 
> warning or an fyi rather than an error. i may have chosen the word 
> poorly ;-)
> 
> in short Sean, this isn't a big deal. you only really need to change 
> this if you want to remove a warning from your dmesg output.
> 
> peter

Well, there doesn't appear to be any reference to a setting in my BIOS
for this size(IOMMU).  So I don't think that I can change it!  :(

The machine is working quite a bit better with pci=noacpi in leu of
disabling ACPI in the BIOS, but there are still those nasty errors in
reference to the ACPI tables being broken:
    ACPI-0362: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace,
AE_NOT_FOUND
search_node ffff8101428572c0 start_node ffff8101428572c0 return_node
0000000000000000

And this one about the 8254 timer:
..MP-BIOS bug: 8254 timer not connected to IO-APIC

And finally, I think that something else kind of wierd is happening with
the on-board sensors.  lm_sensors is having trouble detecting the fan
speeds and temperatures of the main board, but I will take that up with
their developers.

Sean


