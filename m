Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132411AbRAIW7r>; Tue, 9 Jan 2001 17:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132414AbRAIW7h>; Tue, 9 Jan 2001 17:59:37 -0500
Received: from chiara.elte.hu ([157.181.150.200]:38412 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132411AbRAIW7b>;
	Tue, 9 Jan 2001 17:59:31 -0500
Date: Tue, 9 Jan 2001 23:59:13 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dan Hollis <goemon@anime.net>
Cc: "David S. Miller" <davem@redhat.com>, <stephenl@zeus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091456160.7153-100000@anime.net>
Message-ID: <Pine.LNX.4.30.0101092358000.9990-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Dan Hollis wrote:

> > This is not what senfile() does, it sends (to a network socket) a
> > file (from the page cache), nothing more.
>
> Ok in any case, it would be nice to have a generic sendfile() which works
> on any fd's - socket or otherwise.

it's a bad name in that case. We dont 'send any file' if we in fact are
receiving a data stream from a socket and writing it into a file :-)

(i think Pavel raised this issue before.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
