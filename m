Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQLZCvd>; Mon, 25 Dec 2000 21:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131114AbQLZCvW>; Mon, 25 Dec 2000 21:51:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4626 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131016AbQLZCvJ>; Mon, 25 Dec 2000 21:51:09 -0500
Date: Mon, 25 Dec 2000 18:20:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Marco d'Itri" <md@Linux.IT>
cc: linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001225194406.A1242@wonderland.linux.it>
Message-ID: <Pine.LNX.4.10.10012251818260.6807-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Dec 2000, Marco d'Itri wrote:
>
>  >Do you get any messages? I don't think you will, but it should be tested.
>
> I read you found the real cause so that may be bogus, but I have got two
> messages while booting. The first showed up while doing the fsck of a 6
> GB file systems and killed the process (fscks of smaller partitions
> completed successfully), the second occured while initializing
> /dev/random and left an unkillable dd process and a stuck boot process
> (I gathered this info with sysrq).

I'd still love to get the trace for these. I think I have a handle on the
problems, but it would stil be helpful - dropping a dirty page really
shouldn't happen except for the swap cache (and that should have been
plugged by adding the ClearPageDirty()).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
