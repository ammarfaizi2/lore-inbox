Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTJJBgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTJJBgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:36:20 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:56014 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262755AbTJJBgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:36:14 -0400
Message-ID: <3F860CF2.8010105@sympatico.ca>
Date: Thu, 09 Oct 2003 21:35:46 -0400
From: Chris Friesen <chris_friesen@sympatico.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org, dgilbert@interlog.com
Subject: unloading scsi debug module gives errors in logs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seen on 2.6.0-test6:

Oct  9 21:22:25 doug kernel: SCSI device sda: 16384 512-byte hdwr 
sectors (8 MB)
Oct  9 21:22:25 doug kernel: SCSI device sda: drive cache: write back
Oct  9 21:22:25 doug kernel:  sda: unknown partition table
Oct  9 21:22:25 doug kernel: Attached scsi disk sda at scsi1, channel 0, 
id 0, lun 0
Oct  9 21:22:53 doug kernel: FAT: bogus number of reserved sectors
Oct  9 21:22:53 doug kernel: VFS: Can't find a valid FAT filesystem on 
dev sda.
Oct  9 21:24:42 doug kernel: Device 'pseudo_0' does not have a release() 
function, it is broken and must be fixed.
Oct  9 21:24:42 doug kernel: Badness in device_release at 
drivers/base/core.c:85
Oct  9 21:24:42 doug kernel: Call Trace:
Oct  9 21:24:42 doug kernel:  [device_release+68/80] 
device_release+0x44/0x50
Oct  9 21:24:42 doug kernel:  [kobject_cleanup+67/96] 
kobject_cleanup+0x43/0x60
Oct  9 21:24:42 doug kernel:  [kobject_put+20/32] kobject_put+0x14/0x20
Oct  9 21:24:42 doug kernel:  [put_device+13/32] put_device+0xd/0x20
Oct  9 21:24:42 doug kernel:  [device_unregister+17/32] 
device_unregister+0x11/0x20
Oct  9 21:24:42 doug kernel:  [__crc_generic_file_llseek+338540/1261671] 
scsi_debug_exit+0x3b/0x4b [scsi_debug]
Oct  9 21:24:42 doug kernel:  [sys_delete_module+301/336] 
sys_delete_module+0x12d/0x150
Oct  9 21:24:42 doug kernel:  [sys_munmap+55/96] sys_munmap+0x37/0x60
Oct  9 21:24:42 doug kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

