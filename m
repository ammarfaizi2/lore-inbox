Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRDXBI0>; Mon, 23 Apr 2001 21:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132658AbRDXBIQ>; Mon, 23 Apr 2001 21:08:16 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:7593 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S132655AbRDXBID>; Mon, 23 Apr 2001 21:08:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: linux-kernel@vger.kernel.org
Subject: Device Registry (DevReg) Patch 0.2.0
Date: Tue, 24 Apr 2001 03:08:20 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-hotplug-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <01042403082000.05529@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Device Registry (devreg) is a kernel patch that adds a device 
database in XML format to the /proc filesystem. It collects all information 
about the system's physical devices, creates persistent device ids and 
provides them in the file /proc/devreg.

Devreg has three purposes:
- collect all configuration data from drivers so the user can browse his 
hardware configuration. 
-allow an application to display all devices that provide a certain interface 
(for example all mice) so the user can chose one. 
-allow an application to find the device that the user has selected after a 
reboot or a hotplug action: the device files in /dev do not offer stable 
names, they depend on the order in that the devices have been plugged in or 
powered on. 

Changes since last release (0.1.1):
- converted file format to XML
- bus-specific information from pci and usb added
- fixed locking

The patch (for 2.4.3) can be found at 
http://www.tjansen.de/devreg/devreg-2.4.3-0.2.0.diff.gz
To test it, apply the patch, select CONFIG_DEVFS_FS and CONFIG_DEVREG and 
compile. Note that the patch will break binary drivers.

Supported hardware in version 0.2.0: PCI subsystem, USB subsystem, most PCI 
sound cards, USB HID devices, USB hubs, USB printers

Other information and a user-space library can be found at 
http://www.tjansen.de/devreg
