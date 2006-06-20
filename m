Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWFTWjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWFTWjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWFTWji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:39:38 -0400
Received: from melchior.nuitari.net ([209.222.54.175]:52876 "EHLO
	melchior.nuitari.net") by vger.kernel.org with ESMTP
	id S1751355AbWFTWjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:39:02 -0400
Date: Tue, 20 Jun 2006 18:37:16 -0400 (EDT)
From: Nuitari <nuitari@melchior.nuitari.net>
To: linux-kernel@vger.kernel.org
Subject: pci=assign-busses on Compaq R3440CA
Message-ID: <Pine.LNX.4.64.0606201807090.15246@melchior.nuitari.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Compaq R3440CA laptop.

Without the pci=assign-busses option I have this happenning:

[   13.311216] PCI: Bus #03 (-#06) is hidden behind  bridge #02 (-#02) (try 'pci=assign-busses')
[   13.311292] Please report the result to linux-kernel to fix this permanently
[   13.311386] PCI: Bus #07 (-#0a) is hidden behind  bridge #02 (-#02) (try 'pci=assign-busses')
[   13.311462] Please report the result to linux-kernel to fix this permanently

This is lspci without the option:
00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
00:06.1 Modem: nVidia Corporation Unknown device 00d9 (rev a2)
00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5)
00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go 32M] (rev a3)
02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
02:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
02:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
02:04.2 System peripheral: Texas Instruments PCI1620 Firmware Loading Function (rev 01)

and this is lspci with the option:
fistandantilus ~ # lspci
00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
00:06.1 Modem: nVidia Corporation Unknown device 00d9 (rev a2)
00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5)
00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
01:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:02.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 03)
01:04.0 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
01:04.1 CardBus bridge: Texas Instruments PCI1620 PC Card Controller (rev 01)
01:04.2 System peripheral: Texas Instruments PCI1620 Firmware Loading Function (rev 01)
0a:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go 32M] (rev a3)


Initially I though that pci=assign-busses fixed a boot up BUG, however it 
reappered in subsequent testing. The bug happens when udev-090 is 
processing the events.

[   30.687843] usbcore: registered new driver usbfs
[   30.687929] usbcore: registered new driver hub
[   30.699191] acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
[   30.700367] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
[   30.700430] GSI 20 sharing vector 0xD1 and IRQ 20
[   30.700488] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 20 (level, low) -> IRQ 209
[   30.700890] PCI: Setting latency timer of device 0000:00:02.2 to 64
[   30.700898] ehci_hcd 0000:00:02.2: EHCI Host Controller
[   30.701169] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
[   30.701280] PCI: cache line size of 64 is not supported by device 0000:00:02.2
[   30.701292] ehci_hcd 0000:00:02.2: irq 209, io mem 0xe0004000
[   30.701352] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   30.701510] usb usb1: configuration #1 chosen from 1 choice
[   30.701591] hub 1-0:1.0: USB hub found
[   30.701651] hub 1-0:1.0: 6 ports detected
[   30.702436] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   30.817058] acpi_bus-0201 [04] bus_set_power         : Device is not power manageable
[   30.817202] PCI: Enabling device 0000:00:02.0 (0004 -> 0006)
// Long waiting period here
[   91.732028] BUG: soft lockup detected on CPU#0!
[   91.732083]
[   91.732084] Call Trace: <IRQ> <ffffffff802ad30c>{softlockup_tick+188}
[   91.732273]        <ffffffff80297677>{update_process_times+87} <ffffffff80277e42>{main_timer_handler+562}
[   91.732479]        <ffffffff802780c5>{timer_interrupt+21} <ffffffff8021082c>{handle_IRQ_event+44}
[   91.732682]        <ffffffff802ad4ee>{__do_IRQ+190} <ffffffff80276af9>{do_IRQ+57}
[   91.732882]        <ffffffff802679cc>{ret_from_intr+0} <ffffffff80404b90>{acpi_pci_irq_enable+0}
[   91.733086]        <ffffffff8021081a>{handle_IRQ_event+26} <ffffffff80293166>{tasklet_action+70}
[   91.733287]        <ffffffff802ad4ee>{__do_IRQ+190} <ffffffff80276af9>{do_IRQ+57}
[   91.733486]        <ffffffff802679cc>{ret_from_intr+0} <EOI> <ffffffff80404b90>{acpi_pci_irq_enable+0}
[   91.733719]        <ffffffff80404cc1>{acpi_pci_irq_enable+305} <ffffffff80404bda>{acpi_pci_irq_enable+74}
[   91.733921]        <ffffffff803afd75>{pci_enable_device_bars+53} <ffffffff803afdab>{pci_enable_device+27}
[   91.734127]        <ffffffff88011643>{:usbcore:usb_hcd_pci_probe+83} <ffffffff803b1659>{pci_device_probe+89}
[   91.734367]        <ffffffff8042d125>{driver_probe_device+101} <ffffffff8042d200>{__driver_attach+0}
[   91.734572]        <ffffffff8042d256>{__driver_attach+86} <ffffffff8042d200>{__driver_attach+0}
[   91.735825]        <ffffffff8042ca09>{bus_for_each_dev+73} <ffffffff8042c5d8>{bus_add_driver+136}
[   91.736027]        <ffffffff803b1891>{__pci_register_driver+65} <ffffffff802a69fc>{sys_init_module+188}
[   91.736229]        <ffffffff802674d2>{system_call+126}

