Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRAHX2D>; Mon, 8 Jan 2001 18:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130330AbRAHX1x>; Mon, 8 Jan 2001 18:27:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34569 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129752AbRAHX1r>; Mon, 8 Jan 2001 18:27:47 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: `rmdir .` doesn't work in 2.4
Date: 8 Jan 2001 15:27:21 -0800
Organization: Transmeta Corporation
Message-ID: <93dicp$ano$1@penguin.transmeta.com>
In-Reply-To: <20010108185518.G27646@athlon.random> <Pine.GSO.4.21.0101081259230.4061-100000@weyl.math.psu.edu> <20010108213036.T27646@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010108213036.T27646@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>On Mon, Jan 08, 2001 at 01:04:24PM -0500, Alexander Viro wrote:
>> Racy. Nonportable. Has portable and simple equivalent. Again, don't
>> bother with chdir at all - if you know the name of directory even
>> ../name will work. It's not about the current directory. It's about
>> the invalid last component of the name.
>
>The last component of the name isn't invalid, it's a plain valid directory. If
>according to you `rmdir ../name` and rmdir `pwd` makes sense  then according to
>me `rmdir .` makes perfect sense too.

It makes perfect sense, and Linux used to accept it during the 2.3.x
timeframe.

However, it is against all UNIX standards, and Linux-2.4 will explicitly
not allow it (there's also some parent locking issues there).

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
