Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUGUP74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUGUP74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbUGUP74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:59:56 -0400
Received: from smtp.rol.ru ([194.67.21.9]:33482 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S266526AbUGUP7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:59:52 -0400
Message-ID: <40FE9390.9060609@vlnb.net>
Date: Wed, 21 Jul 2004 20:02:24 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [ANNOUNCE] [RFC] Generic SCSI Target Middle Level for Linux (SCST)
 version 0.9.2 released
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to announce that Generic SCSI Target Middle Level for Linux
(SCST) version 0.9.2 released.

SCST is a new subsystem of the Linux kernel that provides a standard
framework for SCSI target drivers development. SCST is designed to
provide unified, consistent interface between SCSI target drivers and
Linux kernel and simplify target drivers development as much as
possible. A system with a SCSI target device is able to share its local
or virtual devices with other systems on the network with SCSI protocol
support, e.g. SCSI bus, Fibre Channel, TCP/IP with iSCSI. A system with
a SCSI target device is able to share its local or virtual devices with
other systems on a network with SCSI protocol support, e.g. SCSI bus,
Fibre Channel, TCP/IP with iSCSI. This is commonly used for data storage
virtualization. Full list of SCST's features, the source code and
detailed documentation could be found on its Internet page
http://scst.sourceforge.net.

The major changes from version 0.9.1 are

- 2.6 kernels support

- FILEIO/BLKDEV device handler that works over files on file system and
makes from them virtual remotely available SCSI disks. In addition, it
allows to work directly over a block device, e.g. local IDE or SCSI disk
or ever disk partition, where there is no file systems overhead. Using
block devices comparing to sending SCSI commands directly to SCSI
mid-level via scsi_do_req() has advantage that data are get or put via
system cache, so it can fully benefit from caching and read ahead,
performed by Linux's VM subsystem.

The Qlogic target driver is coming soon.

The next coming features are complete BLKDEV device handler, which will 
not copy data from the page cache, but instead use the pages directly, 
and device access control.

Comments, suggestions, patches, drivers and testers are welcome. 
Especially interesting comments (reviews) from inclusion in the mainline
kernel point of view.

Vlad

