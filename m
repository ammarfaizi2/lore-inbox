Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVAHBdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVAHBdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVAHBcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:32:43 -0500
Received: from zork.zork.net ([64.81.246.102]:6629 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261761AbVAHBbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:31:03 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: AGP Oops (was Re: 2.6.10-mm2)
References: <20050106002240.00ac4611.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Sat, 08 Jan 2005 01:31:02 +0000
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 6 Jan 2005 00:22:40 -0800")
Message-ID: <6umzvkhfl5.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got the following upon starting X (Debian sid's 4.3.0.dfsg.1-10).
Was fine with 2.6.10-mm1.  Radeon card, VIA AGP.


Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c025a386
*pde = 78f84067
Oops: 0000 [#1]
SMP
CPU:    1
EIP:    0060:[<c025a386>]    Not tainted VLI
EFLAGS: 00013246   (2.6.10-mm2)
EIP is at agp_bind_memory+0x56/0x80
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: f027c0e0   edi: 00000000   ebp: f027c3a0   esp: f6c83f10
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 2160, threadinfo=f6c83000 task=efc3aaa0)
Stack: bffffab0 c0214a04 00000000 c23ed000 f7d6ff40 c02645df 00000000 0000a1b6
       00000000 00000000 00000001 00000000 00000036 c23ed000 c0264550 c025ffe5
       bffffab0 f6c83f50 00000005 bffff95c f6c83000 efc3aaa0 086de8c0 40086436
Call Trace:
 [<c0214a04>] copy_from_user+0x34/0x70
 [<c02645df>] drm_agp_bind+0x8f/0xf0
 [<c0264550>] drm_agp_bind+0x0/0xf0
 [<c025ffe5>] drm_ioctl+0x105/0x201
 [<c0163c1a>] do_ioctl+0x8a/0xb0
 [<c0163e5a>] sys_ioctl+0x7a/0x200
 [<c01025ad>] sysenter_past_esp+0x52/0x75
Code: 89 fa 8b 4e 20 8b 58 04 89 f0 ff 53 40 85 c0 75 07 c6 46 28 01 89 7e 1c 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 8b 46 08 <8b> 40 04 ff 50 34 c6 46 29 01 eb c6 89 74 24 04 c7 04 24 f4 d4
