Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTIMXXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbTIMXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:23:10 -0400
Received: from c-24-118-26-196.mn.client2.attbi.com ([24.118.26.196]:33152
	"EHLO x1-6-00-03-6d-12-44-dd.comcast.net") by vger.kernel.org
	with ESMTP id S262239AbTIMXXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:23:07 -0400
Date: Sat, 13 Sep 2003 18:22:54 -0500 (CDT)
From: Scott Hoffman <scott781@comcast.net>
To: linux-kernel@vger.kernel.org, <arjanv@redhat.com>
Subject: Oops report, 2.6.0-test5-smp
Message-ID: <Pine.LNX.4.44.0309131810150.1510-100000@x1-6-00-03-6d-12-44-dd.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  After booting into 2.6 with hdd=ide-scsi, then trying to rmmod ide-scsi, 
I get the following Oops:

x1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000024
x1 kernel:  printing eip:
x1 kernel: c017f217
x1 kernel: *pde = 00000000
x1 kernel: Oops: 0002 [#1]
x1 kernel: CPU:    1
x1 kernel: EIP:    0060:[<c017f217>]    Not tainted
x1 kernel: EFLAGS: 00010202
x1 kernel: EIP is at simple_rmdir+0x27/0x50
x1 kernel: eax: 00000000   ebx: ccb61e20   ecx: ccb61e40   edx: ffffffd9
x1 kernel: esi: ccb308f4   edi: ccb5b3a8   ebp: ccb61e20   esp: cb283ebc
x1 kernel: ds: 007b   es: 007b   ss: 0068
x1 kernel: Process rmmod (pid: 1429, threadinfo=cb282000 task=ccc4ece0)
x1 kernel: Stack: ccb61e20 ccb30354 ccb30960 ccb308f4 c019929c ccb308f4 ccb61e20 ccb61d14 
x1 kernel:        ccb61e40 ccb61e20 00000880 c0199396 ccb61e20 ccb61d14 cf590154 c03605a8 
x1 kernel:        d084abe0 c01c3893 cf590154 c0360560 cf590154 cf590130 c02175f1 cf590154 
x1 kernel: Call Trace:
x1 kernel:  [<c019929c>] remove_dir+0x6c/0xa0
x1 kernel:  [<c0199396>] sysfs_remove_dir+0xb6/0x110
x1 kernel:  [<c01c3893>] kobject_del+0x43/0x70
x1 kernel:  [<c02175f1>] device_del+0x81/0xb0
x1 kernel:  [<d0847fed>] idescsi_cleanup+0x4d/0x60 [ide_scsi]
x1 kernel:  [<c0243df1>] ide_unregister_driver+0x71/0xbe
x1 kernel:  [<d0848b57>] exit_idescsi_module+0x27/0x2b [ide_scsi]
x1 kernel:  [<c0139c1e>] sys_delete_module+0x15e/0x1c0
x1 /sbin/hotplug: no runnable /etc/hotplug/scsi_host.agent is installed
x1 kernel:  [<c0151bb3>] do_munmap+0x153/0x1c0
x1 kernel:  [<c010ac7f>] syscall_call+0x7/0xb
x1 kernel: 
x1 kernel: Code: ff 48 24 89 34 24 89 5c 24 04 e8 aa ff ff ff 31 d2 ff 4e 24 
x1 /sbin/hotplug: no runnable /etc/hotplug/scsi_device.agent is installed
x1 /sbin/hotplug: no runnable /etc/hotplug/scsi.agent is installed
x1 login(pam_unix)[1365]: authentication failure; logname=LOGIN uid=0 euid=0 tty=tty2 ruser= rhost=  user=root

  The kernel and latest modutils are installed from 
people.redhat.com/arjanv/2.5, otherwise the system is RH9 on dual athlons.  
  So, is this just a user and/or userspace error?  The system seems stable 
enough afterwards, but will not shutdown cleanly.

--
Scott Hoffman

