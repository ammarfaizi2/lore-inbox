Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130769AbRASLik>; Fri, 19 Jan 2001 06:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRASLib>; Fri, 19 Jan 2001 06:38:31 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:41586 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S130769AbRASLiU>;
	Fri, 19 Jan 2001 06:38:20 -0500
Date: Fri, 19 Jan 2001 12:36:33 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <Holger.Kiehl@dwd.de>, <linux-kernel@vger.kernel.org>
Subject: Re: More filesystem corruption under 2.4.1-pre8 and SW Raid5
In-Reply-To: <3A68226D.4FDEFB7B@colorfullife.com>
Message-Id: <Pine.LNX.4.30.0101191222170.28348-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jan 2001, Manfred Spraul wrote:

> > Another thing I notice is that the responsiveness of the machine
> > decreases dramatically as the test progresses until it is nearly
> > useless. After the test is done everything is back to normal.
> > The same behavior was observed under 2.2.18.
>
> That's expected: ext2 performs linear searches through the directory,
> and with 50 000 entries that's very slow.
>
Would reiserfs be better and does it now work with SW Raid5?

> I'm running a few quick tests, but I don't have a large enough spare
> partition (~ 1GB?) for a full test.
>
> How much main memory do you have, how large is your raid5 partition?
>
On the two machines I have tried both have 256 MB of memory and one
has a 8GB Raid5 and the other has a 30GB Raid5 partition.

> Could you try to reproduce the problem with fewer files and less main
> memory?
>
I will try.

> I'm running your test with 48 MB ram, 12500 files, 9 processes in a 156
> MB partition (swapoff, here is the test partition ;-).
> With 192MB Ram I don't see the corruption.
>
I am not sure if I understand you correctly: with 48MB you do get
corruption and with 192MB not? And if you do see corruption are you
using SW Raid, SMP?

With 10000 I also had no problem, my next step was 50000.

Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
