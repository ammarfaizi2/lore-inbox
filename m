Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTC1ByW>; Thu, 27 Mar 2003 20:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTC1ByV>; Thu, 27 Mar 2003 20:54:21 -0500
Received: from tomts23.bellnexxia.net ([209.226.175.185]:44999 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261907AbTC1ByU>; Thu, 27 Mar 2003 20:54:20 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.66-mm1
Date: Thu, 27 Mar 2003 21:06:05 -0500
User-Agent: KMail/1.5.9
References: <20030326013839.0c470ebb.akpm@digeo.com>
In-Reply-To: <20030326013839.0c470ebb.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303272106.05623.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Got this opps after about 20 hours with mm1 (65-mm3 lasted 5 days
until I rebooted).

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c011516d
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c011516d>]    Not tainted VLI
EFLAGS: 00010097
EIP is at schedule+0x8d/0x3a0
eax: 00000001   ebx: cf5e99c0   ecx: cf5e99c0   edx: ffffffff
esi: 00000000   edi: c031de00   ebp: cf5ebf08   esp: cf5ebef0
ds: 007b   es: 007b   ss: 0068
Process newsplex (pid: 1205, threadinfo=cf5ea000 task=cf5e99c0)
Stack: c011fbd7 c02bbc40 00000246 05261e41 cf5ebf14 cf5ebf50 cf5ebf3c c0120754 
       cf5ebf14 c02bc538 c02bc538 05261e41 4b87ad6e c01206e0 cf5e99c0 c02bbc40 
       c015abd6 000007d1 00000000 cf5ebf60 c015ac19 cf5ea000 cf5ea000 00000000 
Call Trace:
 [<c011fbd7>] add_timer+0x57/0xa0
 [<c0120754>] schedule_timeout+0x54/0xa0
 [<c01206e0>] process_timeout+0x0/0x20
 [<c015abd6>] do_poll+0x56/0xc0
 [<c015ac19>] do_poll+0x99/0xc0
 [<c015ad88>] sys_poll+0x148/0x220
 [<c013eb3b>] sys_mprotect+0x21b/0x22f
 [<c01079ec>] sys_clone+0x2c/0x60
 [<c015a200>] __pollwait+0x0/0xc0
 [<c0109277>] syscall_call+0x7/0xb

Code: 40 17 04 75 4d 8b 03 85 c0 74 47 48 0f 84 da 02 00 00 ff 0d 00 de 31 c0 8b 43 68 ff 08 8b 03 83 f8 02 0f 84 b6 02 00 00 8b 73 28 <ff> 4e 00 8b 53 24 8b 43 20 89 50 04 89 02 8b 4b 18 8d 14 ce 8d 
 <6>note: newsplex[1205] exited with preempt_count 2
Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c01168d3>] __might_sleep+0x53/0x60
 [<c01198d5>] profile_exit_task+0x15/0x60
 [<c011aee6>] do_exit+0x86/0x460
 [<c0109ab5>] die+0x75/0x80
 [<c0113854>] do_page_fault+0x134/0x45e
 [<c0114798>] try_to_wake_up+0x138/0x240
 [<c011fde4>] mod_timer+0x124/0x180
 [<c012a520>] nanosleep_wake_up+0x0/0x20
 [<c0131feb>] buffered_rmqueue+0xab/0x140
 [<c0132103>] __alloc_pages+0x83/0x280
 [<c0113720>] do_page_fault+0x0/0x45e
 [<c01094dd>] error_code+0x2d/0x40
 [<c011516d>] schedule+0x8d/0x3a0
 [<c011fbd7>] add_timer+0x57/0xa0
 [<c0120754>] schedule_timeout+0x54/0xa0
 [<c01206e0>] process_timeout+0x0/0x20
 [<c015abd6>] do_poll+0x56/0xc0
 [<c015ac19>] do_poll+0x99/0xc0
 [<c015ad88>] sys_poll+0x148/0x220
 [<c013eb3b>] sys_mprotect+0x21b/0x22f
 [<c01079ec>] sys_clone+0x2c/0x60
 [<c015a200>] __pollwait+0x0/0xc0
 [<c0109277>] syscall_call+0x7/0xb

Hope this helps

Ed Tomlinson


