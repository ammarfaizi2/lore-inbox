Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSKAWWd>; Fri, 1 Nov 2002 17:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265799AbSKAWWd>; Fri, 1 Nov 2002 17:22:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17926 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265798AbSKAWWb>;
	Fri, 1 Nov 2002 17:22:31 -0500
Date: Fri, 1 Nov 2002 14:25:50 -0800
From: Greg KH <greg@kroah.com>
To: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre10-ac2: proc_bus_pci_dir unresolved in pci_hotplug.o module
Message-ID: <20021101222550.GD18015@kroah.com>
References: <20021101150129.A15230@skunk.physik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101150129.A15230@skunk.physik.uni-erlangen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 03:01:29PM +0100, Christian Vogel wrote:
> Hi,
> 
> when insmodding the pci_hotplug.o module I get unresolved symbol
> proc_bus_pci_dir on Kernel 2.4.20-pre10-ac2.
> 
> The symbol is declared extern here:
> 
> drivers/hotplug/pci_hutplug_core.c (line 131) has:
>         extern struct proc_dir_entry *proc_bus_pci_dir
> 
> The symbol is defined here:
> 
> drivers/pci/proc.c (line 372) has:
>         struct proc_dir_entry *proc_bus_pci_dir
> 
> Probably some EXPORT_SYMBOL(proc_bus_pci_dir) is missing
> in the latter file?...

It is exported in the main 2.4.20-rc1 tree, so hopefully the next time
Alan syncs up he will get this fix.

thanks,

greg k-h
