Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLWMyF>; Sat, 23 Dec 2000 07:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbQLWMxz>; Sat, 23 Dec 2000 07:53:55 -0500
Received: from alex.intersurf.net ([216.115.129.11]:6154 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S129436AbQLWMxs>; Sat, 23 Dec 2000 07:53:48 -0500
Message-ID: <XFMail.20001223062319.markorr@intersurf.com>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sat, 23 Dec 2000 06:23:19 -0600 (CST)
Reply-To: Mark Orr <markorr@intersurf.com>
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: Re: test13-pre4-ac2 - part of diff fails
Cc: Daniel Stone <daniel@kabuki.eyep.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23-Dec-2000 Daniel Stone wrote:
>> > patching file arch/i386/kernel/smp.c
>> > Reversed (or previously applied) patch detected!  Assume -R? [n] 
>> > Apply anyway? [n] y
>> > Hunk #1 FAILED at 278.
>> > Hunk #2 succeeded at 511 (offset 9 lines).
>> > 1 out of 2 hunks FAILED -- saving rejects to file
>> > arch/i386/kernel/smp.c.rej
>> > 
>> > Works fine if I reverse it and then put it back in. ?
>> 
>> Its a bug in my patch - get 13pre4ac2 ..
> 
> Um.
> Subject: Re: test13-pre4-ac2 - part of diff fails
> It's _IN_ 13-4ac2.

I applied test13-pre4-ac2 here, and it applied cleanly.
Are you applying it to a clean tree?  Are your using
patch v2.5.4 ?   (that's the version I have)

FWIW, I was getting smp.c patch failures (well, it said the
patch was previously applied) along with a bunch of
IPTables stuff -- that was a couple of -ac's ago.

AC1 and AC2 applied cleanly, tho AC1 wouldnt compile
uniprocessor/no-quotas unless you added a 
#include <linux/smp_lock.h> to fs/ext2/balloc.c
(i.e. it left some hanging refs to lock_kernel and
unlock_kernel in fs.o,  and I think there was also
one in the UDF module.    It's fixed in -ac2.

--
Mark Orr
markorr@intersurf.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
