Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136063AbRBFBnR>; Mon, 5 Feb 2001 20:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136111AbRBFBnH>; Mon, 5 Feb 2001 20:43:07 -0500
Received: from winds.org ([207.48.83.9]:42244 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S136063AbRBFBms>;
	Mon, 5 Feb 2001 20:42:48 -0500
Date: Mon, 5 Feb 2001 20:41:17 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
Subject: [OT] Why so much memory 'reserved'?
Message-ID: <Pine.LNX.4.21.0102051957540.1746-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an offtopic question. What determines the amount of 'reserved' memory,
and how much to reserve?

With 2.4.1-ac3, I came up with the following different memory readings for
both a Pentium 166 and an Athlon 750.

Pentium 166: (96MB RAM)
------------
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000005f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
Memory: 94732k/98304k available (890k kernel code, 3184k reserved, 261k data,
176k init, 0k highmem)

Athlon 750: (128MB RAM)
-----------
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Memory: 126500k/131072k available (1127k kernel code, 4184k reserved, 322k
data, 200k init, 0k highmem)

Last year, when I had 32MB of memory in the Pentium 166 machine, the amount of
'reserved' memory seemed lower. It almost looked as if the amount of reserved
memory is a fraction of total available memory.

Is there a way I can 'regain' this memory from the system, especially in cases
when there's only 32MB to work with?

Thanks,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
