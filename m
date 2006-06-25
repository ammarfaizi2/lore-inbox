Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWFYUJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWFYUJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFYUJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:09:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43025 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932242AbWFYUJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:09:55 -0400
Date: Sun, 25 Jun 2006 22:09:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Miles Lane <miles.lane@gmail.com>,
       Kristen Accardi <kristen.c.accardi@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, len.brown@intel.com, linux-acpi@vger.kernel.org
Subject: Re: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Message-ID: <20060625200953.GF23314@stusta.de>
References: <a44ae5cd0606251256m74182e7fw4eb2692c89b0e2f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0606251256m74182e7fw4eb2692c89b0e2f8@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 12:56:44PM -0700, Miles Lane wrote:
> drivers/built-in.o: In function
> `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined
> reference to `is_dock_device'
> drivers/built-in.o: In function
> `cleanup_bridge':acpiphp_glue.c:(.text+0x12bc4): undefined reference
> to `is_dock_device'
> :acpiphp_glue.c:(.text+0x12bd3): undefined reference to
> `unregister_hotplug_dock_device'
> :acpiphp_glue.c:(.text+0x12bdb): undefined reference to
> `unregister_dock_notifier'
> drivers/built-in.o: In function
> `register_slot':acpiphp_glue.c:(.text+0x13ac0): undefined reference to
> `is_dock_device'
> :acpiphp_glue.c:(.text+0x13cd9): undefined reference to `is_dock_device'
> :acpiphp_glue.c:(.text+0x13cf0): undefined reference to
> `register_hotplug_dock_device'
> :acpiphp_glue.c:(.text+0x13d1d): undefined reference to 
> `register_dock_notifier'
> make: *** [.tmp_vmlinux1] Error 1
> 
> #
> # PCI Hotplug Support
> #
> CONFIG_HOTPLUG_PCI=y
> CONFIG_HOTPLUG_PCI_FAKE=y
> CONFIG_HOTPLUG_PCI_COMPAQ=y
> # CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
> CONFIG_HOTPLUG_PCI_ACPI=y
> CONFIG_HOTPLUG_PCI_ACPI_IBM=y
> CONFIG_HOTPLUG_PCI_CPCI=y
> # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> CONFIG_HOTPLUG_PCI_SHPC=y
> # CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set


You hadn't attached your complete .config, but is it correct when I 
assume you have CONFIG_ACPI_DOCK=m? This would explain the problem.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

