Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130455AbQKRAVb>; Fri, 17 Nov 2000 19:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbQKRAVW>; Fri, 17 Nov 2000 19:21:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61188 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130530AbQKRAVI>; Fri, 17 Nov 2000 19:21:08 -0500
Date: Fri, 17 Nov 2000 15:51:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: koenig@tat.physik.uni-tuebingen.de, aeb@veritas.com, emoenke@gwdg.de,
        eric@andante.org, kobras@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <UTC200011172333.AAA128995.aeb@aak.cwi.nl>
Message-ID: <Pine.LNX.4.10.10011171547540.898-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000 Andries.Brouwer@cwi.nl wrote:
> 
> But now that you did two-thirds of the job I take it you'll
> also do the third part? It is again precisely the same stuff.

Are you talking about isofs_lookup_grandparent()?

The code is now dead, and has been for a long time actually (as the VFS
layer keeps track of ".." for us these days). Removed.

I'll look at the isofs_read_level3_size() thing. At least that one doesn't
have the name translation crap in it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
