Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTFKDa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 23:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTFKDa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 23:30:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264052AbTFKDaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 23:30:25 -0400
Message-ID: <32796.4.64.196.31.1055303047.squirrel@www.osdl.org>
Date: Tue, 10 Jun 2003 20:44:07 -0700 (PDT)
Subject: Re: 2.5.70-bk1[23]: load_module crashes when aborting module load
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rusty@rustcorp.com.au>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just a me too on this.  I'm using 2.5.70-bk13 and if I load the usblp
module without any other USB support loaded, I get this oops.

I'll add this to my TODO list....

Rusty wrote:
| Random guess: did the build system not rebuild your modules properly
| when module.h changed?

My kernel tree is 2.5.70 plain + bk13 patch.
It never was just plain 2.5.70 or anything else.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
usblp: Unknown symbol usb_alloc_urb
usblp: Unknown symbol usb_free_urb
usblp: Unknown symbol usb_register
usblp: Unknown symbol usb_find_interface
usblp: Unknown symbol usb_submit_urb
usblp: Unknown symbol usb_control_msg
usblp: Unknown symbol usb_register_dev
usblp: Unknown symbol usb_set_interface
usblp: Unknown symbol usb_deregister
usblp: Unknown symbol usb_unlink_urb
usblp: Unknown symbol usb_deregister_dev
usblp: Unknown symbol usb_buffer_free
usblp: Unknown symbol usb_buffer_alloc
Unable to handle kernel paging request at virtual address f89ac11c
 printing eip:
c013955d
*pde = 01a6e067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c013955d>]    Not tainted
EFLAGS: 00010286
EIP is at load_module+0x78d/0x900
eax: 0000000d   ebx: f89a3000   ecx: f89abe00   edx: f7ff99f0
esi: fffffffe   edi: f89abe00   ebp: f70d3f94   esp: f70d3efc
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 1917, threadinfo=f70d2000 task=f7119310)
Stack: f89a9000 f89a9000 f89a6c80 00000000 00000000 f89abe00 400eaf50 00000000
       00000410 400eaf50 f711d448 00005000 f725d8a4 00030002 c014d57d f89ae000
       f89abe00 00000000 00000000 00000000 00000000 00000000 0000000f 00000014
Call Trace:
 [<c014d57d>] do_mmap_pgoff+0x3d7/0x698
 [<c0139765>] sys_init_module+0x95/0x2d4
 [<c0109683>] syscall_call+0x7/0xb

Code: 8b 81 1c 03 00 00 85 c0 0f 84 a7 fb ff ff 89 04 24 e8 b7 df

~Randy



