Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S156859AbQGQVdJ>; Mon, 17 Jul 2000 17:33:09 -0400
Received: by vger.rutgers.edu id <S157147AbQGQVct>; Mon, 17 Jul 2000 17:32:49 -0400
Received: from mail.turbolinux.com ([38.170.88.25]:2579 "EHLO mail.turbolinux.com") by vger.rutgers.edu with ESMTP id <S156424AbQGQVc3>; Mon, 17 Jul 2000 17:32:29 -0400
Date: Mon, 17 Jul 2000 14:45:20 -0700 (PDT)
From: "Matt D. Robinson" <yakker@turbolinux.com>
To: Josh Huber <huber@mclinux.com>
Cc: almesber@lrc.di.epfl.ch, Tigran Aivazian <tigran@veritas.com>, Matt Robinson <yakker@turbolinux.com>, lkcd@oss.sgi.com, linux-kernel@vger.rutgers.edu
Subject: Re: dump device
In-Reply-To: <20000706114407.A820@mclx.com>
Message-ID: <Pine.LNX.4.21.0007171438530.24428-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 6 Jul 2000, Josh Huber wrote:
|>On Tue, Jul 04, 2000 at 09:23:39AM +0200, almesber@lrc.di.epfl.ch wrote:
|>> > http://www.missioncriticallinux.com/technology/coredump/
|>> 
|>> This is roughly the concept that we've discussed. I didn't look at their
|>> current implementation, so there may be some differences. (My current
|>
|>This isn't how our current implementation works.  Originally, we used a
|>disk-based system that wrote the dump to a swap partition.
|>
|>Currently we're using an in-memory system that saves the dump in a
|>compressed form to memory, reboots the system (using bootimg on Intel), and
|>writes it to disk on boot via a init script.
|>
|>This system is working well -- the only issues we're having is with SMP and
|>video on Intel.

I'd recommend looking at LKCD (Linux Kernel Crash Dumps).  We are currently
finishing up the 2.3/2.4 port (which will work on devices that support
kiobufs, and will be a loadable module, and might end up being backported
to 2.2 at this stage).  You can get the latest code base from the CVS tree:

	https://sourceforge.net/cvs/?group_id=2726

... the base SourceForge LKCD effort is found at:

	https://sourceforge.net/projects/lkcd/

... and the main web page for LKCD is at:

	http://oss.sgi.com/projects/lkcd/

We're also trying to finish up an Alpha port, and we're working on an
IA64 version.  If you have any questions about this effort, send me an
E-mail, and I'll be glad to help out.

--Matt

P.S.  I'll try to release a patch in the next couple of days ... it'll
      be against 2.3.99-pre9 for now ...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
