Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSHGLhF>; Wed, 7 Aug 2002 07:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSHGLhF>; Wed, 7 Aug 2002 07:37:05 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:33540 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S316878AbSHGLhE>; Wed, 7 Aug 2002 07:37:04 -0400
Date: Wed, 7 Aug 2002 13:40:43 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at tg3.c:1557
Message-ID: <Pine.LNX.4.44.0208071332110.3394-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers!

I've been chasing this bug now for weeks without further ideas, so please 
tell me your thoughts about it:

On a dual Athlon MP with a 3ware-7850 RAID (640GB RAID-5) and 3C996B-T GE 
NIC I can crash the machine with the above BUG message in virtually no 
time simply by copying data both ways between the RAID and the NIC. The 
BUG message shows that this can happen any time, it doesn't matter if the 
interrupt is received in cpu_idle or something else. I tried noapic, but 
to no avail.

Does anybody know about this problem?
How can I get more debugging information?
Can the driver be patched to gracefully handle this situation, e.g. by 
resetting the card and trying again?

What I've found out till now is only that the kernel's and the NIC's view 
of the world seem to be inconsistent :-(

For our application stability is much more important than a few TCP 
retransmits...

Thanks in advance,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

