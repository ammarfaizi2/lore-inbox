Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270929AbTGPPyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270930AbTGPPyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:54:14 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:18512 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S270929AbTGPPyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:54:06 -0400
Date: Wed, 16 Jul 2003 18:08:55 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: linux-kernel@vger.kernel.org
Cc: Linux IEEE 1394 Devel Mailing List 
	<linux1394-devel@lists.sourceforge.net>
Subject: 2.6.0-test1-mm1: bad: scheduling while atomic! after removing
 ohci1394 module
Message-Id: <20030716180855.22d4a4f4.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws141 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

With 2.6.0-test1-mm1, i have the following in my logs after i rmmod'ed the
ohci1394 module:

bad: scheduling while atomic!
Call Trace:
 [<c011c958>] schedule+0x578/0x580
 [<c0108ff2>] copy_thread+0x32/0x250
 [<c011cd0c>] wait_for_completion+0x8c/0xf0
 [<c011c9b0>] default_wake_function+0x0/0x30
 [<c011c9b0>] default_wake_function+0x0/0x30
 [<c012b9e1>] kill_proc_info+0x51/0x80
 [<e0b87665>] nodemgr_remove_host+0x55/0xa0 [ieee1394]
 [<e0b82fba>] highlevel_remove_host+0x8a/0xa0 [ieee1394]
 [<e0b4163d>] ohci1394_pci_remove+0x3d/0x160 [ohci1394]
 [<c018c93e>] sysfs_hash_and_remove+0x4e/0x7c
 [<c022c75b>] pci_device_remove+0x3b/0x40
 [<c0256916>] device_release_driver+0x66/0x70
 [<c025694b>] driver_detach+0x2b/0x40
 [<c0256bae>] bus_remove_driver+0x3e/0x80
 [<c0256fc3>] driver_unregister+0x13/0x2a
 [<c022ca56>] pci_unregister_driver+0x16/0x30
 [<e0b41adf>] ohci1394_cleanup+0xf/0x11 [ohci1394]
 [<c0137d89>] sys_delete_module+0x139/0x170
 [<c014c1e5>] sys_munmap+0x45/0x70
 [<c010b0ab>] syscall_call+0x7/0xb


Should i worry ?

Besides that, IEE1394 works fine with my DV camcorder.

Thanks,

Philippe
