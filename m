Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUI2VPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUI2VPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUI2VOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:14:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:26509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269042AbUI2VNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:13:09 -0400
Date: Wed, 29 Sep 2004 10:48:46 -0700
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, johnrose@austin.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] PPC64: RPA dynamic addition/removal of PCI Host Bridges
Message-ID: <20040929174844.GB12906@kroah.com>
References: <16730.17837.387665.396256@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16730.17837.387665.396256@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:18:37PM +1000, Paul Mackerras wrote:
> From: John Rose <johnrose@austin.ibm.com>
> 
> The following patch implements the ppc64-specific bits for dynamic (DLPAR)
> addition of PCI Host Bridges.  The entry point for this operation is
> init_phb_dynamic(), which will be called by the RPA DLPAR driver.  
> 
> Among the implementation details, the global number aka PCI domain for the
> newly added PHB is assigned using the same simple counter that assigns it at
> boot.  This has two consequences.  First, the PCI domain associated with a PHB
> will not persist across DLPAR remove and subsequent add.  Second, stress tests
> that repeatedly add/remove PHBs might generate some large values for PCI
> domain.  If we decide at a later point to hash an OF property to PCI domain
> value, this can be easily fixed up.
> 
> Also, the linux,pci-domain property is not generated for the newly added PHBs
> at the moment.  Because there doesn't seem to be an easy way to dynamically add
> single properties to the OFDT, and because the userspace dependency on this
> property is being questioned, I've ignored it for now.  If we decide on a
> solution for this at a later point, it can also be easily fixed up.

Applied, thanks.

greg k-h

