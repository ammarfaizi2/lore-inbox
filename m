Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQL3XQT>; Sat, 30 Dec 2000 18:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQL3XQJ>; Sat, 30 Dec 2000 18:16:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39950 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129348AbQL3XPx>; Sat, 30 Dec 2000 18:15:53 -0500
Date: Sat, 30 Dec 2000 14:44:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederman@uswest.net>
cc: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <m1u27lpo1g.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.10.10012301441350.1477-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 Dec 2000, Eric W. Biederman wrote:
> 
> One other thing to think about for the VFS/MM layer is limiting the
> total number of dirty pages in the system (to what disk pressure shows
> the disk can handle), to keep system performance smooth when swapping.

This is a separate issue, and I think that it is most closely tied in to
the "RSS limit" kind of patches because of the memory mapping issues. If
you've seen the RSS rlimit patch (it's been posted a few times this week),
then you could think of that modified by a "Resident writable pages Set
Size" approach. Not just for shared mappings - this is also an issue with
limiting swapout.

(I actually don't think that RSS is all that interesting, it's really the
"potentially dirty RSS" that counts for VM behaviour - everything else can
be dropped easily enough)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
