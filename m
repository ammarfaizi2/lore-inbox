Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143831AbRAHNm4>; Mon, 8 Jan 2001 08:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143834AbRAHNmr>; Mon, 8 Jan 2001 08:42:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58588 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S143740AbRAHNmh>;
	Mon, 8 Jan 2001 08:42:37 -0500
Date: Mon, 8 Jan 2001 08:42:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Shane Nay <shane@agendacomputing.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs is ro only, so honour this in inode->mode
In-Reply-To: <20010108152904.K10035@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0101080836260.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Ingo Oeser wrote:

> Then we might need W bits, but currently they disturb things like
> "test" and the perl equivalent, which is quite annoying and
> complexifies code.  (Yes, I'm selfish too ;-))

Huh??? Consider write-protected floppy. What, you mean that it also
should magically change mode of everything? Ditto for any fs mounted r/o.

If program considers these bits of st_mode as indication of ability
to write into file - program is buggy and should be fixed. Regardless
of cramfs.

> See what Linus and Al think about this.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
