Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVF0USj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVF0USj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVF0USi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:18:38 -0400
Received: from fmr23.intel.com ([143.183.121.15]:56006 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261604AbVF0USY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:18:24 -0400
Date: Mon, 27 Jun 2005 13:18:11 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com, rajesh.shah@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI-based PCI resources: PCMCIA bugfix, but resources missing in trees
Message-ID: <20050627131810.A23808@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626140411.GA8597@dominikbrodowski.de> <20050626121710.44c1df8d.akpm@osdl.org> <20050626201414.GA22402@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050626201414.GA22402@isilmar.linta.de>; from linux@dominikbrodowski.net on Sun, Jun 26, 2005 at 10:14:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 10:14:14PM +0200, Dominik Brodowski wrote:
> > Is this a recent regression?  Is it only in -mm?
> 
> Yes. Yes.
> 
> > IOW: can you identify the bad patch?  Or the bad patcher ;)
> 
> gregkh-pci-pci-collect-host-bridge-resources-02.patch
> 

Guilty as charged. I will look at providing a fix. In the meantime,
you can drop this patch if you like Andrew.

> > >  - verify_root_windows() should fail if there are no iomem _or_ ioport
> > >    resources, not only if there are no iomem _and_ ioport resources.
> > 

No, I actually saw production (or close to production) machines
where BIOS was deliberately only programming memory resources, no
IO. In fact, I had to change the check to the current form for such
machines.

Rajesh
