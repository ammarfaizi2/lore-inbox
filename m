Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRAITNQ>; Tue, 9 Jan 2001 14:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131186AbRAITNH>; Tue, 9 Jan 2001 14:13:07 -0500
Received: from anime.net ([63.172.78.150]:16390 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S130766AbRAITMx>;
	Tue, 9 Jan 2001 14:12:53 -0500
Date: Tue, 9 Jan 2001 11:14:05 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Ingo Molnar <mingo@elte.hu>
cc: Stephen Landamore <stephenl@zeus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101091418300.3375-100000@e2>
Message-ID: <Pine.LNX.4.30.0101091110330.2908-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Ingo Molnar wrote:
> :-) I think sendfile() should also have its logical extensions:
> receivefile(). I dont know how the HPUX implementation works, but in
> Linux, right now it's only possible to sendfile() from a file to a socket.
> The logical extension of this is to allow socket->file IO and file->file,
> socket->socket IO as well. (the later one could be interesting for things
> like web proxies.)

Just extend sendfile to allow any fd to any fd. sendfile already does
file->socket and file->file. It only needs to be extended to do
socket->file.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
