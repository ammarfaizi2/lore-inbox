Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131422AbRASLSk>; Fri, 19 Jan 2001 06:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130769AbRASLSU>; Fri, 19 Jan 2001 06:18:20 -0500
Received: from colorfullife.com ([216.156.138.34]:33291 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131422AbRASLSJ>;
	Fri, 19 Jan 2001 06:18:09 -0500
Message-ID: <3A68226D.4FDEFB7B@colorfullife.com>
Date: Fri, 19 Jan 2001 12:18:05 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Holger.Kiehl@dwd.de, linux-kernel@vger.kernel.org
Subject: More filesystem corruption under 2.4.1-pre8 and SW Raid5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another thing I notice is that the responsiveness of the machine
> decreases dramatically as the test progresses until it is nearly
> useless. After the test is done everything is back to normal.
> The same behavior was observed under 2.2.18.

That's expected: ext2 performs linear searches through the directory,
and with 50 000 entries that's very slow.

I'm running a few quick tests, but I don't have a large enough spare
partition (~ 1GB?) for a full test.

How much main memory do you have, how large is your raid5 partition?

Could you try to reproduce the problem with fewer files and less main
memory?

I'm running your test with 48 MB ram, 12500 files, 9 processes in a 156
MB partition (swapoff, here is the test partition ;-).
With 192MB Ram I don't see the corruption.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
