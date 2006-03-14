Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbWCNGN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWCNGN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWCNGN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:13:59 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:9171 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1751692AbWCNGN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:13:59 -0500
Date: Tue, 14 Mar 2006 01:19:39 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>
Subject: Re: [PATCH 0/9] PNP: adjust pnp_register_driver signature
Message-ID: <20060314061938.GB22354@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
	Matthieu Castet <castet.matthieu@free.fr>,
	Li Shaohua <shaohua.li@intel.com>
References: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 04:01:27PM -0700, Bjorn Helgaas wrote:
> This series of patches removes the assumption that pnp_register_driver()
> returns the number of devices claimed.  Returning the count is unreliable
> because devices may be hot-plugged in the future.  (Many devices don't
> support hot-plug, of course, but PNP in general does.)
> 
> This changes the convention to "zero for success, or a negative error
> value," which matches pci_register_driver(), acpi_bus_register_driver(),
> and platform_driver_register().
> 
> If drivers need to know the number of devices, they can count calls
> to their .probe() methods.

Andrew, I'd appreciate if you add this to mainline when it's convenient to
make non-critical changes.

Thanks,
Adam
