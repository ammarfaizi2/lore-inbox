Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUKMJMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUKMJMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 04:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUKMJMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 04:12:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43275 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261458AbUKMJMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 04:12:12 -0500
Date: Sat, 13 Nov 2004 09:12:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
Message-ID: <20041113091208.A30939@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <1100301717571@kroah.com> <11003017181402@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11003017181402@kroah.com>; from greg@kroah.com on Fri, Nov 12, 2004 at 03:21:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 03:21:58PM -0800, Greg KH wrote:
> ChangeSet 1.2091.1.2, 2004/11/11 16:32:25-08:00, jdittmer@ppp0.net
> 
> [PATCH] fakephp: introduce pci_bus_add_device
> 
> fakephp needs to add newly discovered devices to the global pci list.
> Therefore seperate out the appropriate chunk from pci_bus_add_devices
> to pci_bus_add_device to add a single device to sysfs, procfs
> and the global device list.

Why is this needed?  pci_bus_add_devices() is designed to only add new
devices to the device tree - new devices have an empty dev->global_list.

Just calling pci_bus_add_devices() for the parent bus should suffice.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
