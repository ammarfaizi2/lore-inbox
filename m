Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbULTSYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbULTSYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 13:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbULTSYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 13:24:43 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:52161 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261607AbULTSYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 13:24:36 -0500
Date: Mon, 20 Dec 2004 10:24:16 -0800
From: Greg KH <greg@kroah.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20041220182416.GA20951@kroah.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024074749A1@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024074749A1@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 10:15:30AM -0800, Nguyen, Tom L wrote:
> Friday, December 17, 2004 4:06 PM, Greg KH wrote: 
> > Hm, I get a oops message at boot time, on a non-pci express box, with
> > PCI_GOMMCONFIG enabled and your patch.  Something down in the ACPI
> > subsystem. 
> >
> > Have you tested this kind of configuration?
> With PCI_GOMMCONFIG enabled and PCIE Port Bus driver included, I got
> kernel 
> panic at boot time on a non-pci express box. Similar to your case, I 
> observed something down in the ACPI subsystem. I tested the other case 
> where the kernel is built with PCI_GOMMCONFIG and without PCIE Port 
> Bus driver being included, same kernel panic occurred at boot time. I
> tested 
> another case where the kernel is built with PCI_GOANY and with PCIE Port
> 
> Bus driver being included, the kernel boots fine. Based on these test
> results, 
> it seems that PCI_GOMMCONFIG, not PCIE Port Bus driver, is a root cause 
> of kernel panic.
> 
> > I'll hold off on applying the patch for now due to this :)
> It seems that it is ok to apply the patch for now. What do you think?

I think you might want to either get the PCI_GOANY code to work with the
pci express driver, or fix up the PCI_GOMMCONFIG case in the acpi code,
as no distro will ever enable PCI_GOMMCONFIG in the current case :)

Sound ok?

thanks,

greg k-h
