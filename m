Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUBRUSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267996AbUBRUSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:18:49 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:4001 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S268032AbUBRUS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:18:29 -0500
Message-Id: <5.1.0.14.2.20040218211418.00acaea8@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 18 Feb 2004 21:18:56 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.6.3 iwspy oops
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: JO5xVBZYQet0eVMKzj9hft1ZO4MidQ9-e7M-kBOVvpgrkEwzgptQo6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Working on a SSH WLAN connection OK (ca. 2 hours) until I entered "iwspy",
then system borked (not recoverable) :

  Unable to handle kernel paging request at virtual address c076a000
   printing eip:
  c01f6ccd
  *pde = 00103027
  *pte = 0076a000
  Oops: 0000 [#1]
  CPU:    0
  EIP:    0060:[memcpy+29/64]    Not tainted
  EIP:    0060:[<c01f6ccd>]    Not tainted
  EFLAGS: 00010203
  EIP is at memcpy+0x1d/0x40
  eax: 00000006   ebx: 000110f0   ecx: 00000001   edx: c09fde2a
  esi: c0769ffe   edi: c09fde2a   ebp: c652fe9c   esp: c652fe94
  ds: 007b   es: 007b   ss: 0068
  Process iwspy (pid: 2622, threadinfo=c652e000 task=cee18960)
  Stack: c09fde28 c076a004 c652fec0 c02db9fb c09fde2a c0769ffe 00000006 
c0703a60
         c0703800 00008b11 c08ecf38 c652ff2c c02dafad c0703800 c652ff1c 
c652ff50
         c08ecf38 c384b94c 00000000 00000000 cee18960 c0122e00 00000000 
00000000
  Call Trace:
   [iw_handler_get_spy+91/208] iw_handler_get_spy+0x5b/0xd0
   [<c02db9fb>] iw_handler_get_spy+0x5b/0xd0
   [wireless_process_ioctl+813/2352] wireless_process_ioctl+0x32d/0x930
   [<c02dafad>] wireless_process_ioctl+0x32d/0x930
   [default_wake_function+0/32] default_wake_function+0x0/0x20
   [<c0122e00>] default_wake_function+0x0/0x20
   [iw_handler_get_spy+0/208] iw_handler_get_spy+0x0/0xd0
   [<c02db9a0>] iw_handler_get_spy+0x0/0xd0
   [dev_ioctl+340/1024] dev_ioctl+0x154/0x400
   [<c02cf074>] dev_ioctl+0x154/0x400
   [sock_ioctl+223/768] sock_ioctl+0xdf/0x300
   [<c02c46df>] sock_ioctl+0xdf/0x300
   [sys_ioctl+510/608] sys_ioctl+0x1fe/0x260
   [<c018e9fe>] sys_ioctl+0x1fe/0x260
   [syscall_call+7/11] syscall_call+0x7/0xb
   [<c010bc7f>] syscall_call+0x7/0xb

  Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 34 24 89 d0 8b 7c
  Unable to handle kernel paging request at virtual address ec81e64d
   printing eip:
  c01b45bc
  *pde = 00000000
  Oops: 0000 [#2]
  CPU:    0
  EIP:    0060:[pid_alive+12/48]    Not tainted
  EIP:    0060:[<c01b45bc>]    Not tainted
  EFLAGS: 00010286
  EIP is at pid_alive+0xc/0x30
  eax: ec81e651   ebx: c09f1e3c   ecx: c4a4df38   edx: ec81e589
  esi: ec81e589   edi: c09f1e2c   ebp: cef57e6c   esp: cef57e6c
  ds: 007b   es: 007b   ss: 0068
  Process mingetty (pid: 2623, threadinfo=cef56000 task=cef7c960)
  Stack: cef57e9c c01b51a3 ec81e589 cf1c0f38 00000000 c4a4df38 c651f008 
00034b38
         00000002 c4a4df38 cef57f68 cffc4224 cef57ebc c01893b9 c4a4df38 
cef57f68
         00000000 cef57efc cef57ef4 c651f00a cef57f18 c0189b67 cef57f68 
cef57efc
  Call Trace:
   [pid_revalidate+35/512] pid_revalidate+0x23/0x200
   [<c01b51a3>] pid_revalidate+0x23/0x200
   [do_lookup+89/160] do_lookup+0x59/0xa0
   [<c01893b9>] do_lookup+0x59/0xa0
   [link_path_walk+1895/3936] link_path_walk+0x767/0xf60
   [<c0189b67>] link_path_walk+0x767/0xf60
   [unmap_page_range+78/128] unmap_page_range+0x4e/0x80
   [<c015f52e>] unmap_page_range+0x4e/0x80
Feb 18 19:33:43 marglap init: Id "1" respawning too fast: disabled for 5 
minutes
   [open_namei+134/1120] open_namei+0x86/0x460
   [<c018ad46>] open_namei+0x86/0x460
   [getname+41/192] getname+0x29/0xc0
   [<c0188829>] getname+0x29/0xc0
   [filp_open+58/96] filp_open+0x3a/0x60
   [<c017487a>] filp_open+0x3a/0x60
   [sys_open+85/160] sys_open+0x55/0xa0
   [<c0175035>] sys_open+0x55/0xa0
   [syscall_call+7/11] syscall_call+0x7/0xb
   [<c010bc7f>] syscall_call+0x7/0xb

  Code: 39 82 c4 00 00 00 75 08 5d 8b 82 cc 00 00 00 c3 0f 0b 08 03
   <1>Unable to handle kernel paging request at virtual address ec81e64d
   printing eip:
  c01b45bc
  *pde = 00000000
  Oops: 0000 [#3]
  CPU:    0
  EIP:    0060:[pid_alive+12/48]    Not tainted
  EIP:    0060:[<c01b45bc>]    Not tainted
  EFLAGS: 00010286
  EIP is at pid_alive+0xc/0x30
  eax: ec81e651   ebx: c09f1e3c   ecx: c4a4df38   edx: ec81e589
  esi: ec81e589   edi: c09f1e2c   ebp: cef57e6c   esp: cef57e6c
  ds: 007b   es: 007b   ss: 0068
  Process mingetty (pid: 2626, threadinfo=cef56000 task=cef7c960)
  Stack: cef57e9c c01b51a3 ec81e589 cf1c0f38 00000000 c4a4df38 c972c008 
00034b38
         00000002 c4a4df38 cef57f68 cffc4224 cef57ebc c01893b9 c4a4df38 
cef57f68
         00000000 cef57efc cef57ef4 c972c00a cef57f18 c0189b67 cef57f68 
cef57efc
  Call Trace:
   [pid_revalidate+35/512] pid_revalidate+0x23/0x200
   [<c01b51a3>] pid_revalidate+0x23/0x200
   [do_lookup+89/160] do_lookup+0x59/0xa0
   [<c01893b9>] do_lookup+0x59/0xa0
   [link_path_walk+1895/3936] link_path_walk+0x767/0xf60
   [<c0189b67>] link_path_walk+0x767/0xf60
   [open_namei+134/1120] open_namei+0x86/0x460
   [<c018ad46>] open_namei+0x86/0x460
   [common_interrupt+24/32] common_interrupt+0x18/0x20
   [<c010c5ec>] common_interrupt+0x18/0x20
   [getname+41/192] getname+0x29/0xc0
   [<c0188829>] getname+0x29/0xc0
   [filp_open+58/96] filp_open+0x3a/0x60
   [<c017487a>] filp_open+0x3a/0x60
   [sys_open+85/160] sys_open+0x55/0xa0
   [<c0175035>] sys_open+0x55/0xa0
   [syscall_call+7/11] syscall_call+0x7/0xb
   [<c010bc7f>] syscall_call+0x7/0xb

  Code: 39 82 c4 00 00 00 75 08 5d 8b 82 cc 00 00 00 c3 0f 0b 08 03
   <1>Unable to handle kernel paging request at virtual address ec81e64d
   printing eip:
  c01b45bc
  *pde = 00000000
  Oops: 0000 [#4]
  CPU:    0
  EIP:    0060:[pid_alive+12/48]    Not tainted
  EIP:    0060:[<c01b45bc>]    Not tainted
  EFLAGS: 00010286
  EIP is at pid_alive+0xc/0x30
  eax: ec81e651   ebx: c09f1e3c   ecx: c4a4df38   edx: ec81e589
  esi: ec81e589   edi: c09f1e2c   ebp: cef57e6c   esp: cef57e6c
  ds: 007b   es: 007b   ss: 0068
  Process mingetty (pid: 2629, threadinfo=cef56000 task=cef7c960)
  Stack: cef57e9c c01b51a3 ec81e589 cf1c0f38 00000000 c4a4df38 c7120008 
00034b38
         00000002 c4a4df38 cef57f68 cffc4224 cef57ebc c01893b9 c4a4df38 
cef57f68
         00000000 cef57efc cef57ef4 c712000a cef57f18 c0189b67 cef57f68 
cef57efc
  Call Trace:
   [pid_revalidate+35/512] pid_revalidate+0x23/0x200
   [<c01b51a3>] pid_revalidate+0x23/0x200
   [do_lookup+89/160] do_lookup+0x59/0xa0
   [<c01893b9>] do_lookup+0x59/0xa0
   [link_path_walk+1895/3936] link_path_walk+0x767/0xf60
   [<c0189b67>] link_path_walk+0x767/0xf60
   [unmap_page_range+78/128] unmap_page_range+0x4e/0x80
   [<c015f52e>] unmap_page_range+0x4e/0x80
   [open_namei+134/1120] open_namei+0x86/0x460
   [<c018ad46>] open_namei+0x86/0x460
   [getname+41/192] getname+0x29/0xc0
   [<c0188829>] getname+0x29/0xc0
   [filp_open+58/96] filp_open+0x3a/0x60
   [<c017487a>] filp_open+0x3a/0x60
   [sys_open+85/160] sys_open+0x55/0xa0
   [<c0175035>] sys_open+0x55/0xa0
   [syscall_call+7/11] syscall_call+0x7/0xb
   [<c010bc7f>] syscall_call+0x7/0xb

  Code: 39 82 c4 00 00 00 75 08 5d 8b 82 cc 00 00 00 c3 0f 0b 08 03
   <1>Unable to handle kernel paging request at virtual address ec81e64d
   printing eip:
  c01b45bc
  *pde = 00000000
  Oops: 0000 [#5]
  CPU:    0
  EIP:    0060:[pid_alive+12/48]    Not tainted
  EIP:    0060:[<c01b45bc>]    Not tainted
  EFLAGS: 00010286
  EIP is at pid_alive+0xc/0x30
  eax: ec81e651   ebx: c09f1e3c   ecx: c4a4df38   edx: ec81e589
  esi: ec81e589   edi: c09f1e2c   ebp: cef57e6c   esp: cef57e6c
  ds: 007b   es: 007b   ss: 0068
  Process mingetty (pid: 2632, threadinfo=cef56000 task=cef7c960)
  Stack: cef57e9c c01b51a3 ec81e589 cf1c0f38 00000000 c4a4df38 c678f008 
00034b38
         00000002 c4a4df38 cef57f68 cffc4224 cef57ebc c01893b9 c4a4df38 
cef57f68
         00000000 cef57efc cef57ef4 c678f00a cef57f18 c0189b67 cef57f68 
cef57efc
  Call Trace:
   [pid_revalidate+35/512] pid_revalidate+0x23/0x200
   [<c01b51a3>] pid_revalidate+0x23/0x200
   [do_lookup+89/160] do_lookup+0x59/0xa0
   [<c01893b9>] do_lookup+0x59/0xa0
   [link_path_walk+1895/3936] link_path_walk+0x767/0xf60
   [<c0189b67>] link_path_walk+0x767/0xf60
   [unmap_page_range+78/128] unmap_page_range+0x4e/0x80
   [<c015f52e>] unmap_page_range+0x4e/0x80
   [open_namei+134/1120] open_namei+0x86/0x460
   [<c018ad46>] open_namei+0x86/0x460
   [getname+41/192] getname+0x29/0xc0
   [<c0188829>] getname+0x29/0xc0
   [filp_open+58/96] filp_open+0x3a/0x60
   [<c017487a>] filp_open+0x3a/0x60
   [sys_open+85/160] sys_open+0x55/0xa0
   [<c0175035>] sys_open+0x55/0xa0
   [syscall_call+7/11] syscall_call+0x7/0xb
   [<c010bc7f>] syscall_call+0x7/0xb

  Code: 39 82 c4 00 00 00 75 08 5d 8b 82 cc 00 00 00 c3 0f 0b 08 03
   <1>Unable to handle kernel paging request at virtual address ec81e64d
   printing eip:
  c01b45bc
  *pde = 00000000
  Oops: 0000 [#6]
  CPU:    0
  EIP:    0060:[pid_alive+12/48]    Not tainted
  EIP:    0060:[<c01b45bc>]    Not tainted
  EFLAGS: 00010286
  EIP is at pid_alive+0xc/0x30
  eax: ec81e651   ebx: c09f1e3c   ecx: c4a4df38   edx: ec81e589
  esi: ec81e589   edi: c09f1e2c   ebp: cef57e6c   esp: cef57e6c
  ds: 007b   es: 007b   ss: 0068
  Process mingetty (pid: 2635, threadinfo=cef56000 task=cef7c960)
  Stack: cef57e9c c01b51a3 ec81e589 cf1c0f38 00000000 c4a4df38 c58f3008 
00034b38
         00000002 c4a4df38 cef57f68 cffc4224 cef57ebc c01893b9 c4a4df38 
cef57f68
         00000000 cef57efc cef57ef4 c58f300a cef57f18 c0189b67 cef57f68 
cef57efc
  Call Trace:
   [pid_revalidate+35/512] pid_revalidate+0x23/0x200
   [<c01b51a3>] pid_revalidate+0x23/0x200
   [do_lookup+89/160] do_lookup+0x59/0xa0
   [<c01893b9>] do_lookup+0x59/0xa0
   [link_path_walk+1895/3936] link_path_walk+0x767/0xf60
   [<c0189b67>] link_path_walk+0x767/0xf60
   [unmap_page_range+78/128] unmap_page_range+0x4e/0x80
   [<c015f52e>] unmap_page_range+0x4e/0x80
   [open_namei+134/1120] open_namei+0x86/0x460
   [<c018ad46>] open_namei+0x86/0x460
   [getname+41/192] getname+0x29/0xc0
   [<c0188829>] getname+0x29/0xc0
   [filp_open+58/96] filp_open+0x3a/0x60
   [<c017487a>] filp_open+0x3a/0x60
   [sys_open+85/160] sys_open+0x55/0xa0
   [<c0175035>] sys_open+0x55/0xa0
   [syscall_call+7/11] syscall_call+0x7/0xb
   [<c010bc7f>] syscall_call+0x7/0xb


