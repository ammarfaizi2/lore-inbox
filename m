Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTCGBAX>; Thu, 6 Mar 2003 20:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbTCGBAX>; Thu, 6 Mar 2003 20:00:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8458 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261312AbTCGBAW>;
	Thu, 6 Mar 2003 20:00:22 -0500
Date: Thu, 6 Mar 2003 17:01:03 -0800
From: Greg KH <greg@kroah.com>
To: Pawe? Go?aszewski <blues@ds.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.64] depmod problem
Message-ID: <20030307010102.GC13766@kroah.com>
References: <Pine.LNX.4.51L.0303070158580.14030@piorun.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51L.0303070158580.14030@piorun.ds.pg.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 02:00:01AM +0100, Pawe? Go?aszewski wrote:
> When making depmod on fresh 2.5.64 I get:
> 
> # /sbin/depmod -ae -F System.map  2.5.64
> WARNING: /lib/modules/2.5.64/kernel/drivers/hotplug/acpiphp.ko needs unknown symbol acpi_resource_to_address64

Wow, you actually have a ACPI PCI Hotplug machine?  I didn't know any
were in the wild yet.  What kind is it?

To fix this add:
	EXPORT_SYMBOL(acpi_resource_to_address64);
to drivers/acpi/acpi_ksyms.c

thanks,

greg k-h
