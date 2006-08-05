Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWHEHy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWHEHy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 03:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWHEHy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 03:54:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:28646 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422752AbWHEHy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 03:54:58 -0400
Date: Sat, 5 Aug 2006 00:54:39 -0700
From: Greg KH <greg@kroah.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 4/4] PCI-Express AER implemetation: pcie_portdrv error handler
Message-ID: <20060805075439.GA2300@kroah.com>
References: <1154330118.27051.73.camel@ymzhang-perf.sh.intel.com> <1154330319.27051.76.camel@ymzhang-perf.sh.intel.com> <1154330492.27051.79.camel@ymzhang-perf.sh.intel.com> <1154330776.27051.83.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154330776.27051.83.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 03:26:16PM +0800, Zhang, Yanmin wrote:
> From: Zhang, Yanmin <yanmin.zhang@intel.com>
> 
> Patch 4 implements error handlers for pcie_portdrv.
> 
> Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

This patch causes the following build warnings:

  CC      drivers/pci/pcie/portdrv_pci.o
drivers/pci/pcie/portdrv_pci.c: In function `pcie_portdrv_probe':
drivers/pci/pcie/portdrv_pci.c:66: warning: implicit declaration of function `pcie_portdrv_save_config'
drivers/pci/pcie/portdrv_pci.c: At top level:
drivers/pci/pcie/portdrv_pci.c:81: warning: static declaration of 'pcie_portdrv_save_config' follows non-static declaration
drivers/pci/pcie/portdrv_pci.c:66: warning: previous implicit declaration of 'pcie_portdrv_save_config' was here

Can you please resend a version of this patch to fix this?

thanks,

greg k-h
