Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755091AbWKWDlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbWKWDlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 22:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbWKWDlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 22:41:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:25571 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1755084AbWKWDlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 22:41:18 -0500
Date: Wed, 22 Nov 2006 19:34:51 -0800
From: Greg KH <greg@kroah.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 2/5] PCI : Move pci_fixup_device and is_enabled
Message-ID: <20061123033451.GB15439@kroah.com>
References: <456404EF.3090902@jp.fujitsu.com> <20061122180901.GD378@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122180901.GD378@colo.lackof.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 11:09:01AM -0700, Grant Grundler wrote:
> On Wed, Nov 22, 2006 at 05:06:07PM +0900, Hidetoshi Seto wrote:
> > --- linux-2.6.19-rc6.orig/drivers/pci/pci.c
> > +++ linux-2.6.19-rc6/drivers/pci/pci.c
> > @@ -558,12 +558,18 @@
> >  {
> >  	int err;
> > 
> > +	if (dev->is_enabled)
> > +		return 0;
> 
> This is unfortunately going to collide with the previous
> patch posted by inaky@linux.intel.com:
> 
>     Subject: [patch 0/2] pci: make pci_{enable,disable}_device() be nested

Not a problem, that's what I'm here for :)

thanks,

greg k-h
