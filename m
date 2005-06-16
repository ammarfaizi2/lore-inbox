Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVFPWmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVFPWmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFPWlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:41:31 -0400
Received: from fmr22.intel.com ([143.183.121.14]:11680 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261852AbVFPWeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:34:19 -0400
Date: Thu, 16 Jun 2005 15:34:06 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: len.brown@intel.com, ak@suse.de, acpi-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/04] PCI: use the MCFG table to properly access pci devices (x86-64)
Message-ID: <20050616153404.B5337@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com> <20050615053214.GD23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050615053214.GD23394@kroah.com>; from gregkh@suse.de on Tue, Jun 14, 2005 at 10:32:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 10:32:14PM -0700, Greg KH wrote:
> 
> +	for (i = 0; i < pci_mmcfg_config_num; ++i) {
> +		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
> +		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);

This will map 256MB for each mmcfg aperture, probably better
to restrict it based on bus number range for this aperture.

Since you are reworking the patches, I will wait for the
next version and try that out on a couple of Intel x86_64
boxes here.

Rajesh

