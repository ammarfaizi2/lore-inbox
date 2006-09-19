Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751932AbWISSii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWISSii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWISSii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:38:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:49315 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751920AbWISSig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:38:36 -0400
Date: Tue, 19 Sep 2006 11:36:26 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1
Message-ID: <20060919183626.GA9727@kroah.com>
References: <20060919012848.4482666d.akpm@osdl.org> <20060919142116.GA29190@kroah.com> <20060919093641.734f8120.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919093641.734f8120.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 09:36:41AM -0700, Andrew Morton wrote:
> On Tue, 19 Sep 2006 07:21:16 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > Although the ia64 one should not be due to anything in the driver tree,
> > I don't know what caused that, the pci tree is pretty tiny right now.
> 
> drivers/pci/probe.c: In function `pci_create_legacy_files':
> drivers/pci/probe.c:45: warning: implicit declaration of function `device_create_bin_file'
> drivers/pci/probe.c: In function `pci_remove_legacy_files':
> drivers/pci/probe.c:61: warning: implicit declaration of function `device_remove_bin_file'
> drivers/pci/probe.c: In function `pci_create_bus':
> drivers/pci/probe.c:1033: warning: label `sys_create_link_err' defined but not used
> 
> The changes inside HAVE_PCI_LEGACY broke.
> 
> gregkh-pci-pci_bridge-device.patch
> gregkh-pci-pci-sort-device-lists-breadth-first.patch and
> gregkh-pci-pci-must_check-fixes.patch
> 
> touch that file.

Ok, thanks, only ia64 has HAVE_PCI_LEGACY still enabled and I missed
that.

It should now be fixed, sorry for the noise.

thanks,

greg k-h
