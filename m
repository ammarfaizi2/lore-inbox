Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRLNXNV>; Fri, 14 Dec 2001 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280365AbRLNXNL>; Fri, 14 Dec 2001 18:13:11 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:3852 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280191AbRLNXNC>;
	Fri, 14 Dec 2001 18:13:02 -0500
Date: Fri, 14 Dec 2001 15:10:34 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: kaos@ocs.com.au, Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: modules.pcimap and 8139's
Message-ID: <20011214151034.A16902@kroah.com>
In-Reply-To: <3C1A7CA1.D6C119DC@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1A7CA1.D6C119DC@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 16 Nov 2001 20:55:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 05:26:41PM -0500, Jeff Garzik wrote:
> Various tools need to pick "8139cp.c" instead of "8139too.c" based on
> PCI revision, which is not in modules.pcimap nor struct pci-device-id. 
> grep for 'pci_rev' in both those files to see the PCI revision checks
> hand-coded currently in the drivers.
> 
> What is the preferred -2.4- solution?
> 
> a) append pci rev and mask to the end of each modules.pcimap line, and
> update struct pci_device_id?
> b) create new file modules.pci_rev?
> c) other?

d) ignore it :)

linux-hotplug should try to run modprobe on every module that matches in
the modules.pcimap table.  That way the modules can fight it out for who
really wants to control the device (I am assuming that the different
modules know about the pci revision, right?)

modules.pcimap is used to narrow the choices, not necessarily pick the
"only" choice.

thanks,

greg k-h
