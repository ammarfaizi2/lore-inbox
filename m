Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWAPOPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWAPOPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAPOPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:15:20 -0500
Received: from spirit.analogic.com ([204.178.40.4]:2834 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750802AbWAPOPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:15:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 16 Jan 2006 14:15:16.0278 (UTC) FILETIME=[45FE1D60:01C61AA7]
Content-class: urn:content-classes:message
Subject: Shared memory usage
Date: Mon, 16 Jan 2006 09:15:16 -0500
Message-ID: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Shared memory usage
Thread-Index: AcYap0YHt6grN63kQZivoGaUrC0SFA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I have an embedded system in which there are about 18.4
megabytes of shared libraries using shared memory, plus
12 pages of shared memory, memory-mapped into user-space.
This all works fine.

But the customer complained during certification testing
that shared memory in use is not measured and therefore
cannot be verified. This means that there may be rogue
communications channels, using shared memory, in the
system. I need to prove that there are no such channels
by metering the shared memory and then accounting for
every bit shown.

/proc/meminfo does not show any shared memory in use!

         total:    used:    free:  shared: buffers:  cached:
Mem:  255332352  7806976 247525376        0    94208  2764800
Swap:        0        0        0
MemTotal:       249348 kB
MemFree:        241724 kB
MemShared:           0 kB         <----------
Buffers:            92 kB
Cached:           2700 kB
SwapCached:          0 kB
Active:            608 kB
Inactive:         4348 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       249348 kB
LowFree:        241724 kB
SwapTotal:           0 kB
SwapFree:            0 kB


This used Linux version 2.4.26. In attempting to troubleshoot
this, I found that current kernel versions don't even have a
shared memory entry in /proc/meminfo.

So, how do I find the total amount of shared memory in use
on a system? This does not need to be in /proc. I could
write a driver that finds all the shared memory and reports
it, but I need to know how. Also, anybody certifying systems
for secure use needs to know the amount of shared memory in
use so it would be a real good idea if that information was
available in /proc as it was in the past before it was
removed.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
