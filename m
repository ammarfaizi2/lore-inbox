Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130401AbQKGFYT>; Tue, 7 Nov 2000 00:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQKGFYK>; Tue, 7 Nov 2000 00:24:10 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:64780 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130401AbQKGFX6>; Tue, 7 Nov 2000 00:23:58 -0500
Date: Mon, 6 Nov 2000 21:23:57 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of
In-Reply-To: <Pine.LNX.4.10.10011060941070.7955-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011062108291.26647-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Linus Torvalds wrote:

> This is why I'd love to _not_ see silly work-arounds in apache

hey, maybe it's time for me to repeat something that i'm often quoted as
saying:

  apache is about correctness first, and performance second.

i don't think that's silly personally.  remember most websites can be
served fine off an anemic 486/33 with one ethernet port tied behind its
back while doing a three legged race with a 6502 up a hill in san
francisco during el nino.

don't let the benchmarks fool ya!  it's generally more important that a
server be able to fork perl and parse CGIs fast than it is for it to
accept an extra 1000 conns/s.

apache-1.3.15 defines SINGLE_LISTEN_UNSERIALIZED_ACCEPT on linux 2.2 and
later.  dunno when the release date will be... someone go find a security
flaw and it'll push up the release ;)  (p.s. and rbb promised to forward
the change into 2.0 and rse said he'd forward the change into mm, all of
which were based off the same code.)

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
