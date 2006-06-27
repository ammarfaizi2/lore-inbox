Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWF0BDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWF0BDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWF0BDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:03:55 -0400
Received: from mga06.intel.com ([134.134.136.21]:27453 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030322AbWF0BDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:03:53 -0400
X-IronPort-AV: i="4.06,178,1149490800"; 
   d="scan'208"; a="57050952:sNHT518961142"
Date: Mon, 26 Jun 2006 17:57:20 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: Andi Kleen <ak@suse.de>, rajesh.shah@intel.com, akpm@osdl.org,
       brice@myri.com, 76306.1226@compuserve.com, arjan@linux.intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] x86_64 PCI: improve extended config space verification
Message-ID: <20060626175720.A31701@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20060623200928.036235000@rshah1-sfield.jf.intel.com> <20060623201601.752629000@rshah1-sfield.jf.intel.com> <200606232230.36579.ak@suse.de> <20060623224318.GB31139@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060623224318.GB31139@suse.de>; from gregkh@suse.de on Fri, Jun 23, 2006 at 03:43:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 03:43:18PM -0700, Greg KH wrote:
> On Fri, Jun 23, 2006 at 10:30:36PM +0200, Andi Kleen wrote:
> > On Friday 23 June 2006 22:09, rajesh.shah@intel.com wrote:
> > > Extend the verification for PCI-X/PCI-Express extended config
> > > space pointer. This patch checks whether the MCFG address range
> > > is listed as a motherboard resource, per the PCI firmware spec.
> > > The old check only looked in int 15 e820 memory map, causing
> > > several systems to fail the verification and lose extended
> > > config space.
> > 
> > By adding so much code to it you volunteered to factor the 
> > sanity check into a common i386/x86-64 file first.
> 
> I agree :)
> 
> Also, have you looked at the current -git tree?  It also modified some
> stuff in this area?  Look at commit
> ead2bfeb7f739d2ad6e09dc1343f0da51feb7f51 for details.
> 
OK, I just reposted after moving the code to a common file. I did
check that it compiled against the current -git tree, though the
testing was done with -mm2. This did give me back my extended
config space, but it would also be nice if it made a difference
to the other folks who had reported this problem (CC'd).

thanks,
Rajesh
