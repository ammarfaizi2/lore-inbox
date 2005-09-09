Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVIITc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVIITc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVIITc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:32:26 -0400
Received: from magic.adaptec.com ([216.52.22.17]:55236 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030331AbVIITcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:32:24 -0400
Message-ID: <4321E342.4070509@adaptec.com>
Date: Fri, 09 Sep 2005 15:32:18 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 2/20] aic94xx: README
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:32:23.0682 (UTC) FILETIME=[33EBCE20:01C5B575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/aic94xx/README linux-2.6.13/drivers/scsi/aic94xx/README
--- linux-2.6.13-orig/drivers/scsi/aic94xx/README	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/aic94xx/README	2005-09-09 11:21:23.000000000 -0400
@@ -0,0 +1,82 @@
+$Id: //depot/aic94xx/readme.txt#5 $
+
+Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+
+LICENSE AGREEMENT
+-----------------
+
+This file is licensed under GPLv2.
+    
+This file is part of the aic94xx driver.
+
+The aic94xx driver is free software; you can redistribute it and/or
+modify it under the terms of the GNU General Public
+License as published by the Free Software Foundation;
+version 2 of the License.
+
+The aic94xx driver is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with Aic94xx Driver; if not, write to the Free Software
+Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+Introduction
+------------
+
+The aic94xx driver supports Adaptec SAS/SATA Host Adapters
+with AIC-94xx chips.  Features include 32/64 bit PCI/PCI-X
+interface supporting up to 66 MHz PCI 2.3 and up to 133 MHz
+PCI-X 2.0 operation.  It supports MSI or PCI interrupt pin.
+      * AIC-9405W is a  4 phy host adapter, 4 port maximum.
+      * AIC-9410W is an 8 phy host adapter, 8 port maximum.
+
+The driver supports Revision B0 or later of the controller.
+
+
+Hot plugging
+------------
+
+Hot plugging is supported, it works and has been tested.
+
+
+Dynamic PCI IDs
+---------------
+
+To make the driver probe and attach to a new device it
+doesn't quite recognize, you can dynamically add to the PCI
+ID table of the driver as follows:
+
+echo "vendor device" > /sys/bus/pci/drivers/aic94xx/new_id
+
+For the complete details see Documentation/pci.txt file.
+
+
+Not a HostRAID driver
+---------------------
+
+This driver is _not_ a HostRAID driver, it does _not_
+provide RAID capabilities.  Although RAID could be built on
+top of the devices exported by this driver.
+
+If you would like this driver to attach to a HostRAID
+enabled controller*, set the "attach_HostRAID" module
+parameter to "1" either at module load time or through sysfs.
+
+Kernel command line; append this:
+
+       aic94xx.attach_HostRAID=1
+
+Module loading, append this to your modprobe/insmod:
+
+       attach_HostRAID=1
+
+Or through sysfs, if the driver has already been loaded:
+
+echo "1" > /sys/module/aic94xx/parameters/attach_HostRAID
+
+* This of course could COMPLETELY destroy your HostRAID
+  array, and is NOT recommended.

