Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265553AbSKFDof>; Tue, 5 Nov 2002 22:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265558AbSKFDoe>; Tue, 5 Nov 2002 22:44:34 -0500
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:6528 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265553AbSKFDod>; Tue, 5 Nov 2002 22:44:33 -0500
Message-ID: <3DC891A9.5030404@attbi.com>
Date: Tue, 05 Nov 2002 21:51:05 -0600
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unitialized timers with 2.5.46-bk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I get these warnings about uninitialized timers when using 2.5.46-bk:

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc02e16e0, data=0x0
Call Trace:
  [<c012d568>] check_timer_failed+0x68/0x70
  [<c02e16e0>] pagebuf_daemon_wakeup+0x0/0x30
  [<c012d8bb>] del_timer+0x1b/0x90
  [<c02e19a3>] pagebuf_daemon+0x293/0x2d0
  [<c02e16e0>] pagebuf_daemon_wakeup+0x0/0x30
  [<c02e1710>] pagebuf_daemon+0x0/0x2d0
  [<c0108d9d>] kernel_thread_helper+0x5/0x18

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc036ca30, data=0x0
Call Trace:
  [<c012d568>] check_timer_failed+0x68/0x70
  [<c036ca30>] floppy_shutdown+0x0/0xe0
  [<c012d8bb>] del_timer+0x1b/0x90
  [<c036a458>] reschedule_timeout+0x28/0xd0
  [<c03708f0>] floppy_find+0x0/0x60
  [<c0105094>] init+0x54/0x180
  [<c0105040>] init+0x0/0x180
  [<c0108d9d>] kernel_thread_helper+0x5/0x18

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc0485d40, data=0x0
Call Trace:
  [<c012d568>] check_timer_failed+0x68/0x70
  [<c0485d40>] addrconf_verify+0x0/0x300
  [<c012d8bb>] del_timer+0x1b/0x90
  [<c0485d7c>] addrconf_verify+0x3c/0x300
  [<c01884b7>] proc_register+0x17/0xb0
  [<c0188918>] create_proc_entry+0x88/0xc0
  [<c0105094>] init+0x54/0x180
  [<c0105040>] init+0x0/0x180
  [<c0108d9d>] kernel_thread_helper+0x5/0x18

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc0497bb0, data=0xf03d9660
Call Trace:
  [<c012d568>] check_timer_failed+0x68/0x70
  [<c0497bb0>] igmp6_timer_handler+0x0/0x70
  [<c012d8bb>] del_timer+0x1b/0x90
  [<c04979c1>] igmp6_join_group+0xa1/0x170
  [<c0496971>] igmp6_group_added+0xa1/0x110
  [<c0496cbc>] ipv6_dev_mc_inc+0x1cc/0x300
  [<c0483caa>] addrconf_join_solict+0x4a/0x50
  [<c048568c>] addrconf_dad_start+0x1c/0x1c0
  [<c04830a3>] ipv6_add_addr+0x233/0x280
  [<c0484e41>] addrconf_add_linklocal+0x41/0x70
  [<c0484f13>] addrconf_dev_config+0xa3/0xd0
  [<c0485033>] addrconf_notify+0x43/0xe0
  [<c0434b9f>] rtnetlink_event+0x2f/0x1e0
  [<c01318ed>] notifier_call_chain+0x2d/0x50
  [<c042d031>] dev_open+0x91/0xd0
  [<c042e739>] dev_change_flags+0x129/0x140
  [<c0468591>] devinet_ioctl+0x281/0x540
  [<c046b3c3>] inet_ioctl+0x93/0xe0
  [<c0425f05>] sock_ioctl+0xd5/0x240
  [<c0168027>] sys_ioctl+0xf7/0x29a
  [<c011c1a0>] do_page_fault+0x0/0x45c
  [<c010af93>] syscall_call+0x7/0xb

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc048cdd0, data=0x0
Call Trace:
  [<c012d568>] check_timer_failed+0x68/0x70
  [<c048cdd0>] fib6_run_gc+0x0/0x2d0
  [<c012d6ff>] mod_timer+0x2f/0x1d0
  [<c048c313>] fib6_add+0xe3/0xf0
  [<c048890c>] rt6_ins+0x3c/0xb0
  [<c0488a1d>] rt6_cow+0x9d/0x120
  [<c0488f0c>] ip6_route_output+0x17c/0x320
  [<c049a87e>] tcp_v6_connect+0x27e/0x6d0
  [<c0142eff>] cache_grow+0x18f/0x2a0
  [<c046ab0c>] inet_stream_connect+0x1bc/0x310
  [<c0426b9d>] sys_connect+0x7d/0xb0
  [<c04255b9>] sock_map_fd+0x119/0x140
  [<c0150b9e>] free_pages_and_swap_cache+0x4e/0x80
  [<c02fea07>] copy_from_user+0x57/0x5c
  [<c0427667>] sys_socketcall+0xa7/0x260
  [<c013046c>] sys_rt_sigprocmask+0x12c/0x1f0
  [<c010af93>] syscall_call+0x7/0xb

Thanks.

Jordan

