Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbQKIXNe>; Thu, 9 Nov 2000 18:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbQKIXNY>; Thu, 9 Nov 2000 18:13:24 -0500
Received: from h12-197.tokyu-net.catv.ne.jp ([202.221.12.197]:2820 "EHLO
	research.imasy.or.jp") by vger.kernel.org with ESMTP
	id <S130006AbQKIXNL>; Thu, 9 Nov 2000 18:13:11 -0500
Date: Fri, 10 Nov 2000 08:13:03 +0900
Message-Id: <200011092313.eA9ND3602593@research.imasy.or.jp>
From: Taisuke Yamada <tai@imasy.or.jp>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: Re: Patch: Using clipped IDE disk larger than 32GB with old BIOS
In-Reply-To: Your message of "Wed, 8 Nov 2000 11:23:52 -0800 (PST)".
    <Pine.LNX.4.10.10011081115030.5484-100000@master.linux-ide.org>
X-Mailer: mnews [version 1.22PL4] 2000-05/28(Sun)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > # I might consider adding support for even newer 48-bit LBA
> > # extension (which I read in ATA spec).
>
> The 48-LBA stuff is on hold because it requires more than simple
> changes to ide-disk.c.

Yes, I guess this is currently a future issue. If this is going to
be done, there also needs fix in userland program, like fdisk and
hdparm.

> We have not voted on the final design of the 48-LBA and no drive
> or BIOS guys have any product ready for testing.

But we're definitely going to face the problem as we'll probably
see IDE disk larger then 128GB next year. What was the current
max - 80GB, I thought? That not so far away from 128GB.

> So you like that TASKFILE. ;-)

Actually it was the one I found out its usage first :-). Its
interface seems OK for me.

For TASK vs. CMD issue, I have no definite idea on it. But if sole
reason for CMD interface is to limit invalid/unsafe IDE command
submission, I guess they could (not should) go to userland as a
library (libsafeide?). I'll re-read the discussion so I can write
something more thought out.

--
T. Yamada <tai@imasy.or.jp> (http://www.imasy.or.jp/~tai/index.html.{ja,en})
PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
