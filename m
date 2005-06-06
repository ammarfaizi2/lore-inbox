Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVFFQux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVFFQux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVFFQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 12:50:53 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:55009 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261257AbVFFQuh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 12:50:37 -0400
Date: Mon, 6 Jun 2005 09:50:31 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Hanno =?ISO-8859-1?B?QvZjaw==?= <mail@hboeck.de>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Kernel oops with asus_acpi module
Message-Id: <20050606095031.667bbed5.rdunlap@xenotime.net>
In-Reply-To: <200506052340.41074.mail@hboeck.de>
References: <200506052340.41074.mail@hboeck.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2005 23:40:40 +0200 Hanno Böck wrote:

| Matthias Hentges has postet this a while ago to the acpi4asus-list:
| http://sourceforge.net/mailarchive/forum.php?thread_id=7214924&forum_id=33295
| 
| I have a Samsung P30. The problem happens on both rc and mm-kernels at the 
| moment.
| I hope this can be fixed before 2.6.12.
| 
| The asus_acpi module freezes the system on boot if compiled into the kernel.
| 
| If loaded as a module, I get this error:
| 
| Asus Laptop ACPI Extras version 0.29
| Unable to handle kernel NULL pointer dereference at virtual address 00000000
|  printing eip:
| e19e9391
| *pde = 00000000
| Oops: 0000 [#1]
| PREEMPT
| Modules linked in: asus_acpi eth1394 ipw2100 ohci1394 ieee1394 yenta_socket 
| rsrc_nonstatic pcmcia_core ehci_hcd uhci_hcd usbcore
| CPU:    0
| EIP:    0060:[<e19e9391>]    Not tainted VLI
| EFLAGS: 00210203   (2.6.12-rc5-mm2)
| EIP is at asus_hotk_get_info+0x1aa/0x79a [asus_acpi]
| eax: 00000000   ebx: dfe0d000   ecx: 00000002   edx: 00000003
| esi: 00000000   edi: e19fca60   ebp: d7e9c800   esp: dae19ec0
| ds: 007b   es: 007b   ss: 0068
| Process modprobe (pid: 12174, threadinfo=dae18000 task=d13bf0b0)
| Stack: 00000000 00200296 c011c497 00000000 ffffffd8 dfe0d000 00000000 00000000
|        c05a9c88 c011c273 dae19f6c dfc37c3c 00000000 c0294036 00000000 00000000
|        00000000 dae19f54 00200246 0000002b 00000300 0000030c 00000000 00000000
| Call Trace:
|  [<c011c497>] release_console_sem+0xe7/0x110
|  [<c011c273>] vprintk+0x1f3/0x2b0
|  [<c0294036>] sub_alloc+0xb6/0x1b0
|  [<e19e9a3f>] asus_hotk_add+0x8b/0x143 [asus_acpi]
|  [<c02e0f01>] acpi_bus_driver_init+0x29/0x50
|  [<c02e0fbc>] acpi_driver_attach+0x59/0x9d
|  [<e19e9b41>] asus_acpi_init+0x4a/0x72 [asus_acpi]
|  [<c0138212>] sys_init_module+0xc2/0x200
|  [<c01030d7>] sysenter_past_esp+0x54/0x75
| Code: e1 e8 f4 2c 73 de 5e 5f a1 10 eb 9f e1 ba 03 00 00 00 bf 60 ca 9f e1 89 
| d1 c7 40 14 12 00 00 00 8b 45 08 89 04 24 89 c6 49 78 08 <ac> ae 75 08 84 c0 
| 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 75 11 a1
| 
| 
| If you need further info, please contact me.

What processor (x86) type/configs is your kernel compiled for?

Can you repeat with Magic SysRq enabled (if not already) and
set log level to 9 (echo 9 > /proc/sysrq-trigger or
Alt-SysRq-9).  That should provide more console log info
for us.... then post that log.  (or check your log files,
this log info may already be in some of them)

Thanks,
---
~Randy
