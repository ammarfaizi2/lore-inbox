Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTLXMeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 07:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTLXMeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 07:34:19 -0500
Received: from 217-124-7-234.dialup.nuria.telefonica-data.net ([217.124.7.234]:27523
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263596AbTLXMeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 07:34:18 -0500
Date: Wed, 24 Dec 2003 13:34:15 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PPP ooopses on 2.6.0-mm1 (and 2.6.0, but VMware loaded here)
Message-ID: <20031224123415.GA8701@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200312241121.56934.kde@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312241121.56934.kde@myrealbox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 24 December 2003, at 11:21:56 +0200,
ismail 'cartman' dönmez wrote:

> Here is what I get from syslog :
> 
> Dec 24 11:09:51 southpark kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000065
> [...]
> Dec 24 11:09:51 southpark kernel:  <6>note: events/0[3] exited with preempt_count 1
> 
> This somehow freezes X too. Anyone seen similar problems?
> 
Hmmm, I have just had two nasty problems with X the last two days. The
first went unnoticed in the logs, but yesterday I got the following in
the logs. It seems strange to me to get an oops with mixed information
from XFree86 al PPP support.

*BIG FAT WARNING*, VMware modules were loaded, so take the following with a
BIG grain of salt:
Dec 24 00:11:23 dardhal kernel: Unable to handle kernel paging request at virtual address 10076de4
Dec 24 00:11:23 dardhal kernel: printing eip:
Dec 24 00:11:23 dardhal kernel: 10076de4
Dec 24 00:11:23 dardhal kernel: *pde = 00000000
Dec 24 00:11:23 dardhal kernel: Oops: 0000 [#1]
Dec 24 00:11:23 dardhal kernel: CPU:    0
Dec 24 00:11:23 dardhal kernel: EIP:    0060:[<10076de4>]    Tainted: P  
Dec 24 00:11:23 dardhal kernel: EFLAGS: 00013282
Dec 24 00:11:23 dardhal kernel: EIP is at 0x10076de4
Dec 24 00:11:23 dardhal kernel: eax: 00000000   ebx: c036d480   ecx: da8928c0   edx: da5b7b40
Dec 24 00:11:23 dardhal kernel: esi: 00000200   edi: 00000009   ebp: 00000009   esp: dd103ecc
Dec 24 00:11:23 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Dec 24 00:11:23 dardhal kernel: Process XFree86 (pid: 895, threadinfo=dd102000 task=dcb30cc0)
Dec 24 00:11:23 dardhal kernel: Stack: c023e919 da8928c0 da5b7b40 00000000 da8928c0 c015d6ca da8928c0 00000000 
Dec 24 00:11:23 dardhal kernel: dd102000 00000000 00000000 00000000 00000145 cfffff9a 00000000 42000000 
Dec 24 00:11:23 dardhal kernel: cfffff9a dd102000 de9967c4 de9967a4 de996784 de996820 de996800 de9967e0 
Dec 24 00:11:23 dardhal kernel: Call Trace:
Dec 24 00:11:23 dardhal kernel: [<c023e919>] sock_poll+0x29/0x40
Dec 24 00:11:23 dardhal kernel: [<c015d6ca>] do_select+0x2aa/0x2b0
Dec 24 00:11:23 dardhal kernel: [<c015d270>] __pollwait+0x0/0xd0
Dec 24 00:11:23 dardhal kernel: [<c015d9db>] sys_select+0x2db/0x500
Dec 24 00:11:23 dardhal kernel: [<c01090cb>] syscall_call+0x7/0xb
Dec 24 00:11:23 dardhal kernel: 
Dec 24 00:11:23 dardhal kernel: Code:  Bad EIP value.
Dec 24 00:11:23 dardhal kernel: <7>PPP: VJ decompression error
Dec 24 00:11:23 dardhal kernel: PPP: VJ decompression error

Kernel version is 2.6.0, XFree86 is 4.2.1-9 and libc 2.3.2.ds1-10, all from
Debian Sid, not updated too frequently, to say the truth :)

Hope it helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0)
