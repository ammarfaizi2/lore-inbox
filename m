Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUBWVPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUBWVNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:13:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:2001 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262051AbUBWVJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:09:21 -0500
Date: Mon, 23 Feb 2004 13:09:22 -0800
From: Greg KH <greg@kroah.com>
To: Tobias Oed <tobiasoed@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in pci_find_subsys
Message-ID: <20040223210922.GC22598@kroah.com>
References: <BAY12-F104dqK4Zd2yg00005ba3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY12-F104dqK4Zd2yg00005ba3@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 08:51:45AM -0800, Tobias Oed wrote:
> [*]
> Do I need to hold the pci_bus_lock spinlock for the following (checks for 
> NULL omitted here)
> dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
> dev = pci_dev_get(dev);
> I'd rater use pci_get_slot instead of pci_find_slot, but I don't know how to 
> get a struct pci_bus *  from an int.

You should never need to use those functions at all anyway.  Just use
the proper pci_register_driver() call and be done with it.

thanks,

greg k-h
