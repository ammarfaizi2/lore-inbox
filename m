Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTEMVQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTEMVQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:16:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:38528 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263245AbTEMVP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:15:27 -0400
Date: Tue, 13 May 2003 14:28:27 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Matt Domsch <Matt_Domsch@Dell.com>
cc: Greg KH <greg@kroah.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>, <jgarzik@redhat.com>
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
In-Reply-To: <Pine.LNX.4.44.0305061123490.7233-100000@humbolt.us.dell.com>
Message-ID: <Pine.LNX.4.44.0305131428050.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 May 2003, Matt Domsch wrote:

> > You can't just call driver_attach(), as the bus semaphore needs to be
> > locked before doing so.  In short, you almost need to duplicate
> > bus_add_driver(), but not quite :)
> 
> Right, and it seems to work. I made driver_attach non-static, declared
> it extern in pci.h, and call it in pci-driver.c while holding the bus
> semaphore and references to the driver and the bus.  This also let me
> delete my probe_each_pci_dev() function and let the driver core
> handle it.
> 
> Pat, can you ack the changes to bus.c and device.h please?

ACK. I'll add them to my tree.

Thanks,


	-pat

