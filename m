Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130031AbRAIN0D>; Tue, 9 Jan 2001 08:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRAINZx>; Tue, 9 Jan 2001 08:25:53 -0500
Received: from chiara.elte.hu ([157.181.150.200]:8460 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130031AbRAINZq>;
	Tue, 9 Jan 2001 08:25:46 -0500
Date: Tue, 9 Jan 2001 14:24:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Stephen Landamore <stephenl@zeus.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.10.10101091301170.18208-100000@phaedra.cam.zeus.com>
Message-ID: <Pine.LNX.4.30.0101091418300.3375-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Stephen Landamore wrote:

> >> Sure.  But sendfile is not one of the fundamental UNIX operations...

> > Neither were eg. kernel-based semaphores. So what? Unix wasnt

> Ehh, that's not correct. HP-UX was the first to implement sendfile().

i dont think we disagree. What i was referring to was the 'original' Unix
idea, the 30 years old one, which did not include sendfile() :-) We never
claimed that sendfile() first came up in Linux [that would be a blatant
lie] - and the Linux API itself was indeed influenced by existing
sendfile()/copyfile() interfaces. (at the time Linus implemented
sendfile() there already existed several similar interfaces.)

> For the record, sendfile() exists because we (Zeus) asked HP for it.

good move :-) [honestly.]

> (So of course we agree that sendfile is important!)

:-) I think sendfile() should also have its logical extensions:
receivefile(). I dont know how the HPUX implementation works, but in
Linux, right now it's only possible to sendfile() from a file to a socket.
The logical extension of this is to allow socket->file IO and file->file,
socket->socket IO as well. (the later one could be interesting for things
like web proxies.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
