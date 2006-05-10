Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWEJVXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWEJVXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWEJVXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:23:00 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:54966 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S964857AbWEJVW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:22:59 -0400
Message-ID: <446259A0.8050504@myri.com>
Date: Wed, 10 May 2006 23:22:40 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: [PATCH 0/6] myri10ge - Myri-10G Ethernet driver
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 0/6] myri10ge - Myri-10G Ethernet driver

The following 6 patches introduce the myri10ge driver for Myricom Myri-10G
boards in Ethernet mode. The driver is called myri10ge. The patches are
against 2.6.17-rc3-mm1.

[1/6]	Restore pci_find_ext_capability.
[2/6]	Add nVidia nForce CK804 PCI-E and ServerWorks HT2000 PCI-E IDs.
[3/6]	myri10ge driver header files.
[4-5/6]	Two halves of myri10ge driver core.
[6/6]	Add Kconfig and Makefile support for the myri10ge driver.

It also uses the following patches that have been sent on May 2
(http://lkml.org/lkml/2006/5/2/286 and 288) and merged into -mm.
add-__iowrite64_copy.patch
	Introduce __iowrite64_copy.
add-pci_cap_id_vndr.patch
	Add the vendor specific extended capability PCI_CAP_ID_VNDR.


The Myri-10G board operates as a regular PCI-Express Ethernet NIC.
If a firmware is available through hotplug, the driver will load it if its
version matches the driver requirements. If not, the driver will adopt the
running firmware that came in the board's eeprom if it is recent enough.

This driver supports in particular NAPI, power management, IPv4 and IPv6
checksum offload, 802.1q VLAN, and TCP Segmentation Offload.

Regards,
Brice Goglin


