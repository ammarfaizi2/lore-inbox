Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTKNPUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 10:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTKNPUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 10:20:52 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:45728 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262725AbTKNPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 10:20:50 -0500
Date: Fri, 14 Nov 2003 07:20:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1540] New: Error removing USB Flash hard drive
Message-ID: <5100000.1068823242@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1540

           Summary: Error removing USB Flash hard drive
    Kernel Version: 2.6.0-test9-mm2
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: bunnadik@musikhuset.org


Distribution:Mandrake 9.2-rc1
Hardware Environment:Dell Optiplex G1
Software Environment:
Problem Description:When removing the flash drive (after umount) I get a:
Badness in atomic_dec_and_test at include/asm/atomic.h:150
Call Trace:
 [<c0243b21>] kobject_put+0x71/0x80
 [<c88d9f9f>] scsi_remove_host+0x5f/0x80 [scsi_mod]
 [<c88cf978>] storage_disconnect+0x38/0x48 [usb_storage]
 [<c02c8ad8>] usb_unbind_interface+0x78/0x80
 [<c0285236>] device_release_driver+0x66/0x70
 [<c0285375>] bus_remove_device+0x55/0xa0
 [<c028423d>] device_del+0x5d/0xa0
 [<c02cf320>] usb_disable_device+0x70/0xb0
 [<c02c9656>] usb_disconnect+0x96/0xf0
 [<c02cbeff>] hub_port_connect_change+0x32f/0x340
 [<c02cb7da>] hub_port_status+0x3a/0xb0
 [<c02cc246>] hub_events+0x336/0x3a0
 [<c02cc2e5>] hub_thread+0x35/0xf0
 [<c0344b72>] ret_from_fork+0x6/0x14
 [<c011b2b0>] default_wake_function+0x0/0x30
 [<c02cc2b0>] hub_thread+0x0/0xf0
 [<c0109299>] kernel_thread_helper+0x5/0xc

Steps to reproduce:
Mount flash drive, add some files, umount, remove from computer

Note:Happens _probably_ under Linus' tree as well. Don't have time to check
right now.


