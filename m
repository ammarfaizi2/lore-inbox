Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSIWViG>; Mon, 23 Sep 2002 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSIWVhM>; Mon, 23 Sep 2002 17:37:12 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:43459 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S261404AbSIWVgW>; Mon, 23 Sep 2002 17:36:22 -0400
Date: Mon, 23 Sep 2002 14:41:33 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Larry McVoy <lm@bitmover.com>
cc: Bill Davidsen <davidsen@tmr.com>, Peter Waechtler <pwaechtler@mac.com>,
       <linux-kernel@vger.kernel.org>, ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020923083004.B14944@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0209231433560.16864-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Larry McVoy wrote:

> What do you think causes a context switch in
> a threaded program?  What?  Could it be blocking on I/O?

unfortunately java was originally designed with a thread-per-connection
model as the *only* method of implementing servers.  there wasn't a
non-blocking network API ... and i hear that such an API is in the works,
but i've no idea where it is yet.

so while this is I/O, it's certainly less efficient to have thousands of
tasks blocked in read(2) versus having thousands of entries in <pick your
favourite poll/select/etc. mechanism>.

this is a java problem though... i posted a jvm straw-man proposal years
ago when IBM posted some "linux threading isn't efficient" paper.  since
java threads are way less painful to implement than pthreads, i suggested
the jvm do the M part of M:N.

-dean

