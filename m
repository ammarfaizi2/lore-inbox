Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUBOAGd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 19:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUBOAGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 19:06:33 -0500
Received: from 215.commandprompt.com ([207.173.200.215]:21750 "EHLO
	hosting.commandprompt.com") by vger.kernel.org with ESMTP
	id S263632AbUBOAGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 19:06:22 -0500
Date: Sat, 14 Feb 2004 16:06:17 -0800 (PST)
From: "Joshua D. Drake" <jd@commandprompt.com>
To: zohn_ming wu <wu_zohn_ming@yahoo.com>
cc: linux-kernel@vger.kernel.org, <pgsql-hackers@postgresql.org>
Subject: Re: [HACKERS] friday 13 bug?
In-Reply-To: <20040214234405.96047.qmail@web41204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0402141605050.27049-100000@hosting.commandprompt.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I personally ran into the exact same thing with another customer.
They are running RedHat 8.0 with (2.4.20 at the time). We had to upgrade 
them to 2.4.23 and reboot. Worked like a charm. This was about two months 
ago. I swear it was almost the exact same error.

Sincerely,

Joshua D. Drake


On Sat, 14 Feb 2004, zohn_ming wu wrote:

> Kernel 2.4.23 on redhat 8.0Please cc any response from
> linux kernel list.  TIA.
> 
> On or about 7:50am Friday 13 2004 my postgresql server
> breaks down.  I can ssh and use "top" and "ps" but
> postgresql stops accepting connection.  A small perl
> script that logs system load average also hangs.  I
> cannot "kill -9" any hang processes including
> postgreqsql postmaster process.
> 
> I then check dmesg and found error message that I copy
> and paste at the bottom.
> 
> I finally issued reboot but reboot also didn't work
> and I had to push the reset button.
> 
> AMD XP 2500+ with 1.5GB Memory.  Postgresql data lives
> on a software raid 1 device.
> 
> Kernel 2.4.23 on redhat 8.0
> 
> Postgresql 7.4
> 
> The last time server was rebooted was about 60 days
> ago when I upgraded the kernel
> 
> Can someone suggest anything to help me avoid this
> type of breakdown?  I tried to post the message
> yesterday but postgresql list wasn't responding at all
> to subscription request.
> 
> ------------
> 
> swap_free: Bad swap file entry 00000004
> kernel BUG at buffer.c:539!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0138e8e>]    Not tainted
> EFLAGS: 00010282
> eax: cfd10a40   ebx: 00000002   ecx: e75f6ac0   edx:
> c02c548c
> esi: e75f6ac0   edi: 00000001   ebp: e75f6ac0   esp:
> f74efe60
> ds: 0018   es: 0018   ss: 0018
> Process postmaster (pid: 457, stackpage=f74ef000)
> Stack: 00000002 c01397ab e75f6ac0 00000002 e75f6ac0
> 00001000 c013a326 e75f6ac0
>        00001000 00000000 00420000 00000000 c2166b40
> f7822980 c013aaef f7822980
>        c2166b40 00000000 00001000 c2166b40 f7822980
> 00001000 f7822a34 c016064c
> Call Trace:    [<c01397ab>] [<c013a326>] [<c013aaef>]
> [<c016064c>] [<c0160310>]
>   [<c012af71>] [<c012b4f6>] [<c015d8a9>] [<c0137753>]
> [<c010733f>]
>                                                       
>                                                       
>     
> Code: 0f 0b 1b 02 17 e0 23 c0 8b 02 85 c0 75 07 89 0a
> 89 49 24 8b
> linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Finance: Get your refund fast by filing online.
> http://taxes.yahoo.com/filing.html
> 
> ---------------------------(end of broadcast)---------------------------
> TIP 5: Have you checked our extensive FAQ?
> 
>                http://www.postgresql.org/docs/faqs/FAQ.html
> 

-- 
Co-Founder
Command Prompt, Inc.
The wheel's spinning but the hamster's dead

