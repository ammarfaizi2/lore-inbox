Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSDOScr>; Mon, 15 Apr 2002 14:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313139AbSDOScq>; Mon, 15 Apr 2002 14:32:46 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:60428 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313132AbSDOScp>;
	Mon, 15 Apr 2002 14:32:45 -0400
Date: Mon, 15 Apr 2002 10:32:08 -0700
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-pre3 full compile - warnings
Message-ID: <20020415173208.GN21707@kroah.com>
In-Reply-To: <1605.1018774441@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 18 Mar 2002 13:44:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 06:54:01PM +1000, Keith Owens wrote:
> 
> drivers/hotplug/pci_hotplug_core.c:90: warning: `pcihpfs_statfs' defined but not used

Ah, this one shows up due to libfs now being in the kernel.  I'll fix
it.

> drivers/hotplug/ibmphp.o: In function `ibmphp_configure_card':
> drivers/hotplug/ibmphp.o(.text+0x5159): undefined reference to `ibmphp_pci_root_ops'
> drivers/hotplug/ibmphp.o(.text+0x51e0): undefined reference to `ibmphp_pci_root_ops'
> drivers/hotplug/ibmphp.o(.text+0x5206): undefined reference to `ibmphp_pci_root_ops'
> drivers/hotplug/ibmphp.o(.text+0x541a): undefined reference to `ibmphp_pci_root_ops'
> drivers/hotplug/ibmphp.o(.text+0x565c): undefined reference to `ibmphp_pci_root_ops'
> drivers/hotplug/ibmphp.o(.text+0x5a87): more undefined references to `ibmphp_pci_root_ops' follow

These linker errors should be fixed in 2.5.8 now.

thanks,

greg k-h
