Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUCPXlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUCPXlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:41:05 -0500
Received: from mail58-s.fg.online.no ([148.122.161.58]:32488 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261851AbUCPXjk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:39:40 -0500
To: linux-kernel@vger.kernel.org
Subject: vmware on linux 2.6.4
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 17 Mar 2004 00:39:37 +0100
Message-ID: <yw1xu10ogy4m.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to build the vmware modules for kernel 2.6.4 and got this oops
when loading vmmon.o:

vmmon: no version magic, tainting kernel.
vmmon: module license 'unspecified' taints kernel.
Unable to handle kernel NULL pointer dereference at virtual address 0000006e
 printing eip:
c020160f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c020160f>]    Tainted: PF 
EFLAGS: 00010206
EIP is at vsnprintf+0x43/0x4b9
eax: c6f11c53   ebx: c6f11c00   ecx: 0000006e   edx: 0000006e
esi: c6f11c54   edi: c6f11c0c   ebp: c6f11c67   esp: d2b61ee8
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 23426, threadinfo=d2b60000 task=d0f52720)
Stack: e89fe000 c0101e8c 00000202 c01468d5 00000202 c0338394 00000286 d2b61f38 
       00000014 c6f11c54 0000006e c6f11c00 fffffff4 c6f11c0c c162d180 c023c3e9 
       d2b61f54 00000000 6f6d6d76 e8a2dd90 6fed6d76 c036ae08 c022fb77 c162d180 
Call Trace:
 [<c01468d5>] unmap_vm_area+0x27/0x67
 [<c023c3e9>] class_simple_device_add+0xa9/0xff
 [<c022fb77>] misc_register+0xb2/0x186
 [<e8a1a1d0>] init_module+0x144/0x1e8 [vmmon]
 [<c013126e>] sys_init_module+0x105/0x211
 [<c0108ffd>] sysenter_past_esp+0x52/0x71

Code: 80 3a 00 74 25 0f b6 02 3c 25 74 41 39 ee 77 06 88 06 8b 54 
 <4>vmmon: no version magic, tainting kernel.

Suggestions welcome.

-- 
Måns Rullgård
mru@kth.se
