Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268716AbUJEAOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268716AbUJEAOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268711AbUJEAOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:14:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:46545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268716AbUJEAOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:14:00 -0400
Date: Mon, 4 Oct 2004 17:17:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004171745.2a1b1884.akpm@osdl.org>
In-Reply-To: <200410050205.58155.annabellesgarden@yahoo.de>
References: <200410041634.24937.annabellesgarden@yahoo.de>
	<20041004212633.GA13527@elte.hu>
	<20041004143738.5ca9c43f.akpm@osdl.org>
	<200410050205.58155.annabellesgarden@yahoo.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese <annabellesgarden@yahoo.de> wrote:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c018ee07
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: uhci_hcd apm via686a eeprom i2c_sensor i2c_isa i2c_viapro 
> i2c_core parport_pc lp parport snd_via82xx snd_ac97_codec snd_pcm snd_timer 
> snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore nfsd 
> exportfs lockd sunrpc nls_iso8859_1 nls_cp437 vfat fat nls_utf8 ntfs ext3 jbd 
> sym53c8xx scsi_transport_spi sd_mod scsi_mod
> CPU:    0
> EIP:    0060:[<c018ee07>]    Not tainted VLI
> EFLAGS: 00210246   (2.6.9-rc3-mm2)
> EIP is at remove_proc_entry+0x27/0x150
> eax: 00000000   ebx: cffdb800   ecx: ffffffff   edx: 00000000
> esi: c13e1200   edi: 00000000   ebp: c52ba000   esp: c52bbe88
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 3243, threadinfo=c52ba000 task=cc2f6dd0)
> Stack: c52ba000 00000003 cc88c620 c01bd93e 00000000 c56b1540 c13e1200 c03aeb60
>        c013c763 00000000 cffdb800 c52ba000 00200212 00000009 c13e1200 c1293400
>        c1293444 c52ba000 c026f877 00000009 c13e1200 c129349c 00000001 c1293400
> Call Trace:
>  [<c01bd93e>] kobject_put+0x1e/0x30
>  [<c013c763>] free_irq+0x93/0x100
>  [<c026f877>] usb_hcd_pci_remove+0xb7/0x190
>  [<c01c9596>] pci_device_remove+0x76/0x80
>  [<c021b2e6>] device_release_driver+0x66/0x70
>  [<c021b31b>] driver_detach+0x2b/0x40
>  [<c021b7bc>] bus_remove_driver+0x4c/0x90
>  [<c021bd13>] driver_unregister+0x13/0x30
>  [<c01c9816>] pci_unregister_driver+0x16/0x30
>  [<d0a3ff9f>] uhci_hcd_cleanup+0xf/0x66 [uhci_hcd]
>  [<c01372b5>] sys_delete_module+0x155/0x180
>  [<c0150f87>] sys_munmap+0x47/0x70
>  [<c010620d>] sysenter_past_esp+0x52/0x71

I think the USB guys have sorted out a few things in there, so maybe this will
be fixed in next -mm.
