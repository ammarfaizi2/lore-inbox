Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUCCQrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUCCQrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:47:49 -0500
Received: from itesec.hsc.fr ([192.70.106.33]:45829 "EHLO itesec.hsc.fr")
	by vger.kernel.org with ESMTP id S261782AbUCCQrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:47:45 -0500
Date: Wed, 3 Mar 2004 17:41:48 +0100
From: Jerome Poggi <Jerome.Poggi@hsc.fr>
To: linux-kernel@vger.kernel.org
Cc: Jerome Poggi <Jerome.Poggi@hsc.fr>
Subject: [ACPI] - Kernel 2.6.3 - Error ACPI-0279 & ACPI-1120
Message-ID: <20040303164148.GA9403@efflam.hsc.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Slackware 9.1
Organization: Herve Schauer Consultants
X-Organization: Herve Schauer Consultants
X-Address: 4bis Rue de la Gare, F-92300 Levallois-Perret, France
X-Phone: +33 141 409 700
X-Fax: +33 141 409 709
X-Web: http://www.hsc.fr/
X-GPG-fingerprint: C34A C116 1AA2 84AD 2592  1F98 FBB0 84A0 34AF BB17
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me all answers


I use a Gentoo kernel linux-2.6.3-gentoo-r2 and I get this error
suddenly :

Mar  3 17:21:30 efflam ACPI-0279: *** Error: Looking up [BUFF] in namespace, AE_ALREADY_EXISTS
Mar  3 17:21:30 efflam ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
Mar  3 17:21:34 efflam ACPI-0279: *** Error: Looking up [BUFF] in namespace, AE_ALREADY_EXISTS
Mar  3 17:21:34 efflam ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
Mar  3 17:21:35 efflam ACPI-0279: *** Error: Looking up [BUFF] in namespace, AE_ALREADY_EXISTS
Mar  3 17:21:35 efflam ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
Mar  3 17:21:40 efflam ACPI-0279: *** Error: Looking up [BUFF] in namespace, AE_ALREADY_EXISTS
Mar  3 17:21:40 efflam ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
Mar  3 17:21:45 efflam ACPI-0279: *** Error: Looking up [BUFF] in namespace, AE_ALREADY_EXISTS
Mar  3 17:21:45 efflam ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS

so I take a look at /proc and I see this :

root@efflam:/proc/acpi/battery/BAT1 # ls 
alarm  info  state
root@efflam:/proc/acpi/battery/BAT1 # cat *
alarm:                   68 mAh
present:                 yes
design capacity:         3600 mAh
last full capacity:      3400 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 68 mAh
design capacity low:     0 mAh
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            XM2030P02   
serial number:           1000010554
battery type:            Li-ION  
OEM info:                
present:                 yes
ERROR: Unable to read battery status

If I extract my battery all error messages stop.
I don't have a oops in this session.

When I boot all ACPI messages are :
[...]
Mar  3 16:28:38 efflam ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f01b0
Mar  3 16:28:38 efflam ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ff60000
Mar  3 16:28:38 efflam ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0ff60054
Mar  3 16:28:38 efflam ACPI: DSDT (v001 TOSHIB 8200     0x20001220 MSFT 0x0100000a) @ 0x00000000
Mar  3 16:28:38 efflam Built 1 zonelists
Mar  3 16:28:38 efflam Kernel command line: auto BOOT_IMAGE=Linux263 ro root=305 pmdisk=/dev/hda1 resume=/dev/hda1 pci=noacpi
Mar  3 16:28:38 efflam ACPI: Subsystem revision 20040116
Mar  3 16:28:38 efflam ACPI: IRQ9 SCI: Level Trigger.
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node cff5e820), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.LNKB._STA] (Node cff5e920), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.LNKC._STA] (Node cff4d5e0), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.LNKD._STA] (Node cff4d4e0), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.LNKE._STA] (Node cff4d3e0), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.LNKH._STA] (Node cff4d2e0), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node c12d6b20), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.COM_._STA] (Node c12d69e0), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FSIR._STA] (Node c12d5860), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node c12d5720), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node c12d5640), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node c12d5540), AE_NOT_EXIST
Mar  3 16:28:38 efflam ACPI: Interpreter enabled
Mar  3 16:28:38 efflam ACPI: Using PIC for interrupt routing
Mar  3 16:28:38 efflam ACPI: PCI Root Bridge [PCI0] (00:00)
Mar  3 16:28:38 efflam PCI: Probing PCI hardware (bus 00)
Mar  3 16:28:38 efflam Transparent bridge - 0000:00:1e.0
Mar  3 16:28:38 efflam ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar  3 16:28:38 efflam ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
Mar  3 16:28:38 efflam ACPI: Power Resource [PIHD] (on)
Mar  3 16:28:38 efflam ACPI: Power Resource [PMHD] (on)
Mar  3 16:28:38 efflam ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Mar  3 16:28:38 efflam ACPI: Power Resource [PFAN] (off)
[...]
Mar  3 16:28:38 efflam ACPI: AC Adapter [ADP1] (on-line)
Mar  3 16:28:38 efflam ACPI: Battery Slot [BAT1] (battery present)
Mar  3 16:28:38 efflam ACPI: Battery Slot [BAT2] (battery absent)
Mar  3 16:28:38 efflam ACPI: Power Button (FF) [PWRF]
Mar  3 16:28:38 efflam ACPI: Lid Switch [LID]
Mar  3 16:28:38 efflam ACPI: Fan [FAN] (off)
Mar  3 16:28:38 efflam ACPI: Processor [CPU0] (supports C1 C2)
Mar  3 16:28:38 efflam ACPI: Thermal Zone [THRM] (66 C)
Mar  3 16:28:38 efflam toshiba_acpi: Toshiba Laptop ACPI Extras version 0.17
Mar  3 16:28:38 efflam toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
[...]
Mar  3 16:28:38 efflam Resume Machine: resuming from /dev/hda1
Mar  3 16:28:38 efflam Resuming from device hda1
Mar  3 16:28:38 efflam Resume Machine: This is normal swap space
Mar  3 16:28:38 efflam PM: Reading pmdisk image.
Mar  3 16:28:38 efflam PM: Resume from disk failed.
Mar  3 16:28:38 efflam ACPI: (supports S0 S1 S3 S4 S4bios S5)
[...]


Did somebody know how I can stop this error (exept reboot :) ?

If you need any other informations, ask me.

--
Jerome POGGI                                     Jerome.Poggi@hsc.fr
Herve Schauer Consultants       -=-      Network security consultant
http://www.hsc.fr/                             Tel : +33 141 409 700
