Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbUDFOuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUDFOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:50:14 -0400
Received: from gandalf.ios.edu.pl ([193.0.91.125]:46530 "EHLO
	gandalf.ios.edu.pl") by vger.kernel.org with ESMTP id S263835AbUDFOuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:50:09 -0400
Message-ID: <4072C394.3040508@ios.edu.pl>
Date: Tue, 06 Apr 2004 16:49:56 +0200
From: Marcin Rozek <marcin.rozek@ios.edu.pl>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at memory.c:290! (v2.4.25)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
when starting mplayer:


forget_pte: old mapping existed!
kernel BUG at memory.c:290!
invalid operand: 0000
CPU:    1
EIP:    0010:[zeromap_page_range+417/432]    Not tainted
EIP:    0010:[<c01ccb61>]    Not tainted
EFLAGS: 00210282
eax: 00000021   ebx: cb270008   ecx: 00000000   edx: df269f78
esi: 00002000   edi: 0036e025   ebp: 00070000   esp: c8a9feb4
ds: 0018   es: 0018   ss: 0018
Process mplayer (pid: 9480, stackpage=c8a9f000)
Stack: c037eb40 0000036e 00070000 00000000 c9a647c4 d5cf2380 7c470000 
c9a647c4
        00000000 00008012 00070000 c32323c0 c025837e 7c400000 00070000 
00000025
        ffffffea c01ceaaa c32323c0 cf7c85c0 c8a9ff40 c8a9ff44 c8a9ff48 
cf7c8f80
Call Trace:    [mmap_zero+62/96] [do_mmap_pgoff+986/2064] 
[do_mmap+276/368] [sys_mmap2+212/272] [system_call+51/64]
Call Trace:    [<c025837e>] [<c01ceaaa>] [<c01b0044>] [<c01af944>] 
[<c01a8573>]

Code: 0f 0b 22 01 73 e8 37 c0 e9 6c ff ff ff 89 f6 55 57 56 53 83



Process (9480) can't be killed and it takes 99.9 %CPU
PID	%CPU	%MEM	VSZ	RSS	TTY	STAT	COMMAND
9480	99.9	0.0	0	0	?	RW	[mplayer]

I'm running kernel 2.4.25 with grsecurity-1.9.14 patch.

---
Best regards,
Marcin
