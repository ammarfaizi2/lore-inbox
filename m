Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbSIXTFL>; Tue, 24 Sep 2002 15:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbSIXTFL>; Tue, 24 Sep 2002 15:05:11 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:19975 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261763AbSIXTFK>; Tue, 24 Sep 2002 15:05:10 -0400
Date: Tue, 24 Sep 2002 15:10:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mark Knecht <mknecht@controlnet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: SMP machines - IRQ Priorities
In-Reply-To: <000101c263f9$dc646a10$b50aa8c0@mknecht>
Message-ID: <Pine.LNX.4.44.0209241503410.12397-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Mark Knecht wrote:

> Zwane,
>    Yes, we understand that we can see a list. The problem is that we do not
> understand whether IRQ0 is considered higher priority than IRQ23.
> Unfortunately I do not have an SMP machine to look at myself right now, so
> I'm relaying info to others.
> 
>    The traditional IRQ order was NOT in order, due to the history of the PC
> architecture. If I was to simply guess that APIC priority was 0, 1, 2, 3,
> ... 22, 23 I could easily be wrong. Possibly it's more like the traditional
> model and would go more like 0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 3, 4, 5, 6,
> 7, 16, 17...23. We simply are not sure.
> 
>    Does the list you are speaking of show up in dmesg or somewhere else that
> we can collect from people and compare the results we're getting in testing?

Sorry i've got an annoying habit of being terse at times; The local APIC 
unit will handle interrupts depending on vector, with lowest being highest 
priority. Here is a sample table with NR being the IRQ e.g. 0 = 31;

NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  0    0    0   0   0    1    1    31
 01 00F 0F  1    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    1    1    41
 04 00F 0F  0    0    0   0   0    1    1    49
 05 00F 0F  0    0    0   0   0    1    1    51
 06 00F 0F  1    0    0   0   0    1    1    59
 07 00F 0F  0    0    0   0   0    1    1    61
 08 00F 0F  0    0    0   0   0    1    1    69
 09 00F 0F  0    0    0   0   0    1    1    71
 0a 00F 0F  0    0    0   0   0    1    1    79
 0b 00F 0F  0    0    0   0   0    1    1    81
 0c 00F 0F  0    0    0   0   0    1    1    89
 0d 00F 0F  0    0    0   0   0    1    1    91
 0e 00F 0F  0    0    0   0   0    1    1    99
 0f 00F 0F  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00


 -- 
function.linuxpower.ca

