Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVHSPql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVHSPql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVHSPql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:46:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:50850 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751174AbVHSPql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:46:41 -0400
Date: Fri, 19 Aug 2005 17:46:39 +0200
From: Andi Kleen <ak@suse.de>
To: Peter Buckingham <peter@pantasys.com>
Cc: Sean Bruno <sean.bruno@dsl-only.net>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64](WITHOUT NVIDIA MODULE)
Message-ID: <20050819154639.GL22993@wotan.suse.de>
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel> <p73u0hmsy83.fsf@verdi.suse.de> <1124405533.14825.24.camel@home-lap> <20050818230349.GC22993@wotan.suse.de> <1124410753.14825.32.camel@home-lap> <4305FCF1.6020905@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4305FCF1.6020905@pantasys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 08:38:25AM -0700, Peter Buckingham wrote:
> Hi Sean,
> 
> Sean Bruno wrote:
> >Well, I do have IOMMU enabled in my kernel .config.  I have attached it
> >to this message as well.  I would appreciate any guidance as I pretty
> >much have no idea what 99% of the items in here are for.  This is
> >the .config that I used to build the kernel from the dmesg output that
> >is attached to this email.
> 
> the error that you see is because you haven't set a big enough size in 
> the BIOS for the IOMMU. The error message is just saying that the kernel 
> is enabling the IOMMU anyway. It used to be that it would enable 64MB, 
> it looks like it's defaulting now to 256MB. When you enable a big enough 
> size in the bios this error will go away (assuming that your bios fills 
> in the registers correctly).

At least his original error message can only happen when  CONFIG_GART_IOMMU
is disabled.

PCI-DMA:  More that 4GB of RAM and no IOMMU                                                                                    
PCI-DMA:  32bit PCI IO may malfunction.<6>PCI-DMA:  Disabling IOMMU                                               


-Andi
