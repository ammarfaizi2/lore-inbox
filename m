Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbREYVTZ>; Fri, 25 May 2001 17:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbREYVTQ>; Fri, 25 May 2001 17:19:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:26897 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261916AbREYVTK>; Fri, 25 May 2001 17:19:10 -0400
Date: Fri, 25 May 2001 14:18:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: DVD blockdevice buffers
In-Reply-To: <m166epgmtc.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.31.0105251417070.7867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 May 2001, Eric W. Biederman wrote:
>
> I obviously picked a bad name, and a bad place to start.
> int data_uptodate(struct page *page, unsigned offset, unsigned len)
>
> This is really an extension to PG_uptodate, not readpage.

Ugh.

The above is just horrible.

It doesn't fix any problems, it is only an ugly work-around for a
situation that never happens in real life. An application that only
re-reads the data that it just wrote itself is a _stupid_ application, and
I'm absolutely not interested in having a new interface that is useless
for everything _but_ such a stupid application.

		Linus

