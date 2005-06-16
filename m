Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVFPWoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVFPWoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFPWnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:43:55 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:53060 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261872AbVFPWms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:42:48 -0400
Date: Thu, 16 Jun 2005 15:42:23 -0700
From: Greg KH <gregkh@suse.de>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: len.brown@intel.com, ak@suse.de, acpi-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/04] PCI: use the MCFG table to properly access pci devices (x86-64)
Message-ID: <20050616224223.GA13619@suse.de>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com> <20050616153404.B5337@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616153404.B5337@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 03:34:06PM -0700, Rajesh Shah wrote:
> On Tue, Jun 14, 2005 at 10:32:14PM -0700, Greg KH wrote:
> > 
> > +	for (i = 0; i < pci_mmcfg_config_num; ++i) {
> > +		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
> > +		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
> 
> This will map 256MB for each mmcfg aperture, probably better
> to restrict it based on bus number range for this aperture.

It should be 1MB per bus number, right?

thanks,

greg k-h
