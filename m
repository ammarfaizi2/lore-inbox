Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTEIX5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTEIX5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:57:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:34277 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263612AbTEIX5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:57:09 -0400
Date: Fri, 9 May 2003 17:11:34 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: mochel@osdl.org, alan@redhat.com, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <20030510001134.GA3769@kroah.com>
References: <20030506035635.GA5403@kroah.com> <Pine.LNX.4.44.0305061123490.7233-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0305061123490.7233-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 11:35:17AM -0500, Matt Domsch wrote:
> > You can't just call driver_attach(), as the bus semaphore needs to be
> > locked before doing so.  In short, you almost need to duplicate
> > bus_add_driver(), but not quite :)
> 
> Right, and it seems to work. I made driver_attach non-static, declared
> it extern in pci.h, and call it in pci-driver.c while holding the bus
> semaphore and references to the driver and the bus.  This also let me
> delete my probe_each_pci_dev() function and let the driver core
> handle it.

Nice, this looks much better.  I don't have a problem with this patch
anymore.  I'll wait for Pat to ack the driver core changes to see if he
agrees with them before sending this on.

thanks,

greg k-h
