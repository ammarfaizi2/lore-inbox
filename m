Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129894AbQLWNW3>; Sat, 23 Dec 2000 08:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbQLWNWT>; Sat, 23 Dec 2000 08:22:19 -0500
Received: from [203.36.158.121] ([203.36.158.121]:22146 "HELO kabuki.eyep.net")
	by vger.kernel.org with SMTP id <S129894AbQLWNWF>;
	Sat, 23 Dec 2000 08:22:05 -0500
To: Mark Orr <markorr@intersurf.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: test13-pre4-ac2 - part of diff fails 
In-Reply-To: Your message of "Sat, 23 Dec 2000 06:23:19 CDT."
             <XFMail.20001223062319.markorr@intersurf.com> 
In-Reply-To: <XFMail.20001223062319.markorr@intersurf.com> 
Date: Sat, 23 Dec 2000 23:53:50 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20001223132215Z129894-440+3714@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On 23-Dec-2000 Daniel Stone wrote:
> >> > patching file arch/i386/kernel/smp.c
> >> > Reversed (or previously applied) patch detected!  Assume -R? [n] 
> >> > Apply anyway? [n] y
> >> > Hunk #1 FAILED at 278.
> >> > Hunk #2 succeeded at 511 (offset 9 lines).
> >> > 1 out of 2 hunks FAILED -- saving rejects to file
> >> > arch/i386/kernel/smp.c.rej
> >> > 
> >> > Works fine if I reverse it and then put it back in. ?
> >> 
> >> Its a bug in my patch - get 13pre4ac2 ..
> > 
> > Um.
> > Subject: Re: test13-pre4-ac2 - part of diff fails
> > It's _IN_ 13-4ac2.
> 
> I applied test13-pre4-ac2 here, and it applied cleanly.
> Are you applying it to a clean tree?  Are your using
> patch v2.5.4 ?   (that's the version I have)

linux-2.4.0-test12 + reiserfs + test13-pre4 + reiserfs makefile fix (only
changes fs/reiserfs/Makefile) + netfilter patch-o-matic stuff (only touches
net/ipv4/netfilter) + test13-pre4-ac2.

also seen on just linux-2.4.0-test12 + test13-pre4 + test13-pre4-ac2.
 
> FWIW, I was getting smp.c patch failures (well, it said the
> patch was previously applied) along with a bunch of
> IPTables stuff -- that was a couple of -ac's ago.

same here, just forgot to report it.

> AC1 and AC2 applied cleanly, tho AC1 wouldnt compile
> uniprocessor/no-quotas unless you added a 
> #include <linux/smp_lock.h> to fs/ext2/balloc.c
> (i.e. it left some hanging refs to lock_kernel and
> unlock_kernel in fs.o,  and I think there was also
> one in the UDF module.    It's fixed in -ac2.

ac1 came out while I was asleep, and I woke up to ac2 being released.

d
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
