Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQKRAD4>; Fri, 17 Nov 2000 19:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129302AbQKRADr>; Fri, 17 Nov 2000 19:03:47 -0500
Received: from hera.cwi.nl ([192.16.191.1]:13774 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129289AbQKRADk>;
	Fri, 17 Nov 2000 19:03:40 -0500
Date: Sat, 18 Nov 2000 00:33:28 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011172333.AAA128995.aeb@aak.cwi.nl>
To: koenig@tat.physik.uni-tuebingen.de, torvalds@transmeta.com
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Cc: Andries.Brouwer@cwi.nl, aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus:

> How about this version (full patch against test10 - it includes a
> slightly corrected version of my earlier dir.c patch)?

> It's entirely untested, but it looks good and compiles. Ship it!

There are three files that have to be changed.
You changed dir.c yesterday, and namei.c today
but still have to do inode.c.

Your stuff resembles my stuff. In namei.c I also replaced the 15
lines following
	} else if (dir->i_sb->u.isofs_sb.s_mapping == 'n') {
by the line
	dlen = isofs_name_translate(dpnt, dlen, page);

But now that you did two-thirds of the job I take it you'll
also do the third part? It is again precisely the same stuff.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
