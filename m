Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVCAKHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVCAKHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 05:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVCAKHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 05:07:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:7048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261848AbVCAKHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 05:07:42 -0500
Date: Tue, 1 Mar 2005 02:07:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-Id: <20050301020722.6faffb69.akpm@osdl.org>
In-Reply-To: <20050228231721.GA1326@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw, suspend is a bit messy.  The disk spins down.  Then up.  Then down
again.  And:



Stopping tasks: ==========================================|
Freeing memory... done (7069 pages freed)                  
swsusp: Need to copy 7847 pages          
swsusp: critical section/: done (7879 pages copied)
swsusp: Restoring Highmem                          
Debug: sleeping function called from invalid context at mm/slab.c:2082
in_atomic():0, irqs_disabled():1                                      
 [<c010318d>] dump_stack+0x19/0x20
 [<c0111731>] __might_sleep+0x91/0x9c
 [<c01365df>] kmem_cache_alloc+0x23/0x84
 [<c0232d50>] acpi_evaluate_integer+0x3c/0xac
 [<c024b3d9>] acpi_bus_get_status+0x39/0x94  
 [<c024ca99>] acpi_pci_link_set+0x16d/0x1e8
 [<c024ce65>] acpi_pci_link_resume+0x1d/0x28
 [<c024ce8a>] irqrouter_resume+0x1a/0x38    
 [<c0281e3c>] sysdev_resume+0x2c/0xae   
 [<c0285ea8>] device_power_up+0x8/0x11
 [<c012a873>] swsusp_suspend+0x4b/0x58
 [<c012ac35>] pm_suspend_disk+0x35/0x74
 [<c01292ea>] enter_state+0x2e/0x70    
 [<c0129336>] software_suspend+0xa/0x10
 [<c024a8a7>] acpi_system_write_sleep+0x73/0x98
 [<c0149f1b>] vfs_write+0xaf/0x118             
 [<c014a028>] sys_write+0x3c/0x68 
 [<c0102c05>] sysenter_past_esp+0x52/0x75
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64           
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:02:01.2: USB 2.0 restarted, EHCI 0.95, driver 10 Dec 2004
ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 9 (level, low) -> IRQ 9     
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex          
Writing data to swap (7879 pages)... done               
Writing pagedir (31 pages)               
S|                        
Powering off system
Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
in_atomic():0, irqs_disabled():1                                                
 [<c010318d>] dump_stack+0x19/0x20
 [<c0111731>] __might_sleep+0x91/0x9c
 [<c0285872>] device_shutdown+0x16/0x82
 [<c012aa97>] power_down+0x47/0x74     
 [<c012ac5a>] pm_suspend_disk+0x5a/0x74
 [<c01292ea>] enter_state+0x2e/0x70    
 [<c0129336>] software_suspend+0xa/0x10
 [<c024a8a7>] acpi_system_write_sleep+0x73/0x98
 [<c0149f1b>] vfs_write+0xaf/0x118             
 [<c014a028>] sys_write+0x3c/0x68 
 [<c0102c05>] sysenter_past_esp+0x52/0x75
Synchronizing SCSI cache for disk sda:   
Shutdown: hda                          
acpi_power_off called
