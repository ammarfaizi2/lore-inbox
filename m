Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbTIABL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTIABL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:11:27 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:64780 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262567AbTIABLU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:11:20 -0400
Date: Mon, 1 Sep 2003 03:11:12 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm4
Message-Id: <20030901031112.17a98baf.aradorlinux@yahoo.es>
In-Reply-To: <20030830161536.7e7be6d3.akpm@osdl.org>
References: <20030830161536.7e7be6d3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 30 Aug 2003 16:15:36 -0700 Andrew Morton <akpm@osdl.org> escribió:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm4/

I've been getting this warnings randomly since a few kernels. (sadly, i don't
know when they started)

Sep  1 02:39:33 estel modprobe: FATAL: Module apm not found. 
Sep  1 02:39:34 estel kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:512
Sep  1 02:39:34 estel kernel: Call Trace:
Sep  1 02:39:34 estel kernel:  [__might_sleep+97/128] __might_sleep+0x61/0x80
Sep  1 02:39:34 estel kernel:  [save_v86_state+110/544] save_v86_state+0x6e/0x220
Sep  1 02:39:34 estel kernel:  [handle_vm86_fault+183/2576] handle_vm86_fault+0xb7/0xa10
Sep  1 02:39:34 estel kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Sep  1 02:39:34 estel kernel:  [__copy_from_user_ll+68/112] __copy_from_user_ll+0x44/0x70
Sep  1 02:39:34 estel kernel:  [do_general_protection+0/160] do_general_protection+0x0/0xa0
Sep  1 02:39:34 estel kernel:  [error_code+47/56] error_code+0x2f/0x38
Sep  1 02:39:34 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  1 02:39:34 estel kernel:  [inet_fill_ifaddr+123/672] inet_fill_ifaddr+0x7b/0x2a0
Sep  1 02:39:34 estel kernel: 
[...]
Sep  1 02:39:53 estel modprobe: FATAL: Module apm not found. 
Sep  1 02:39:53 estel kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:512
Sep  1 02:39:53 estel kernel: Call Trace:
Sep  1 02:39:53 estel kernel:  [__might_sleep+97/128] __might_sleep+0x61/0x80
Sep  1 02:39:53 estel kernel:  [save_v86_state+110/544] save_v86_state+0x6e/0x220
Sep  1 02:39:53 estel kernel:  [handle_vm86_fault+183/2576] handle_vm86_fault+0xb7/0xa10
Sep  1 02:39:53 estel kernel:  [kernel_text_address+59/80] kernel_text_address+0x3b/0x50
Sep  1 02:39:53 estel kernel:  [do_general_protection+0/160] do_general_protection+0x0/0xa0
Sep  1 02:39:53 estel kernel:  [error_code+47/56] error_code+0x2f/0x38
Sep  1 02:39:53 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  1 02:39:53 estel kernel:  [inet_fill_ifaddr+123/672] inet_fill_ifaddr+0x7b/0x2a0
Sep  1 02:39:53 estel kernel: 


I though they happened randonmly. But I realisedI've a 
"modprobe: FATAL: Module apm not found."
just before them. I'll try to track down the responsible userspace app causing
this behaviour (and do a better bug report).
