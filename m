Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTEVSCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTEVSCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:02:03 -0400
Received: from freeside.toyota.com ([63.87.74.7]:37345 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S262934AbTEVSCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:02:01 -0400
Message-ID: <3ECD13A1.9060103@tmsusa.com>
Date: Thu, 22 May 2003 11:14:57 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: 2.5.69-mm8 improvements and one oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

This may be of interest...

kernel: 2.5.69-mm8

Linux distro: Red Hat 9 + updates

Hardware:
Celeron 1.2 Ghz on Intel Motherboard
51e MB RAM, 2x e100 ethernet

FWIW, The last few 2.5.69-mm releases would not boot for me,
but would oops while trying to load usb modules, then hang
immediately after the line announcing the activation of swap.

Happily, -mm8 compiled without module errors, and booted fine.

All seems healthy, and the services are all fully functional,
but I did spot this oops in syslog, after logging in and starting
a gnome session:

I wil gladly supply .config and all other info if desired

Best regards,

Joe

------------[ cut here ]------------
kernel BUG at kernel/sched.c:614!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011d762>]    Not tainted VLI
EFLAGS: 00010246
EIP is at schedule_tail+0xe2/0x140
eax: 00000008   ebx: 00000000   ecx: d65d4e40   edx: d563c000
esi: d8fa0120   edi: d953a31c   ebp: d563dfb8   esp: d563df9c
ds: 007b   es: 007b   ss: 0068
Process bonobo-activati (pid: 1275, threadinfo=d563c000 task=d65d54c0)
Stack: 43297d43 7d43297d 297d4329 43297d43 7d43297d d8fa0120 d65d54c0 
d564ffbc
       c010a362 d8fa0120 01200011 00000000 00000000 00000000 40018da8 
bfffe148
       00000000 0000007b 0000007b 00000078 ffffe410 00000073 00000202 
bfffe0ec
Call Trace:
 [<c010a362>] ret_from_fork+0x6/0x14

Code: 85 d2 74 16 89 d6 83 c6 04 19 c9 39 70 18 83 d9 00 85 c9 75 05 8b 
43 7c 89 02 83 c4 14 5b 5e 5d c3 89 34 24 e8 a0 35 00 00 eb c6 <0f> 0b 
66 02 ad 7d 3e c0 eb b2 8d 74 26 00 89 d8 e8 f9 66 00 00


