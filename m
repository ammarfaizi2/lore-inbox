Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTJCCbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 22:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTJCCbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 22:31:01 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:48768 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S263607AbTJCCa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 22:30:59 -0400
Date: Fri, 3 Oct 2003 04:30:53 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [2.6.0-test5-mm2] no /proc/bus/i2c but i2c-core module loaded +
 small oops
Message-Id: <20031003043053.367eb89c.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.9.5claws43 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

Symptoms: modprobe i2c-core works fine but /proc/bus/i2c doesn't exist

Kernel  : Stock 2.6.0-test5-mm2
Distro  : Debian Sid + 2.8 lm-sensors user space utilities
Hardware: Dell WS 530MT SMP Xeon 1.5 Ghz, Intel Motherboard Chipset: 82801BA , ADM1023
	  00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)

Also while rmmoding  i2c-dev module, i got the following message:


Device class 'i2c-0' does not have a release() function, it is broken and must be fixed.
Badness in class_dev_release at drivers/base/class.c:200

Call Trace:
 [<c0227ef5>] kobject_cleanup+0x75/0x80
 [<e0b42c3a>] i2cdev_detach_adapter+0x2a/0x40 [i2c_dev]
 [<e0b3b7e9>] i2c_del_driver+0x1d9/0x230 [i2c_core]
 [<e0b42c92>] i2c_dev_exit+0x12/0x37 [i2c_dev]
 [<c013ac33>] sys_delete_module+0x133/0x160
 [<c0152274>] sys_munmap+0x44/0x70
 [<c0386e13>] syscall_call+0x7/0xb


Thanks,

Philippe
