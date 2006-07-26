Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWGZQrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWGZQrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWGZQrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:47:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:52969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932190AbWGZQrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:47:08 -0400
Date: Wed, 26 Jul 2006 09:42:46 -0700
From: Greg KH <gregkh@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: restore missing PCI registers after reset
Message-ID: <20060726164246.GE9871@suse.de>
References: <20060726162007.GA9871@suse.de> <20060726163226.GG9411@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726163226.GG9411@mellanox.co.il>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 07:32:26PM +0300, Michael S. Tsirkin wrote:
> Quoting r. Greg KH <gregkh@suse.de>:
> > I think pci_restore_state() already restores the msi and msix state,
> > take a look at the latest kernel version :)
> 
> Yes, I know :)
> but I am not talking abotu MSI/MSI-X, I am talking about the following:
> > > >   PCI-X device: PCI-X command register
> > > >   PCI-X bridge: upstream and downstream split transaction registers
> > > >   PCI Express : PCI Express device control and link control registers
> 
> these register values include maxumum MTU for PCI express and other vital
> data.

Make up a patch that shows how you would save these in a generic way and
we can discuss it.  I know people have talked about saving the extended
PCI config space for devices that need it, so that might be all you
need to do here.

thanks,

greg k-h
