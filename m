Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290118AbSBRSip>; Mon, 18 Feb 2002 13:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290597AbSBRSaW>; Mon, 18 Feb 2002 13:30:22 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:52489 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289995AbSBRS0q>;
	Mon, 18 Feb 2002 13:26:46 -0500
Date: Mon, 18 Feb 2002 19:16:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Whitespace PCI cleanups
Message-ID: <20020218181623.GA122@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are some cleanups of whitespace in pci. Martin (pci maintainer)
approved pci.c/pci.h parts and I guess I have his okay for pci.txt
part too. (This is small stuff, so I do not want to bother Linus with
that...)

								Pavel

--- linux/Documentation/power/pci.txt	Thu Oct 25 13:26:15 2001
+++ linux-dm/Documentation/power/pci.txt	Wed Feb 13 23:15:20 2002
@@ -63,7 +63,7 @@
 callbacks. This currently takes place only during APM state transitions.
 
 Upon going to sleep, the PCI subsystem walks its device tree twice. Both times, it does
-a depth first walk of the device tree. The first walk saves  each of the device's state 
+a depth first walk of the device tree. The first walk saves each of the device's state 
 and checks for devices that will prevent the system from entering a global power state. 
 The next walk then places the devices in a low power state.
 
@@ -104,7 +104,7 @@
 -----------------
 
 Usage:
-	pci_restore_state(dev,buffer);
+	pci_restore_state(dev, buffer);
 
 Description:
 	Restore previously saved config space. (First 64 bytes only);
@@ -117,7 +117,7 @@
 -------------------
 
 Usage:
-	pci_set_power_state(dev,state);
+	pci_set_power_state(dev, state);
 
 Description:
 	Transition device to low power state using PCI PM Capabilities registers.
@@ -132,7 +132,7 @@
 ---------------
 
 Usage:
-	pci_enable_wake(dev,state,enable);
+	pci_enable_wake(dev, state, enable);
 
 Description:
 	Enable device to generate PME# during low power state using PCI PM 
@@ -155,7 +155,7 @@
 struct pci_driver:
 
         int  (*save_state) (struct pci_dev *dev, u32 state);
-        int  (*suspend)(struct pci_dev *dev, u32 state);
+        int  (*suspend) (struct pci_dev *dev, u32 state);
         int  (*resume) (struct pci_dev *dev);
         int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);
 
@@ -178,7 +178,7 @@
 
 The driver can also interpret this function as a notification that it may be entering
 a sleep state in the near future. If it knows that the device cannot enter the 
-requested state, either because of lack of support for it, or because the devices is 
+requested state, either because of lack of support for it, or because the device is 
 middle of some critical operation, then it should fail.
 
 This function should not be used to set any state in the device or the driver because
--- linux/drivers/pci/pci.c	Mon Feb 11 20:51:50 2002
+++ linux-dm/drivers/pci/pci.c	Wed Feb 13 23:26:07 2002
@@ -966,7 +966,7 @@
 	}
 }
 
-void __devinit  pci_read_bridge_bases(struct pci_bus *child)
+void __devinit pci_read_bridge_bases(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	u8 io_base_lo, io_limit_lo;
@@ -1057,7 +1057,7 @@
 	}
 }
 
-static struct pci_bus * __devinit  pci_alloc_bus(void)
+static struct pci_bus * __devinit pci_alloc_bus(void)
 {
 	struct pci_bus *b;
 
@@ -1392,7 +1396,7 @@
 	return max;
 }
 
-int __devinit  pci_bus_exists(const struct list_head *list, int nr)
+int __devinit pci_bus_exists(const struct list_head *list, int nr)
 {
 	const struct list_head *l;
 
@@ -1404,7 +1408,7 @@
 	return 0;
 }
 
-struct pci_bus * __devinit  pci_alloc_primary_bus(int bus)
+struct pci_bus * __devinit pci_alloc_primary_bus(int bus)
 {
 	struct pci_bus *b;
 
@@ -1431,7 +1435,7 @@
 	return b;
 }
 
-struct pci_bus * __devinit  pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
+struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
 {
 	struct pci_bus *b = pci_alloc_primary_bus(bus);
 	if (b) {
@@ -1965,7 +1969,7 @@
 	return 0;
 }
 
-static int __devinit  pci_setup(char *str)
+static int __devinit pci_setup(char *str)
 {
 	while (str) {
 		char *k = strchr(str, ',');
--- linux/include/linux/pci.h	Mon Feb 11 21:10:52 2002
+++ linux-dm/include/linux/pci.h	Thu Feb 14 22:46:59 2002
@@ -483,7 +483,7 @@
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
-	int  (*suspend)(struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 };

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
