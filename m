Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbSJFORV>; Sun, 6 Oct 2002 10:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbSJFORU>; Sun, 6 Oct 2002 10:17:20 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:38035 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S261618AbSJFORU>; Sun, 6 Oct 2002 10:17:20 -0400
Message-Id: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Andrew Morton <akpm@digeo.com>, Rob Landley <landley@trommello.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Sun, 6 Oct 2002 15:44:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <3D9F9CD5.CEB61219@digeo.com>
In-Reply-To: <3D9F9CD5.CEB61219@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 October 2002 04:15, Andrew Morton wrote:
> Rob Landley wrote:
> > And the work that matters for the desktop is LATENCY work.
>
> 100% true.

Not 100%.
First of all desktop work is driver work. Desktop users tend to get pissed
if their shiny new webcam or DSL does not work.
And thinks like the hotplugging subsystems are essential.
Handling of removable media still is less than optimal.

Then there's the issue of application startup. There's not enough
read ahead. This is especially sad, as the order of page faults is at
least partially predictable.

Another thing that sucks in desktop enviroments is displaying directories.
Asynchronous IO will somewhat help, but you can't do an asynchronous stat.
Now do this while a compiler is running. Deadline IO scheduling will help
but a real helper would be read ahead on directory, inode and multi file 
level.

	Regards
		Oliver
