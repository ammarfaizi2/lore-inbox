Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVENX0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVENX0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 19:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVENX0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 19:26:11 -0400
Received: from smtp.freestart.hu ([213.197.64.6]:46085 "EHLO
	relay.freestart.hu") by vger.kernel.org with ESMTP id S261262AbVENXZ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 19:25:59 -0400
Message-ID: <002e01c558dc$485ed0f0$2f47c5d5@windows>
From: "Green Brain" <greenbrain@freemail.hu>
To: <linux-kernel@vger.kernel.org>
Subject: ICH5 MODEM in NASM - pci_dev
Date: Sun, 15 May 2005 01:09:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-freestart-banner: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to write a kernel module (driver) to the ICH5 SmartLink
SoftModem. The project is on my assembly.uw.hu website. If you can write PCI
driver please help me!

What is wrong with this offset array? (This is a NASM implementation of the
pci_dev structude from pci.h file.



;The pci_dev structure is used to describe both PCI and ISAPnP devices.

; NAME OFFSET SIZE

%assign pci_dev.global_list 0 ;8 node in list of all PCI devices

%assign pci_dev.bus_list 8 ;8 node in per-bus list

%assign pci_dev.bus 16 ;4 pci_bus bus this device is on

%assign pci_dev.subordinate 20 ;4 pci_bus bus this device bridges to

%assign pci_dev.sysdata 24 ;4 void hook for sys-specific extension

%assign pci_dev.procent 28 ;4 struct proc_dir_entry device entry in
/proc/bus/pci

%assign pci_dev.devfn 32 ;4 encoded device & function index

%assign pci_dev.vendor 36 ;2

%assign pci_dev.device 38 ;2

%assign pci_dev.subsystem_vendor 40 ;2

%assign pci_dev.subsystem_device 42 ;2

%assign pci_dev.class 44 ;4 3 bytes: (base,sub,prog-if)

%assign pci_dev.hdr_type 48 ;1 PCI header type (`multi' flag masked out)

%assign pci_dev.rom_base_reg 49 ;1 which config register controls the ROM

%assign pci_dev.driver 50 ;4 pci_driver which driver has allocated this
device

%assign pci_dev.driver_data 54 ;4 void data private to the driver

%assign pci_dev.dma_mask 58 ;4 Mask of the bits of bus aequress this

;HERE IS AN ERROR! DMA_MASK<>FFFFFFFF! FIX ME! ; device implements. Normally
this is

; 0xffffffff. You only need to change

; this if your device has broken DMA

; or supports 64-bit transfers.

%assign pci_dev.current_state 62 ;4 ;Current operating state. In ACPI-speak,

; this is D0-D3, D0 being fully functional,

; and D3 being off.

;device is compatible with these IDs

%assign pci_dev.vendor_compatible 66 ;8 [DEVICE_COUNT_COMPATIBLE]=4;

%assign pci_dev.device_compatible 74 ;8 [DEVICE_COUNT_COMPATIBLE]=4;

;Instead of touching interrupt line and base aequress registers

;directly, use the values stored here. They might be different!

%assign pci_dev.irq 82 ;4

;==========================

%assign pci_dev.resource 86 ;12 resource*12 [DEVICE_COUNT_RESOURCE]=12 I/O
and memory regions + expansion ROMs

%assign pci_dev.dma_resource 98 ;2 resource*2 [DEVICE_COUNT_DMA]=2

%assign pci_dev.irq_resource 100 ;2 resource*2 [DEVICE_COUNT_IRQ]=2

%assign pci_dev.name 102 ;80 [80] device name

%assign pci_dev.slot_name 182 ;8 [8] slot name

%assign pci_dev.active 190 ;4 ISAPnP: device is active

%assign pci_dev.ro 194 ;4 ISAPnP: read only

%assign pci_dev.regs 198 ;2 ISAPnP: supported registers

%assign pci_dev.prepare 200 ;4 (struct pci_dev *dev) ISAPnP hooks

%assign pci_dev.activate 204 ;4 (struct pci_dev *dev)

%assign pci_dev.deactivate 208 ;4 (struct pci_dev *dev)



Thanks in advance!




____________________________________________________________________
Miert fizetsz az internetert? Korlatlan, ingyenes internet hozzaferes a FreeStarttol.
Probald ki most! http://www.freestart.hu
