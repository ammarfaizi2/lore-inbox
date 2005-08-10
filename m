Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVHJPPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVHJPPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVHJPPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:15:34 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:44676 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965153AbVHJPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:15:33 -0400
Message-ID: <42FA1A02.6070207@masoud.ir>
Date: Wed, 10 Aug 2005 11:15:14 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Crash on boot when switching between 2.4.32-pre2 and 2.6.13-pre6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a dual P3 machine that crashes when I first (cold) start it with 
2.6.13-rc6 and then reboot it to use 2.4.32-pre2.
It boots, and during booting, around the time it is supposed to 
initalize serial device and software watchdog, it hangs with a message 
like this: (Note: It is garbled on my serial terminal):
----
  v ((r20t0u1all0 7ad-d0r8e)s ww itt00 0M000N0YY8_
R TSS rSiHnttiREn_gI Reii  SS                     P
IAA0L0_PP0000 1I8            E
P**Ppddee naabb0l0ed0

0000
    ttyS00 at 00
                3fCPU:    1
                           ) is a    0010:[<00000018 0x02f8 (itainted
sEFLAGS: 0
          010Real Time Clock0000   ebx.10f
6foftware Wat0000001  er: 0.05, timer mesiin: 60 se0   edi: c1b02000   
ebp: ffff
e000   esp: c1b03fb0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c1b03000)
Stack: c01070a2 00000002 00000000 00000000 00000000 c011f855 00000b1a 
00000b1a
       00000286 c03ac81c 00000001 00000000 00000001 c044cbea 00000246 
0000002a
       000000ff c011facf 00000000 00000400
Call Trace:    [<c01070a2>] [<c011f855>] [<c011facf>]

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
---
If it matters, I am booting this machine with 'acpi=off' as with ACPI 
enabled, whenever I reboot the machine, It just turns itself off.
Cold starting from 2.4 and 2.6 works just fine. The machine runs the ltp 
test and can compile kernels several times with -j8
Please let me know if you need more information.
cheers,
Masoud


