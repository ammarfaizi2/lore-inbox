Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131709AbRAIQqS>; Tue, 9 Jan 2001 11:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131710AbRAIQqI>; Tue, 9 Jan 2001 11:46:08 -0500
Received: from law2-f84.hotmail.com ([216.32.181.84]:8467 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131709AbRAIQpz>;
	Tue, 9 Jan 2001 11:45:55 -0500
X-Originating-IP: [208.5.125.50]
From: "Kambo Lohan" <kambo77@hotmail.com>
To: linux-kernel@vger.kernel.org, linux-eepro100@vger.kernel.org
Cc: infinity2@lock-net.com
Subject: Re: [eepro100] Ok, I'm fed up now
Date: Tue, 09 Jan 2001 11:45:49 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com>
X-OriginalArrivalTime: 09 Jan 2001 16:45:49.0249 (UTC) FILETIME=[9EE05B10:01C07A5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having the same problems, I have duplicated the hard lockups / ethernet 
hangs on two intel 815EE boards.  It happens when send traffic through the 
onboard eepro100 is high, and sometimes running something like vmstat 1 in 
the background triggers the lockup faster.  When it locks up there is 
nothing in the log, no oops or anything.  Sometimes it just hangs eth0 with 
the (cmd timeout) msgs and an ifconfig down/up fixes it temporarily.

I am using 2.2.18, heres compile info:
Jan  9 08:29:32 axiom1 kernel: Linux version 2.2.18 (root@flankerbuild) (gcc 
version egcs-2.91.66 19990Jan  9 08:29:32 axiom1 kernel: Detected 598065 kHz 
processor.
Jan  9 08:29:32 axiom1 kernel: Console: colour VGA+ 80x25
Jan  9 08:29:32 axiom1 kernel: Calibrating delay loop... 1192.75 BogoMIPS
Jan  9 08:29:32 axiom1 kernel: Memory: 126976k/129792k available (884k 
kernel code, 412k reserved, 1480Jan  9 08:29:32 axiom1 kernel: Dentry hash 
table entries: 16384 (order 5, 128k)
Jan  9 08:29:32 axiom1 kernel: Buffer cache hash table entries: 131072 
(order 7, 512k)
Jan  9 08:29:32 axiom1 kernel: Page cache hash table entries: 32768 (order 
5, 128k)
Jan  9 08:29:32 axiom1 kernel: Intel machine check architecture supported.
Jan  9 08:29:32 axiom1 kernel: Intel machine check reporting enabled on 
CPU#0.
Jan  9 08:29:32 axiom1 kernel: 128K L2 cache (4 way)
Jan  9 08:29:32 axiom1 kernel: CPU: L2 Cache: 128K
Jan  9 08:29:32 axiom1 kernel: CPU: Intel Pentium III (Coppermine) stepping 
06
Jan  9 08:29:32 axiom1 kernel: Checking 386/387 coupling... OK, FPU using 
exception 16 error reporting.Jan  9 08:29:32 axiom1 kernel: Checking 'hlt' 
instruction... OK.
Jan  9 08:29:32 axiom1 kernel: POSIX conformance testing by UNIFIX
Jan  9 08:29:32 axiom1 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfda95
Jan  9 08:29:32 axiom1 kernel: PCI: Using configuration type 1
Jan  9 08:29:32 axiom1 kernel: PCI: Probing PCI hardware
Jan  9 08:29:32 axiom1 kernel: Linux NET4.0 for Linux 2.2

I will test the latest 2.2.19pre with it.  Do you need my kernel config, 
it's all generic, i have eepro100 and 3c59x built as modules everything else 
is default (smp is OFF).

I can trigger this lockup repeatedly by doing a shell script on the 815 that 
rsyncs a large file to another machine over and over.  After about 5 minutes 
of high load it either hangs hard or hangs the eth card.

I have a 3com59x in there as well, it and the onboard eepro are both using 
irq 11 - is that normal?  The 3com is in promiscuous mode sniffing a lot of 
traffic as well, during the tests.

-- original text --
Ok, I just build another server, also using an Intel D815EAL. Same exact
setup as the other one. Celeron 600cpu w/ 128mb ram (PC133 btw). both
systems lockup doing ftp transfers. I didn't know for sure about the first
one, so I just opened up an ncftp session and downloaded something large
from the internet. Netscape 6 was what I found (not planning on installing
it btw), didn't get very far then locked up tight. twice in a row. no
errors, nothing, nothing to report either.

So, I built another. i have parts for 2 of them (almost ready for the
garbage) so i put together the second. i can hardly download anything.
can't even get down new rpm or source code for the new kernels. i'm on my
last nerve here and about to throw the motherboards out the window. I don't
understand how you guys make these motherboards work. what am i missing?
i'm so fed up. 3 weeks lost and no servers to show for it. my boss is so
pissed.

do you guys have any input? where else can i go to find out about these
boards?

Thanks,
Rob

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
