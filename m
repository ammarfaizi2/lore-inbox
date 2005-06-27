Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVF0U36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVF0U36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVF0U16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:27:58 -0400
Received: from isilmar.linta.de ([213.239.214.66]:21454 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261604AbVF0U0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:26:14 -0400
Date: Mon, 27 Jun 2005 22:26:06 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI-based PCI resources: PCMCIA bugfix, but resources missing in trees
Message-ID: <20050627202606.GA27492@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Rajesh Shah <rajesh.shah@intel.com>, Andrew Morton <akpm@osdl.org>,
	greg@kroah.com, linux-kernel@vger.kernel.org
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626140411.GA8597@dominikbrodowski.de> <20050626121710.44c1df8d.akpm@osdl.org> <20050626201414.GA22402@isilmar.linta.de> <20050627131810.A23808@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627131810.A23808@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 01:18:11PM -0700, Rajesh Shah wrote:
> > > >  - verify_root_windows() should fail if there are no iomem _or_ ioport
> > > >    resources, not only if there are no iomem _and_ ioport resources.
> > > 
> 
> No, I actually saw production (or close to production) machines
> where BIOS was deliberately only programming memory resources, no
> IO. In fact, I had to change the check to the current form for such
> machines.

Well, what should be done in this case? IMO we should fall back to the
"previous" behaviour -- is a 
                        kfree(bus->resource[i]);
                        bus->resource[i] = bres[i];
needed for this to happen?

Thanks,
	Dominik
