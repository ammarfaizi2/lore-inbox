Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbTBTRRr>; Thu, 20 Feb 2003 12:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbTBTRQU>; Thu, 20 Feb 2003 12:16:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1803 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266200AbTBTRPd>; Thu, 20 Feb 2003 12:15:33 -0500
Date: Thu, 20 Feb 2003 09:22:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Alex Larsson <alexl@redhat.com>,
       <procps-list@redhat.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <Pine.LNX.4.44.0302201810160.32017-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302200920550.2493-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:
> 
> Al says that this cannot be done sanely, and is fraught with security
> problems. I'd vote for it if it were possible. Al?

I seriously doubt it. It's all exactly the same as the _current_ 
/proc/<pid> stuff, it just shows up in a different place.

> but, if you worry about the scalability of large /proc directories - it's
> not bad at all.

I worry about the _sanity_ of it, and it basically makes no sense to
iterate over every single thread, when you should always be able to just
iterate over processes (and then within the process - only when you want
to - iterate over the threads of _that_ process).

		Linus

