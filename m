Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265041AbSKFNWY>; Wed, 6 Nov 2002 08:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265046AbSKFNWY>; Wed, 6 Nov 2002 08:22:24 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:65032 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265041AbSKFNWW>; Wed, 6 Nov 2002 08:22:22 -0500
Message-ID: <3DC9192E.62600E21@aitel.hist.no>
Date: Wed, 06 Nov 2002 14:29:18 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, netdev@oss.sgi.com
Subject: Re: 2.5.46-mm1 3 uninitialized timers during boot, ipv6 related?
References: <3DC8D423.DAD2BF1A@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see these aren't dangerous, but I guess they're there for
someone to see.  So here they are.
Seems they have something to do with ipv6.

VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 308k freed
Adding 502700k swap on /dev/ide/host0/bus0/target0/lun0/part5. 
Priority:-1 extents:1
NTFS volume version 1.2.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc02b53dc, data=0xc1293aec
Call Trace:
 [<c011ebc0>] check_timer_failed+0x40/0x4c
 [<c02b53dc>] igmp6_timer_handler+0x0/0x50
 [<c011eff1>] del_timer+0x15/0x74
 [<c02b529e>] igmp6_join_group+0x8a/0x104
 [<c02b455c>] igmp6_group_added+0xb0/0xbc
 [<c02bcb99>] fl_create+0x1b9/0x1f8
 [<c02b48a9>] ipv6_dev_mc_inc+0x281/0x294
 [<c02a5a1e>] addrconf_join_solict+0x3a/0x44
 [<c02a6e73>] addrconf_dad_start+0x13/0x12c
 [<c02a6844>] addrconf_add_linklocal+0x28/0x40
 [<c02a68f5>] addrconf_dev_config+0x99/0xa4
 [<c02a69de>] addrconf_notify+0x52/0xc0
 [<c0121d5a>] notifier_call_chain+0x1e/0x38
 [<c024f976>] dev_open+0xa2/0xac
 [<c0250a55>] dev_change_flags+0x51/0x104
 [<c0281420>] devinet_ioctl+0x2bc/0x598
 [<c0283827>] inet_ioctl+0x7b/0xb8
 [<c02c3a9b>] packet_ioctl+0x173/0x190
 [<c0249943>] sock_ioctl+0x1ef/0x218
 [<c014bbf9>] sys_ioctl+0x21d/0x274
 [<c0108943>] syscall_call+0x7/0xb

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc02b53dc, data=0xc1293a1c
Call Trace:
 [<c011ebc0>] check_timer_failed+0x40/0x4c
 [<c02b53dc>] igmp6_timer_handler+0x0/0x50
 [<c011eff1>] del_timer+0x15/0x74
 [<c02b529e>] igmp6_join_group+0x8a/0x104
 [<c02b455c>] igmp6_group_added+0xb0/0xbc
 [<c02bcb99>] fl_create+0x1b9/0x1f8
 [<c02b48a9>] ipv6_dev_mc_inc+0x281/0x294
 [<c02a5a1e>] addrconf_join_solict+0x3a/0x44
 [<c02a6e73>] addrconf_dad_start+0x13/0x12c
 [<c02a6844>] addrconf_add_linklocal+0x28/0x40
 [<c02a68f5>] addrconf_dev_config+0x99/0xa4
 [<c02a69de>] addrconf_notify+0x52/0xc0
 [<c0121d5a>] notifier_call_chain+0x1e/0x38
 [<c024f976>] dev_open+0xa2/0xac
 [<c0250a55>] dev_change_flags+0x51/0x104
 [<c0281420>] devinet_ioctl+0x2bc/0x598
 [<c0283827>] inet_ioctl+0x7b/0xb8
 [<c0249943>] sock_ioctl+0x1ef/0x218
 [<c014bbf9>] sys_ioctl+0x21d/0x274
 [<c0108943>] syscall_call+0x7/0xb

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc02b53dc, data=0xc1293b54
Call Trace:
 [<c011ebc0>] check_timer_failed+0x40/0x4c
 [<c02b53dc>] igmp6_timer_handler+0x0/0x50
 [<c011eff1>] del_timer+0x15/0x74
 [<c02b529e>] igmp6_join_group+0x8a/0x104
 [<c02b455c>] igmp6_group_added+0xb0/0xbc
 [<c02bcb99>] fl_create+0x1b9/0x1f8
 [<c02b48a9>] ipv6_dev_mc_inc+0x281/0x294
 [<c02a5a1e>] addrconf_join_solict+0x3a/0x44
 [<c02a6e73>] addrconf_dad_start+0x13/0x12c
 [<c02a6844>] addrconf_add_linklocal+0x28/0x40
 [<c02a68f5>] addrconf_dev_config+0x99/0xa4
 [<c02a69de>] addrconf_notify+0x52/0xc0
 [<c0121d5a>] notifier_call_chain+0x1e/0x38
 [<c024f976>] dev_open+0xa2/0xac
 [<c0250a55>] dev_change_flags+0x51/0x104
 [<c0281420>] devinet_ioctl+0x2bc/0x598
 [<c0283827>] inet_ioctl+0x7b/0xb8
 [<c0249943>] sock_ioctl+0x1ef/0x218
 [<c014bbf9>] sys_ioctl+0x21d/0x274
 [<c0108943>] syscall_call+0x7/0xb

eth0: no IPv6 routers present
