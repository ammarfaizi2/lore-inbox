Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271226AbTHCS0i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271270AbTHCS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:26:37 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:32781
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S271226AbTHCS0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:26:33 -0400
Date: Sun, 3 Aug 2003 11:26:25 -0700
From: Joshua Kwan <joshk@triplehelix.org>
To: linux-kernel@vger.kernel.org, hostap@lists.shmoo.com
Subject: Weird badness in 2.6.0-test2
Message-ID: <20030803182625.GA11226@nasledov.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Attached is a log of some oops I received when shutting down my laptop
using HostAP kernel modules for my wireless card in kernel
2.6.0-test2-mm2. Is this a known problem?

Thanks,
Josh

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="badness.log"

kobject 'statistics' does not have a release() function, it is broken and must be fixed.
Badness in kobject_cleanup at lib/kobject.c:402
Call Trace:
 [kobject_cleanup+95/133] kobject_cleanup+0x5f/0x85
 [netdev_unregister_sysfs+57/59] netdev_unregister_sysfs+0x39/0x3b
 [netdev_run_todo+262/366] netdev_run_todo+0x106/0x16e
 [_end+307373442/1069392712] prism2_free_local_data+0x320/0x3c6 [hostap_cs]
 [_end+307374510/1069392712] prism2_detach+0x81/0x11c [hostap_cs]
 [_end+307374381/1069392712] prism2_detach+0x0/0x11c [hostap_cs]
 [unbind_request+200/212] unbind_request+0xc8/0xd4
 [ds_ioctl+967/1658] ds_ioctl+0x3c7/0x67a
 [unix_dgram_sendmsg+1132/1366] unix_dgram_sendmsg+0x46c/0x556
 [journal_dirty_metadata+327/519] journal_dirty_metadata+0x147/0x207
 [buffered_rmqueue+214/386] buffered_rmqueue+0xd6/0x182
 [sock_sendmsg+195/222] sock_sendmsg+0xc3/0xde
 [__ext3_journal_stop+36/80] __ext3_journal_stop+0x24/0x50
 [do_anonymous_page+307/548] do_anonymous_page+0x133/0x224
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [schedule+645/1272] schedule+0x285/0x4f8
 [zap_pte_range+327/380] zap_pte_range+0x147/0x17c
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [zap_pmd_range+71/97] zap_pmd_range+0x47/0x61
 [unmap_page_range+67/105] unmap_page_range+0x43/0x69
 [unmap_vmas+220/521] unmap_vmas+0xdc/0x209
 [unmap_region+155/222] unmap_region+0x9b/0xde
 [unmap_vma+64/125] unmap_vma+0x40/0x7d
 [unmap_vma_list+28/40] unmap_vma_list+0x1c/0x28
 [do_munmap+326/387] do_munmap+0x146/0x183
 [ds_ioctl+0/1658] ds_ioctl+0x0/0x67a
 [sys_ioctl+253/626] sys_ioctl+0xfd/0x272
 [sys_munmap+68/100] sys_munmap+0x44/0x64
 [syscall_call+7/11] syscall_call+0x7/0xb

Device class 'wlan0' does not have a release() function, it is broken and must be fixed.
Badness in class_dev_release at drivers/base/class.c:201
Call Trace:
 [kobject_cleanup+131/133] kobject_cleanup+0x83/0x85
 [class_device_unregister+19/35] class_device_unregister+0x13/0x23
 [netdev_run_todo+262/366] netdev_run_todo+0x106/0x16e
 [_end+307373442/1069392712] prism2_free_local_data+0x320/0x3c6 [hostap_cs]
 [_end+307374510/1069392712] prism2_detach+0x81/0x11c [hostap_cs]
 [_end+307374381/1069392712] prism2_detach+0x0/0x11c [hostap_cs]
 [unbind_request+200/212] unbind_request+0xc8/0xd4
 [ds_ioctl+967/1658] ds_ioctl+0x3c7/0x67a
 [unix_dgram_sendmsg+1132/1366] unix_dgram_sendmsg+0x46c/0x556
 [journal_dirty_metadata+327/519] journal_dirty_metadata+0x147/0x207
 [buffered_rmqueue+214/386] buffered_rmqueue+0xd6/0x182
 [sock_sendmsg+195/222] sock_sendmsg+0xc3/0xde
 [__ext3_journal_stop+36/80] __ext3_journal_stop+0x24/0x50
 [do_anonymous_page+307/548] do_anonymous_page+0x133/0x224
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [schedule+645/1272] schedule+0x285/0x4f8
 [zap_pte_range+327/380] zap_pte_range+0x147/0x17c
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [zap_pmd_range+71/97] zap_pmd_range+0x47/0x61
 [unmap_page_range+67/105] unmap_page_range+0x43/0x69
 [unmap_vmas+220/521] unmap_vmas+0xdc/0x209
 [unmap_region+155/222] unmap_region+0x9b/0xde
 [unmap_vma+64/125] unmap_vma+0x40/0x7d
 [unmap_vma_list+28/40] unmap_vma_list+0x1c/0x28
 [do_munmap+326/387] do_munmap+0x146/0x183
 [ds_ioctl+0/1658] ds_ioctl+0x0/0x67a
 [sys_ioctl+253/626] sys_ioctl+0xfd/0x272
 [sys_munmap+68/100] sys_munmap+0x44/0x64
 [syscall_call+7/11] syscall_call+0x7/0xb

kobject 'class_obj' does not have a release() function, it is broken and must be fixed.
Badness in kobject_cleanup at lib/kobject.c:402
Call Trace:
 [kobject_cleanup+95/133] kobject_cleanup+0x5f/0x85
 [netdev_run_todo+262/366] netdev_run_todo+0x106/0x16e
 [_end+307373442/1069392712] prism2_free_local_data+0x320/0x3c6 [hostap_cs]
 [_end+307374510/1069392712] prism2_detach+0x81/0x11c [hostap_cs]
 [_end+307374381/1069392712] prism2_detach+0x0/0x11c [hostap_cs]
 [unbind_request+200/212] unbind_request+0xc8/0xd4
 [ds_ioctl+967/1658] ds_ioctl+0x3c7/0x67a
 [unix_dgram_sendmsg+1132/1366] unix_dgram_sendmsg+0x46c/0x556
 [journal_dirty_metadata+327/519] journal_dirty_metadata+0x147/0x207
 [buffered_rmqueue+214/386] buffered_rmqueue+0xd6/0x182
 [sock_sendmsg+195/222] sock_sendmsg+0xc3/0xde
 [__ext3_journal_stop+36/80] __ext3_journal_stop+0x24/0x50
 [do_anonymous_page+307/548] do_anonymous_page+0x133/0x224
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [schedule+645/1272] schedule+0x285/0x4f8
 [zap_pte_range+327/380] zap_pte_range+0x147/0x17c
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [zap_pmd_range+71/97] zap_pmd_range+0x47/0x61
 [unmap_page_range+67/105] unmap_page_range+0x43/0x69
 [unmap_vmas+220/521] unmap_vmas+0xdc/0x209
 [unmap_region+155/222] unmap_region+0x9b/0xde
 [unmap_vma+64/125] unmap_vma+0x40/0x7d
 [unmap_vma_list+28/40] unmap_vma_list+0x1c/0x28
 [do_munmap+326/387] do_munmap+0x146/0x183
 [ds_ioctl+0/1658] ds_ioctl+0x0/0x67a
 [sys_ioctl+253/626] sys_ioctl+0xfd/0x272
 [sys_munmap+68/100] sys_munmap+0x44/0x64
 [syscall_call+7/11] syscall_call+0x7/0xb

hostap_cs: Netdevice wlan0 unregistered


--gatW/ieO32f1wygP--
