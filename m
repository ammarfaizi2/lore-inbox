Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271749AbTGRMie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTGRMie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:38:34 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:8841 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id S271749AbTGRMiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:38:25 -0400
Subject: 2.6.0-test1: (ACPI) Oops when changing CPU frequency
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1058532688.2138.3.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-1) 
Date: 18 Jul 2003 14:51:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just tried 2.6.0-test1 on my laptop. I get ACPI oopses when I
change the CPU frequency through the ACPI proc interface:

Unable to handle kernel NULL pointer dereference at virtual address
00000240
 printing eip:
c0117243
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0117243>]    Not tainted
EFLAGS: 00010206
EIP is at acpi_processor_write_performance+0x173/0x200
eax: 00000230   ebx: cb77bb80   ecx: 01000000   edx: 00000200
esi: 00000001   edi: cccbfed4   ebp: 00000001   esp: cccbfeb0
ds: 007b   es: 007b   ss: 0068
Process autospeedstep (pid: 1231, threadinfo=cccbe000 task=cdc9a700)
Stack: cccbfed4 01000000 00000000 00000001 00000000 01000000 c02b1b00
c02ae491
       ce197660 01000000 00000001 c014bbde ce197660 cdd6e820 ced63060
cccdd400
       00000001 00000060 cccbff00 ce197660 ce197680 cdc9a700 40018000
c011cf5c
Call Trace:
 [<c014bbde>] handle_mm_fault+0xee/0x160
 [<c011cf5c>] do_page_fault+0x13c/0x477
 [<c014d448>] do_mmap_pgoff+0x5e8/0x710
 [<c015988e>] vfs_write+0xbe/0x130
 [<c01599b2>] sys_write+0x42/0x70
 [<c010af7d>] sysenter_past_esp+0x52/0x71

Code: 8b 48 10 89 3c 24 b8 e8 03 00 00 f7 e1 89 44 24 38 e8 17 57
 [ACPI Debug] String: _PSR
[ACPI Debug] String: _PSR
[ACPI Debug] String: _PSR
[ACPI Debug] String: _PSR
[ACPI Debug] String: _PSR
[ACPI Debug] String: _PSR
[ACPI Debug] String: _PSR
[ACPI Debug] String: _PSR

I can provide more info if needed.

Cheers,

Jurgen


