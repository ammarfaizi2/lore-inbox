Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbTCQOkv>; Mon, 17 Mar 2003 09:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbTCQOkv>; Mon, 17 Mar 2003 09:40:51 -0500
Received: from franka.aracnet.com ([216.99.193.44]:53149 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261705AbTCQOks>; Mon, 17 Mar 2003 09:40:48 -0500
Date: Mon, 17 Mar 2003 06:51:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 465] New: 2.5.64: devfs OOPS in delete_partition() w/ usb_storage: devfs_put() poisoned pointer
Message-ID: <21410000.1047912700@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=465

           Summary: 2.5.64: devfs OOPS in delete_partition() w/ usb_storage:
                    devfs_put() poisoned pointer
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: andi@lisas.de


Distribution: Debian unstable
Hardware Environment: Dell Inspiron 8000 w/ USB 2.0 2.5" HDD case on USB 1.1
Software Environment: gcc 3.2.3, devfsd 1.3.25-12
Problem Description:
OOPS at delete_partition() when using fdisk to delete all 10 partitions and then
add two partitions.

Steps to reproduce:
Connect an EagleTec USB 2.0 external 2.5" HDD case w/ an IBM DJSA-220 to a Dell
Inspiron 8000 USB 1.1 connector.
modprobe sd_mod manually.
Run fdisk /dev/hda, then delete all 10 partitions and add two partitions, one
FAT32 type c (10000MB), one Linux type 83 (8000MB).
Then "w"rite the partitions. BOOM.


