Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRAPRsk>; Tue, 16 Jan 2001 12:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbRAPRsb>; Tue, 16 Jan 2001 12:48:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11786 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129706AbRAPRsW>; Tue, 16 Jan 2001 12:48:22 -0500
Date: Tue, 16 Jan 2001 09:47:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
In-Reply-To: <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>
Message-ID: <Pine.LNX.4.10.10101160944210.13786-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jan 2001, Ingo Molnar wrote:
> 
> yep, correct. But take a look at the trick it does with file descriptors,
> i believe it could be a useful way of doing things. It basically
> privatizes a struct file, without inserting it into the enumerated file
> descriptors. This shows that 'native files' are possible: file struct
> without file descriptor integers mapped to them.

That's nothing new: the exec() code does exactly the same.

In fact, there's a function for it: filp_open() and filp_close(). Which do
a better job of it than your private implementation did, I suspect.

I don't think your object fingerprints are anything more generic than the
current file descriptors.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
