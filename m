Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRGWWzN>; Mon, 23 Jul 2001 18:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGWWzD>; Mon, 23 Jul 2001 18:55:03 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:47119 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264329AbRGWWy5>; Mon, 23 Jul 2001 18:54:57 -0400
Date: Mon, 23 Jul 2001 15:53:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <3B5C8C96.FE53F5BA@nortelnetworks.com>
Message-ID: <Pine.LNX.4.33.0107231552000.7916-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 23 Jul 2001, Chris Friesen wrote:
>
> If I understand correctly, xtime is updated asynchronously.  If it isn't, then
> ignore this message totally.  However, if it is, then *not* specifying it as
> volatile could easily cause problems in technically correct but poorly written
> code.

Yes.

Adding "volatile" often helps poorly written code.

In fact, the one AND ONLY reason to add volatile to data structures is in
fact poorly written code.

Now, think about that for a minute, and maybe you'll understand why I
don't want more volatiles in the kernel.

		Linus

PS. This has come up before. The old pre-Alan networking code had
"volatile" on just about every single network data structure. Every damn
single one of them was a bug. Without exception.

