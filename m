Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbULQVrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbULQVrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbULQVrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:47:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:3014 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262163AbULQVq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:46:58 -0500
Date: Fri, 17 Dec 2004 13:46:46 -0800
From: Greg KH <greg@kroah.com>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: linux-kernel@vger.kernel.org, Chris Dearman <chris@mips.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] Don't touch BARs of host bridges
Message-ID: <20041217214646.GB22597@kroah.com>
References: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412092349560.6535@perivale.mips.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 12:20:40AM +0000, Maciej W. Rozycki wrote:
> Hello,
> 
>  BARs of host bridges often have special meaning and AFAIK are best left 
> to be setup by the firmware or system-specific startup code and kept 
> intact by the generic resource handler.  For example a couple of host 
> bridges used for MIPS processors interpret BARs as target-mode decoders 
> for accessing host memory by PCI masters (which is quite reasonable).  
> For them it's desirable to keep their decoded address range overlapping 
> with the host RAM for simplicity if nothing else (I can imagine running 
> out of address space with lots of memory and 32-bit PCI with no DAC 
> support in the participating devices).
> 
>  This is already the case with the i386 and ppc platform-specific PCI 
> resource allocators.  Please consider the following change for the generic 
> allocator.  Currently we have a pile of hacks implemented for host bridges 
> to be left untouched and I'd be pleased to remove them.

I've applied this to my trees, and it will show up in the next -mm
release, and then on to Linus's tree after 2.6.10 is out.

Oh, and next time, I need a "Signed-off-by:" line as per
Documentation/SubmittingPatches.

thanks,

greg k-h
