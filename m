Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbTFQSZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTFQSZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:25:36 -0400
Received: from ns.suse.de ([213.95.15.193]:33284 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264695AbTFQSZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:25:35 -0400
Date: Tue, 17 Jun 2003 20:39:29 +0200
From: Olaf Hering <olh@suse.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617183929.GA15886@suse.de>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme> <20030617162546.GS30843@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20030617162546.GS30843@parcelfarce.linux.theplanet.co.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jun 17, Matthew Wilcox wrote:

> ./drivers/net/3c59x.c:                  strcpy(info.bus_info, VORTEX_PCI(vp)->slot_name);

that one is for ethtool ioctl.
Is 'ethtool -i' obsolete in 2.6?
It seems sysfs has every info already.

olaf@smirnow:~/linux-2.5.72> l /sys/class/net/eth0/
total 0
drwxr-xr-x    3 root     root            0 Jun 17 13:14 ./
drwxr-xr-x    4 root     root            0 Jun 17 13:14 ../
-r--r--r--    1 root     root         4096 Jun 17 13:14 addr_len
-r--r--r--    1 root     root         4096 Jun 17 13:14 address
-r--r--r--    1 root     root         4096 Jun 17 13:14 broadcast
lrwxrwxrwx    1 root     root           34 Jun 17 13:14 device -> ../../../devices/pci0/0000:00:0a.0/
lrwxrwxrwx    1 root     root           30 Jun 17 13:14 driver -> ../../../bus/pci/drivers/3c59x/
-r--r--r--    1 root     root         4096 Jun 17 13:14 features
-rw-r--r--    1 root     root         4096 Jun 17 13:14 flags
-r--r--r--    1 root     root         4096 Jun 17 13:14 ifindex
-r--r--r--    1 root     root         4096 Jun 17 13:14 iflink
-rw-r--r--    1 root     root         4096 Jun 17 13:14 mtu
drwxr-xr-x    2 root     root            0 Jun 17 13:14 statistics/
-rw-r--r--    1 root     root         4096 Jun 17 13:14 tx_queue_len
-r--r--r--    1 root     root         4096 Jun 17 13:14 type

driver, businfo.
drivers/<foo> does not provide a version string.
Should there be an entry for that?

-- 
USB is for mice, FireWire is for men!
