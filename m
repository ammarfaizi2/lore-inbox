Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUJKRDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUJKRDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUJKRDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:03:03 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:22214 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S269057AbUJKQuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:50:22 -0400
Message-ID: <416ABD90.3020508@gadsdon.giointernet.co.uk>
Date: Mon, 11 Oct 2004 18:06:24 +0100
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8a2) Gecko/20040604
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc4 boot - bad: scheduling while atomic!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From dmesg:

Linux version 2.6.9-rc4 (root@xxx.xxxx.com) (gcc version 3.4.2) #1 SMP 
Mon Oct 11 10:40:50 BST 2004
........
.
.
.
........
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[090050c50000046f]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
pnp: Device 00:0d disabled.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 2940 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

bad: scheduling while atomic!
  [<c03696fb>] schedule+0x58b/0x680
  [<c011b917>] __wake_up_common+0x37/0x70
  [<c0368f85>] __down+0x75/0xe0
  [<c011b8d0>] default_wake_function+0x0/0x10
  [<c0369114>] __down_failed+0x8/0xc
  [<d2946ab4>] .text.lock.aic7xxx_osm+0x19/0xa5 [aic7xxx]
  [<d2946a7d>] ahc_linux_exit+0x1d/0x3b [aic7xxx]
  [<c0134c0c>] sys_delete_module+0x16c/0x180
  [<c014b45a>] unmap_vma_list+0x1a/0x30
  [<c014b806>] do_munmap+0x126/0x1a0
  [<c0106099>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
  [<c03696fb>] schedule+0x58b/0x680
  [<c0115307>] smp_apic_timer_interrupt+0x107/0x110
  [<c0106ada>] apic_timer_interrupt+0x1a/0x20
  [<c03698c4>] wait_for_completion+0x94/0xe0
  [<c011b8d0>] default_wake_function+0x0/0x10
  [<c011b8d0>] default_wake_function+0x0/0x10
  [<c012e1c0>] call_usermodehelper+0xb0/0xc0
  [<c012e0c0>] __call_usermodehelper+0x0/0x50
  [<c023eabe>] kset_hotplug+0x1be/0x200
  [<c016da77>] dput+0x77/0x1c0
  [<c023ee6f>] kobject_del+0xf/0x20
  [<c029f7af>] class_device_del+0x8f/0xb0
  [<c029f7d8>] class_device_unregister+0x8/0x10
  [<c02d3a86>] scsi_remove_host+0x36/0x40
  [<d2941ee7>] ahc_platform_free+0xb7/0x120 [aic7xxx]
  [<d293550f>] ahc_free+0x9f/0x110 [aic7xxx]
  [<d294758d>] ahc_linux_pci_dev_remove+0x5d/0x80 [aic7xxx]
  [<c0249218>] pci_device_remove+0x28/0x30
  [<c029e566>] device_release_driver+0x56/0x60
  [<c029e588>] driver_detach+0x18/0x30
  [<c029ea45>] bus_remove_driver+0x45/0x80
  [<c029ef48>] driver_unregister+0x8/0x20
  [<c024945b>] pci_unregister_driver+0xb/0x20
  [<d2946a98>] ahc_linux_exit+0x38/0x3b [aic7xxx]
  [<c0134c0c>] sys_delete_module+0x16c/0x180
  [<c014b45a>] unmap_vma_list+0x1a/0x30
  [<c014b806>] do_munmap+0x126/0x1a0
  [<c0106099>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
  [<c03696fb>] schedule+0x58b/0x680
  [<c012e1c0>] call_usermodehelper+0xb0/0xc0
  [<c03698c4>] wait_for_completion+0x94/0xe0
  [<c011b8d0>] default_wake_function+0x0/0x10
  [<c011b988>] __wake_up+0x38/0x50
  [<c011b8d0>] default_wake_function+0x0/0x10
  [<c02d3c56>] scsi_host_dev_release+0x76/0x80
  [<c029d366>] device_release+0x56/0x60
  [<c023ef47>] kobject_cleanup+0x97/0xa0
  [<c023ef50>] kobject_release+0x0/0x10
  [<c023f2aa>] kref_put+0x3a/0x80
  [<c029d6d3>] device_del+0x63/0xa0
  [<d2941ef8>] ahc_platform_free+0xc8/0x120 [aic7xxx]
  [<d293550f>] ahc_free+0x9f/0x110 [aic7xxx]
  [<d294758d>] ahc_linux_pci_dev_remove+0x5d/0x80 [aic7xxx]
  [<c0249218>] pci_device_remove+0x28/0x30
  [<c029e566>] device_release_driver+0x56/0x60
  [<c029e588>] driver_detach+0x18/0x30
  [<c029ea45>] bus_remove_driver+0x45/0x80
  [<c029ef48>] driver_unregister+0x8/0x20
  [<c024945b>] pci_unregister_driver+0xb/0x20
  [<d2946a98>] ahc_linux_exit+0x38/0x3b [aic7xxx]
  [<c0134c0c>] sys_delete_module+0x16c/0x180
  [<c014b45a>] unmap_vma_list+0x1a/0x30
  [<c014b806>] do_munmap+0x126/0x1a0
  [<c0106099>] sysenter_past_esp+0x52/0x71
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
............etc

 From lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:12.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 IEEE-1394 
Controller
00:13.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 01)
00:14.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP 
(rev 04)



Robert Gadsdon.
