Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWDZTlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWDZTlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWDZTlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:41:52 -0400
Received: from smtp1.xandros.com ([209.87.236.18]:62380 "EHLO xandros.com")
	by vger.kernel.org with ESMTP id S964852AbWDZTlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:41:51 -0400
Message-ID: <444FCCFC.2060408@xandros.com>
Date: Wed, 26 Apr 2006 15:41:48 -0400
From: Woody Suwalski <woodys@xandros.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Highpoint SATA RAID (khe khe) status -- oopses, crashes, etc
References: <65zwE-61W-35@gated-at.bofh.it>
In-Reply-To: <65zwE-61W-35@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko wrote:
> Dear Kernel Developers,
> 
> I've search the archive and the web extensively: there were some reports
> from the users of RocketRaid 1520 fakeraid about inability to use
> propriatary drivers as well as their opensource drivers:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113566695101306&w=2
> and leaving the hope reply from Dr.Cox:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113631066409179&w=2
> 
> compiled for amd64:
> 2.6.8 kernel: oopsed but seems to somewhat perform after that
> 2.6.15 kernel:  oopsed during boot (debian installer for some reason
> tried it automatically.... grrr) and then it would halt any insmod of
> any IDE driver
> 
> Details on my system and boot/install process can be found from
> http://www.onerussian.com/Linux/bugs/hpt.bug/
> This time I was using beta debian etch installer (which supposedly had
> freshier kernel than sarge's 2.6.8)
> 
> Please advise: can I do anything about this crappy card or I better
> setup nfsroot for now and just buy another supported SATA raid card?
> Thank you in advance. I am willing to perform more testing if that is
> necessary/possible
> 
> Relevant part of syslog (kernel 2.6.15-1-amd64)
> 
> Apr 25 09:42:17 kernel: HPT372A: IDE controller at PCI slot 0000:04:05.0
> Apr 25 09:42:17 kernel: GSI 17 sharing vector 0xB1 and IRQ 17
> Apr 25 09:42:17 kernel: ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 16 (level, low) -> IRQ 17
> Apr 25 09:42:17 kernel: HPT372A: chipset revision 2
> Apr 25 09:42:17 kernel: HPT372A: 100% native mode on irq 17
> Apr 25 09:42:17 kernel: hpt: HPT372N detected, using 372N timing.
> Apr 25 09:42:17 kernel: FREQ: 125 PLL: 45
> Apr 25 09:42:17 kernel: HPT37XN: unknown bus timing [48 4].
> Apr 25 09:42:17 kernel: hpt: no known IDE timings, disabling DMA.
> Apr 25 09:42:17 kernel: hpt: HPT372N detected, using 372N timing.
> Apr 25 09:42:17 kernel: FREQ: 140 PLL: 66
> Apr 25 09:42:17 kernel: HPT37XN: unknown bus timing [69 4].
> Apr 25 09:42:17 kernel: hpt: no known IDE timings, disabling DMA.
> Apr 25 09:42:17 kernel: Probing IDE interface ide2...
> Apr 25 09:42:17 kernel: hde: WDC WD800JD-55MSA1, ATA DISK drive
> Apr 25 09:42:17 kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
> Apr 25 09:42:18 S30read-environment: Setting debconf/priority to 'low'.
> Apr 25 09:42:18 frontend: Setting debconf/priority to low
> Apr 25 09:42:18 preseed: successfully loaded preseed file from /preseed.cfg
> Apr 25 09:42:18 udevd-event[1231]: run_program: '/sbin/modprobe' abnormal exit
> Apr 25 09:42:18 kernel: Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> Apr 25 09:42:18 kernel: <ffffffff8802b069>{:hpt366:pci_bus_clock_list+16}
> Apr 25 09:42:18 kernel: PGD 7f904067 PUD 7da23067 PMD 0 
> Apr 25 09:42:18 kernel: Oops: 0000 [1] 
> Apr 25 09:42:18 kernel: CPU 0 
> Apr 25 09:42:18 kernel: Modules linked in: thermal processor fan generic hpt366 ide_core ohci_hcd
> Apr 25 09:42:18 kernel: Pid: 1232, comm: modprobe Not tainted 2.6.15-1-amd64-generic #2
> Apr 25 09:42:18 kernel: RIP: 0010:[<ffffffff8802b069>] <ffffffff8802b069>{:hpt366:pci_bus_clock_list+16}
> Apr 25 09:42:18 kernel: RSP: 0000:ffff81007d0d5b40  EFLAGS: 00010246
> Apr 25 09:42:18 kernel: RAX: 0000000000000000 RBX: 0000000030070000 RCX: 0000000000000051
> Apr 25 09:42:18 kernel: RDX: 000000000000000c RSI: 0000000000000000 RDI: 000000000000000c
> Apr 25 09:42:18 kernel: RBP: 0000000000000051 R08: 0000000000000000 R09: 0000000000000000
> Apr 25 09:42:18 kernel: R10: 0000000000000093 R11: ffffffff80249ec7 R12: ffff81007f427000
> Apr 25 09:42:18 kernel: R13: ffff81007f994940 R14: ffffffff88023698 R15: 000000000000000c
> Apr 25 09:42:18 kernel: FS:  00002aaaaad816c0(0000) GS:ffffffff803c8800(0000) knlGS:0000000000000000
> Apr 25 09:42:18 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> Apr 25 09:42:18 kernel: CR2: 0000000000000000 CR3: 000000007e824000 CR4: 00000000000006e0
> Apr 25 09:42:18 kernel: Process modprobe (pid: 1232, threadinfo ffff81007d0d4000, task ffff81007e598200)
> Apr 25 09:42:18 kernel: Stack: ffffffff8802c389 400c81007e598200 ffff81007e598200 0000000000000000 
> Apr 25 09:42:18 kernel:        ffffffff88023580 ffffffff88023580 0000000000000000 ffffffff8802ec60 
> Apr 25 09:42:18 kernel:        ffffffff880235a0 ffffffff88023698 
> Apr 25 09:42:18 kernel: Call Trace:<ffffffff8802c389>{:hpt366:hpt372_tune_chipset+202}
> Apr 25 09:42:18 kernel:        <ffffffff8802c42c>{:hpt366:hpt3xx_tune_chipset+62} <ffffffff8800d427>{:ide_core:ide_get_best_pio_mode+104}
> Apr 25 09:42:18 kernel:        <ffffffff8800eb2f>{:ide_core:probe_hwif+1780} <ffffffff8800f725>{:ide_core:probe_hwif_init_with_fixup+14}
> Apr 25 09:42:18 kernel:        <ffffffff8801174b>{:ide_core:ide_setup_pci_device+71}
> Apr 25 09:42:18 kernel:        <ffffffff80230744>{get_device+20} <ffffffff801dc4fe>{pci_match_device+17}
> Apr 25 09:42:18 kernel:        <ffffffff801dc5de>{pci_device_probe+74} <ffffffff80231c62>{driver_probe_device+63}
> Apr 25 09:42:18 kernel:        <ffffffff80231d15>{__driver_attach+0} <ffffffff80231d4a>{__driver_attach+53}
> Apr 25 09:42:18 kernel:        <ffffffff8023133e>{bus_for_each_dev+67} <ffffffff80231744>{bus_add_driver+116}
> Apr 25 09:42:18 kernel:        <ffffffff801dc382>{__pci_register_driver+132} <ffffffff80142815>{sys_init_module+4932}
> Apr 25 09:42:18 kernel:        <ffffffff80154e2d>{vma_prio_tree_insert+30} <ffffffff8015b7b1>{do_mmap_pgoff+1512}
> Apr 25 09:42:18 kernel:        <ffffffff8016cc8f>{sys_newfstat+32} <ffffffff8010e4ba>{system_call+126}
> Apr 25 09:42:18 kernel:        
> Apr 25 09:42:18 kernel: 
> Apr 25 09:42:18 kernel: Code: 8a 06 84 c0 75 ee 8b 46 04 c3 48 c7 c6 60 f1 02 88 eb 84 80 
> Apr 25 09:42:18 kernel: RIP <ffffffff8802b069>{:hpt366:pci_bus_clock_list+16} RSP <ffff81007d0d5b40>
> Apr 25 09:42:18 kernel: CR2: 0000000000000000
> Apr 25 09:42:18 kernel: vga16fb: initializing
> Apr 25 09:42:18 kernel: vga16fb: mapped to 0xffff8100000a0000
> Apr 25 09:42:18 kernel: Console: switching to colour frame buffer device 80x30
> Apr 25 09:42:18 kernel: fb0: VGA16 VGA frame buffer device

I had a similar segfault caused by hpt366 hardware.
I have made a small patch to simply assume in such bad case the slowest 
possible setting and avoid the NULL pointer, however it is not a 
officialy good solution. My hardware is so crappy, that timing can not 
be really adjusted, even Alan Cox's newest and greatest ide-on-sata 
falls back to the 33MHz timings. After the patch the controller works, 
however really slow.
In the patch below, you can try as well thirty_three in place of 
sixty_six (for testing):


--- linux-2.6.15/drivers/ide/pci/hpt366.c.2.6.15        2006-01-02 
22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/ide/pci/hpt366.c       2006-03-09 
13:45:54.000000000 -0500
@@ -680,6 +680,13 @@ static int hpt370_tune_chipset(ide_drive
         list_conf = pci_bus_clock_list(speed, info->speed);

         pci_read_config_dword(dev, drive_pci, &drive_conf);
+
+       // woody@xandros.com: if we have a NULL table, assume the slowest
+       if (! info->speed)
+       {
+               info->speed = sixty_six_base_hpt370a;
+       }
+
         list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);

         if (speed < XFER_MW_DMA_0)
@@ -708,7 +715,14 @@ static int hpt372_tune_chipset(ide_drive
         drive_fast &= ~0x07;
         pci_write_config_byte(dev, regfast, drive_fast);

+       // woody@xandros.com: if we have a NULL table, assume the slowest
+       if (! info->speed)
+       {
+               info->speed = sixty_six_base_hpt372;
+       }
+
         list_conf = pci_bus_clock_list(speed, info->speed);
+
         pci_read_config_dword(dev, drive_pci, &drive_conf);
         list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
         if (speed < XFER_MW_DMA_0)
@@ -1288,6 +1302,10 @@ static void __devinit hpt37x_clocking(id
                                 goto init_hpt37X_done;
                         }
                 }
+               if (!pci_get_drvdata(dev)) {
+                       printk("No Clock Stabilization!!!\n");
+                       return;
+               }
  pll_recal:
                 if (adjust & 1)
                         pll -= (adjust >> 1);




Woody
