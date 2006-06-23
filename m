Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWFWWqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWFWWqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWFWWqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:46:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8602 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752132AbWFWWqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:46:39 -0400
Date: Fri, 23 Jun 2006 15:43:18 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: rajesh.shah@intel.com, akpm@osdl.org, brice@myri.com,
       76306.1226@compuserve.com, arjan@linux.intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] x86_64 PCI: improve extended config space verification
Message-ID: <20060623224318.GB31139@suse.de>
References: <20060623200928.036235000@rshah1-sfield.jf.intel.com> <20060623201601.752629000@rshah1-sfield.jf.intel.com> <200606232230.36579.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606232230.36579.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 10:30:36PM +0200, Andi Kleen wrote:
> On Friday 23 June 2006 22:09, rajesh.shah@intel.com wrote:
> > Extend the verification for PCI-X/PCI-Express extended config
> > space pointer. This patch checks whether the MCFG address range
> > is listed as a motherboard resource, per the PCI firmware spec.
> > The old check only looked in int 15 e820 memory map, causing
> > several systems to fail the verification and lose extended
> > config space.
> 
> By adding so much code to it you volunteered to factor the 
> sanity check into a common i386/x86-64 file first.

I agree :)

Also, have you looked at the current -git tree?  It also modified some
stuff in this area?  Look at commit
ead2bfeb7f739d2ad6e09dc1343f0da51feb7f51 for details.

thanks,

greg k-h
