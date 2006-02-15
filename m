Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423057AbWBOJHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423057AbWBOJHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423059AbWBOJHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:07:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423057AbWBOJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:07:42 -0500
Date: Wed, 15 Feb 2006 09:07:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, greg@kroah.com
Subject: Re: [RFC][PATCH 1/4] PCI legacy I/O port free driver - Introduce pci_set_bar_mask*()
Message-ID: <20060215090732.GA15898@flint.arm.linux.org.uk>
Mail-Followup-To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz, greg@kroah.com
References: <43F172BA.1020405@jp.fujitsu.com> <43F17379.8010900@jp.fujitsu.com> <20060214210744.3a7a756a.akpm@osdl.org> <43F2C44C.7080806@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F2C44C.7080806@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:03:56PM +0900, Kenji Kaneshige wrote:
> Andrew Morton wrote:
> >Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> >
> >>This patch introduces a new interface pci_select_resource() for PCI
> >>device drivers to tell kernel what resources they want to use.
> >
> >
> >It'd be nice if we didn't need to introduce any new API functions for this.
> >If we could just do:
> >
> >struct pci_something pci_something_table[] = {
> >	...
> >	{
> >		...
> >		.dont_allocate_io_space = 1,
> >		...
> >	},
> >	...
> >};
> >
> >within each driver which wants it.
> >
> >But I can't think of a suitable per-device-id structure with which we can
> >do that :(
> >
> >
> 
> My another idea was to use pci quirks. In this approach, we don't
> need to introduce any new API. But I gave up this idea because it
> looked abuse of pci quirks.
> 
> Anyway, I try to think about new ideas we don't need to introduce
> any new API.

What about pci_enable_device_bars() ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
