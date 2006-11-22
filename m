Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756292AbWKVSJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbWKVSJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbWKVSJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:09:05 -0500
Received: from colo.lackof.org ([198.49.126.79]:13789 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1756290AbWKVSJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:09:04 -0500
Date: Wed, 22 Nov 2006 11:09:01 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 2/5] PCI : Move pci_fixup_device and is_enabled
Message-ID: <20061122180901.GD378@colo.lackof.org>
References: <456404EF.3090902@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456404EF.3090902@jp.fujitsu.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 05:06:07PM +0900, Hidetoshi Seto wrote:
> --- linux-2.6.19-rc6.orig/drivers/pci/pci.c
> +++ linux-2.6.19-rc6/drivers/pci/pci.c
> @@ -558,12 +558,18 @@
>  {
>  	int err;
> 
> +	if (dev->is_enabled)
> +		return 0;

This is unfortunately going to collide with the previous
patch posted by inaky@linux.intel.com:

    Subject: [patch 0/2] pci: make pci_{enable,disable}_device() be nested

grant
