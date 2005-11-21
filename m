Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVKUXEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVKUXEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVKUXEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:04:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:42402 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751243AbVKUXEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:04:00 -0500
Date: Mon, 21 Nov 2005 14:53:03 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Small PCI core patch
Message-ID: <20051121225303.GA19212@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any objections to this?

thanks,

greg k-h

---------------------

Subject: PCI: fix up the exported symbols to be the proper license.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

---
 drivers/pci/access.c     |   12 +++++-----
 drivers/pci/bus.c        |    6 ++---
 drivers/pci/msi.c        |    8 +++---
 drivers/pci/pci-acpi.c   |    4 +--
 drivers/pci/pci-driver.c |   16 ++++++-------
 drivers/pci/pci.c        |   54 +++++++++++++++++++++++------------------------
 drivers/pci/probe.c      |   14 ++++++------
 drivers/pci/proc.c       |    6 ++---
 drivers/pci/quirks.c     |    4 +--
 drivers/pci/remove.c     |    8 +++---
 drivers/pci/rom.c        |    8 +++---
 drivers/pci/search.c     |   20 ++++++++---------
 drivers/pci/setup-bus.c  |    6 ++---
 13 files changed, 83 insertions(+), 83 deletions(-)

--- gregkh-2.6.orig/drivers/pci/access.c
+++ gregkh-2.6/drivers/pci/access.c
@@ -56,12 +56,12 @@ PCI_OP_WRITE(byte, u8, 1)
 PCI_OP_WRITE(word, u16, 2)
 PCI_OP_WRITE(dword, u32, 4)
 
-EXPORT_SYMBOL(pci_bus_read_config_byte);
-EXPORT_SYMBOL(pci_bus_read_config_word);
-EXPORT_SYMBOL(pci_bus_read_config_dword);
-EXPORT_SYMBOL(pci_bus_write_config_byte);
-EXPORT_SYMBOL(pci_bus_write_config_word);
-EXPORT_SYMBOL(pci_bus_write_config_dword);
+EXPORT_SYMBOL_GPL(pci_bus_read_config_byte);
+EXPORT_SYMBOL_GPL(pci_bus_read_config_word);
+EXPORT_SYMBOL_GPL(pci_bus_read_config_dword);
+EXPORT_SYMBOL_GPL(pci_bus_write_config_byte);
+EXPORT_SYMBOL_GPL(pci_bus_write_config_word);
+EXPORT_SYMBOL_GPL(pci_bus_write_config_dword);
 
 static u32 pci_user_cached_config(struct pci_dev *dev, int pos)
 {
--- gregkh-2.6.orig/drivers/pci/bus.c
+++ gregkh-2.6/drivers/pci/bus.c
@@ -199,7 +199,7 @@ void pci_walk_bus(struct pci_bus *top, v
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
-EXPORT_SYMBOL(pci_bus_alloc_resource);
+EXPORT_SYMBOL_GPL(pci_bus_alloc_resource);
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
-EXPORT_SYMBOL(pci_bus_add_devices);
-EXPORT_SYMBOL(pci_enable_bridges);
+EXPORT_SYMBOL_GPL(pci_bus_add_devices);
+EXPORT_SYMBOL_GPL(pci_enable_bridges);
--- gregkh-2.6.orig/drivers/pci/msi.c
+++ gregkh-2.6/drivers/pci/msi.c
@@ -1119,7 +1119,7 @@ void msi_remove_pci_irq_vectors(struct p
 	}
 }
 
-EXPORT_SYMBOL(pci_enable_msi);
-EXPORT_SYMBOL(pci_disable_msi);
-EXPORT_SYMBOL(pci_enable_msix);
-EXPORT_SYMBOL(pci_disable_msix);
+EXPORT_SYMBOL_GPL(pci_enable_msi);
+EXPORT_SYMBOL_GPL(pci_disable_msi);
+EXPORT_SYMBOL_GPL(pci_enable_msix);
+EXPORT_SYMBOL_GPL(pci_disable_msix);
--- gregkh-2.6.orig/drivers/pci/pci-acpi.c
+++ gregkh-2.6/drivers/pci/pci-acpi.c
@@ -174,7 +174,7 @@ acpi_status pci_osc_support_set(u32 flag
 	ctrlset_buf[OSC_CONTROL_TYPE] = temp;
 	return AE_OK;
 }
-EXPORT_SYMBOL(pci_osc_support_set);
+EXPORT_SYMBOL_GPL(pci_osc_support_set);
 
 /**
  * pci_osc_control_set - commit requested control to Firmware
@@ -203,7 +203,7 @@ acpi_status pci_osc_control_set(acpi_han
 	
 	return status;
 }
-EXPORT_SYMBOL(pci_osc_control_set);
+EXPORT_SYMBOL_GPL(pci_osc_control_set);
 
 /*
  * _SxD returns the D-state with the highest power
--- gregkh-2.6.orig/drivers/pci/pci-driver.c
+++ gregkh-2.6/drivers/pci/pci-driver.c
@@ -525,11 +525,11 @@ static int __init pci_driver_init(void)
 
 postcore_initcall(pci_driver_init);
 
-EXPORT_SYMBOL(pci_match_id);
-EXPORT_SYMBOL(pci_match_device);
-EXPORT_SYMBOL(__pci_register_driver);
-EXPORT_SYMBOL(pci_unregister_driver);
-EXPORT_SYMBOL(pci_dev_driver);
-EXPORT_SYMBOL(pci_bus_type);
-EXPORT_SYMBOL(pci_dev_get);
-EXPORT_SYMBOL(pci_dev_put);
+EXPORT_SYMBOL_GPL(pci_match_id);
+EXPORT_SYMBOL_GPL(pci_match_device);
+EXPORT_SYMBOL_GPL(__pci_register_driver);
+EXPORT_SYMBOL_GPL(pci_unregister_driver);
+EXPORT_SYMBOL_GPL(pci_dev_driver);
+EXPORT_SYMBOL_GPL(pci_bus_type);
+EXPORT_SYMBOL_GPL(pci_dev_get);
+EXPORT_SYMBOL_GPL(pci_dev_put);
--- gregkh-2.6.orig/drivers/pci/pci.c
+++ gregkh-2.6/drivers/pci/pci.c
@@ -425,7 +425,7 @@ pci_power_t pci_choose_state(struct pci_
 	return PCI_D0;
 }
 
-EXPORT_SYMBOL(pci_choose_state);
+EXPORT_SYMBOL_GPL(pci_choose_state);
 
 /**
  * pci_save_state - save the PCI configuration space of a device before suspending
@@ -910,36 +910,36 @@ __setup("pci=", pci_setup);
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 /* FIXME: Some boxes have multiple ISA bridges! */
 struct pci_dev *isa_bridge;
-EXPORT_SYMBOL(isa_bridge);
+EXPORT_SYMBOL_GPL(isa_bridge);
 #endif
 
 EXPORT_SYMBOL_GPL(pci_restore_bars);
-EXPORT_SYMBOL(pci_enable_device_bars);
-EXPORT_SYMBOL(pci_enable_device);
-EXPORT_SYMBOL(pci_disable_device);
-EXPORT_SYMBOL(pci_max_busnr);
-EXPORT_SYMBOL(pci_bus_max_busnr);
-EXPORT_SYMBOL(pci_find_capability);
-EXPORT_SYMBOL(pci_bus_find_capability);
-EXPORT_SYMBOL(pci_release_regions);
-EXPORT_SYMBOL(pci_request_regions);
-EXPORT_SYMBOL(pci_release_region);
-EXPORT_SYMBOL(pci_request_region);
-EXPORT_SYMBOL(pci_set_master);
-EXPORT_SYMBOL(pci_set_mwi);
-EXPORT_SYMBOL(pci_clear_mwi);
+EXPORT_SYMBOL_GPL(pci_enable_device_bars);
+EXPORT_SYMBOL_GPL(pci_enable_device);
+EXPORT_SYMBOL_GPL(pci_disable_device);
+EXPORT_SYMBOL_GPL(pci_max_busnr);
+EXPORT_SYMBOL_GPL(pci_bus_max_busnr);
+EXPORT_SYMBOL_GPL(pci_find_capability);
+EXPORT_SYMBOL_GPL(pci_bus_find_capability);
+EXPORT_SYMBOL_GPL(pci_release_regions);
+EXPORT_SYMBOL_GPL(pci_request_regions);
+EXPORT_SYMBOL_GPL(pci_release_region);
+EXPORT_SYMBOL_GPL(pci_request_region);
+EXPORT_SYMBOL_GPL(pci_set_master);
+EXPORT_SYMBOL_GPL(pci_set_mwi);
+EXPORT_SYMBOL_GPL(pci_clear_mwi);
 EXPORT_SYMBOL_GPL(pci_intx);
-EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_set_consistent_dma_mask);
-EXPORT_SYMBOL(pci_assign_resource);
-EXPORT_SYMBOL(pci_find_parent_resource);
-
-EXPORT_SYMBOL(pci_set_power_state);
-EXPORT_SYMBOL(pci_save_state);
-EXPORT_SYMBOL(pci_restore_state);
-EXPORT_SYMBOL(pci_enable_wake);
+EXPORT_SYMBOL_GPL(pci_set_dma_mask);
+EXPORT_SYMBOL_GPL(pci_set_consistent_dma_mask);
+EXPORT_SYMBOL_GPL(pci_assign_resource);
+EXPORT_SYMBOL_GPL(pci_find_parent_resource);
+
+EXPORT_SYMBOL_GPL(pci_set_power_state);
+EXPORT_SYMBOL_GPL(pci_save_state);
+EXPORT_SYMBOL_GPL(pci_restore_state);
+EXPORT_SYMBOL_GPL(pci_enable_wake);
 
 /* Quirk info */
 
-EXPORT_SYMBOL(isa_dma_bridge_buggy);
-EXPORT_SYMBOL(pci_pci_problems);
+EXPORT_SYMBOL_GPL(isa_dma_bridge_buggy);
+EXPORT_SYMBOL_GPL(pci_pci_problems);
--- gregkh-2.6.orig/drivers/pci/probe.c
+++ gregkh-2.6/drivers/pci/probe.c
@@ -18,7 +18,7 @@
 
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
-EXPORT_SYMBOL(pci_root_buses);
+EXPORT_SYMBOL_GPL(pci_root_buses);
 
 LIST_HEAD(pci_devices);
 
@@ -994,13 +994,13 @@ struct pci_bus * __devinit pci_scan_bus_
 		b->subordinate = pci_scan_child_bus(b);
 	return b;
 }
-EXPORT_SYMBOL(pci_scan_bus_parented);
+EXPORT_SYMBOL_GPL(pci_scan_bus_parented);
 
 #ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pci_add_new_bus);
-EXPORT_SYMBOL(pci_do_scan_bus);
-EXPORT_SYMBOL(pci_scan_slot);
-EXPORT_SYMBOL(pci_scan_bridge);
-EXPORT_SYMBOL(pci_scan_single_device);
+EXPORT_SYMBOL_GPL(pci_add_new_bus);
+EXPORT_SYMBOL_GPL(pci_do_scan_bus);
+EXPORT_SYMBOL_GPL(pci_scan_slot);
+EXPORT_SYMBOL_GPL(pci_scan_bridge);
+EXPORT_SYMBOL_GPL(pci_scan_single_device);
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 #endif
--- gregkh-2.6.orig/drivers/pci/proc.c
+++ gregkh-2.6/drivers/pci/proc.c
@@ -611,8 +611,8 @@ static int __init pci_proc_init(void)
 __initcall(pci_proc_init);
 
 #ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pci_proc_attach_device);
-EXPORT_SYMBOL(pci_proc_attach_bus);
-EXPORT_SYMBOL(pci_proc_detach_bus);
+EXPORT_SYMBOL_GPL(pci_proc_attach_device);
+EXPORT_SYMBOL_GPL(pci_proc_attach_bus);
+EXPORT_SYMBOL_GPL(pci_proc_detach_bus);
 #endif
 
--- gregkh-2.6.orig/drivers/pci/quirks.c
+++ gregkh-2.6/drivers/pci/quirks.c
@@ -1312,7 +1312,7 @@ void pci_fixup_device(enum pci_fixup_pas
 	pci_do_fixups(dev, start, end);
 }
 
-EXPORT_SYMBOL(pcie_mch_quirk);
+EXPORT_SYMBOL_GPL(pcie_mch_quirk);
 #ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pci_fixup_device);
+EXPORT_SYMBOL_GPL(pci_fixup_device);
 #endif
--- gregkh-2.6.orig/drivers/pci/remove.c
+++ gregkh-2.6/drivers/pci/remove.c
@@ -55,7 +55,7 @@ int pci_remove_device_safe(struct pci_de
 	pci_destroy_dev(dev);
 	return 0;
 }
-EXPORT_SYMBOL(pci_remove_device_safe);
+EXPORT_SYMBOL_GPL(pci_remove_device_safe);
 
 void pci_remove_bus(struct pci_bus *pci_bus)
 {
@@ -70,7 +70,7 @@ void pci_remove_bus(struct pci_bus *pci_
 	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
 	class_device_unregister(&pci_bus->class_dev);
 }
-EXPORT_SYMBOL(pci_remove_bus);
+EXPORT_SYMBOL_GPL(pci_remove_bus);
 
 /**
  * pci_remove_bus_device - remove a PCI device and any children
@@ -118,5 +118,5 @@ void pci_remove_behind_bridge(struct pci
 	}
 }
 
-EXPORT_SYMBOL(pci_remove_bus_device);
-EXPORT_SYMBOL(pci_remove_behind_bridge);
+EXPORT_SYMBOL_GPL(pci_remove_bus_device);
+EXPORT_SYMBOL_GPL(pci_remove_behind_bridge);
--- gregkh-2.6.orig/drivers/pci/rom.c
+++ gregkh-2.6/drivers/pci/rom.c
@@ -234,7 +234,7 @@ void pci_cleanup_rom(struct pci_dev *pde
 	}
 }
 
-EXPORT_SYMBOL(pci_map_rom);
-EXPORT_SYMBOL(pci_map_rom_copy);
-EXPORT_SYMBOL(pci_unmap_rom);
-EXPORT_SYMBOL(pci_remove_rom);
+EXPORT_SYMBOL_GPL(pci_map_rom);
+EXPORT_SYMBOL_GPL(pci_map_rom_copy);
+EXPORT_SYMBOL_GPL(pci_unmap_rom);
+EXPORT_SYMBOL_GPL(pci_remove_rom);
--- gregkh-2.6.orig/drivers/pci/search.c
+++ gregkh-2.6/drivers/pci/search.c
@@ -376,14 +376,14 @@ exit:				
 	spin_unlock(&pci_bus_lock);
 	return found;
 }
-EXPORT_SYMBOL(pci_dev_present);
+EXPORT_SYMBOL_GPL(pci_dev_present);
 
-EXPORT_SYMBOL(pci_find_bus);
-EXPORT_SYMBOL(pci_find_next_bus);
-EXPORT_SYMBOL(pci_find_device);
-EXPORT_SYMBOL(pci_find_device_reverse);
-EXPORT_SYMBOL(pci_find_slot);
-EXPORT_SYMBOL(pci_get_device);
-EXPORT_SYMBOL(pci_get_subsys);
-EXPORT_SYMBOL(pci_get_slot);
-EXPORT_SYMBOL(pci_get_class);
+EXPORT_SYMBOL_GPL(pci_find_bus);
+EXPORT_SYMBOL_GPL(pci_find_next_bus);
+EXPORT_SYMBOL_GPL(pci_find_device);
+EXPORT_SYMBOL_GPL(pci_find_device_reverse);
+EXPORT_SYMBOL_GPL(pci_find_slot);
+EXPORT_SYMBOL_GPL(pci_get_device);
+EXPORT_SYMBOL_GPL(pci_get_subsys);
+EXPORT_SYMBOL_GPL(pci_get_slot);
+EXPORT_SYMBOL_GPL(pci_get_class);
--- gregkh-2.6.orig/drivers/pci/setup-bus.c
+++ gregkh-2.6/drivers/pci/setup-bus.c
@@ -129,7 +129,7 @@ void pci_setup_cardbus(struct pci_bus *b
 					region.end);
 	}
 }
-EXPORT_SYMBOL(pci_setup_cardbus);
+EXPORT_SYMBOL_GPL(pci_setup_cardbus);
 
 /* Initialize bridges with base/limit values we have collected.
    PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
@@ -493,7 +493,7 @@ pci_bus_size_bridges(struct pci_bus *bus
 		break;
 	}
 }
-EXPORT_SYMBOL(pci_bus_size_bridges);
+EXPORT_SYMBOL_GPL(pci_bus_size_bridges);
 
 void __devinit
 pci_bus_assign_resources(struct pci_bus *bus)
@@ -526,7 +526,7 @@ pci_bus_assign_resources(struct pci_bus 
 		}
 	}
 }
-EXPORT_SYMBOL(pci_bus_assign_resources);
+EXPORT_SYMBOL_GPL(pci_bus_assign_resources);
 
 void __init
 pci_assign_unassigned_resources(void)
