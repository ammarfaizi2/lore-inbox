Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSJ2FDo>; Tue, 29 Oct 2002 00:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJ2FDo>; Tue, 29 Oct 2002 00:03:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:50575 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261557AbSJ2FDn>;
	Tue, 29 Oct 2002 00:03:43 -0500
Message-ID: <3DBE1824.B3D84E9F@digeo.com>
Date: Mon, 28 Oct 2002 21:09:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: torvalds@transmeta.com, Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, ahu@ds9a.nl
Subject: Re: [PATCH] Updated sys_epoll now with man pages
References: <Pine.LNX.4.44.0210281844040.966-100000@blue1.dev.mcafeelabs.com> <144220000.1035864069@w-hlinder>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2002 05:09:57.0385 (UTC) FILETIME=[6CA2FF90:01C27F09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> 
>    sys_epoll-2.5.44-last.diff

Folks,

when I took a 15-minute look at this code last week I found several
bugs, some of which were grave.  It's a terrible thing to say, but
a sensible person would expect that a closer inspection would turn
up more problems.

Now, adding bugs to existing code is fine and traditional - people
find them quickly and they get fixed up.

But for *new* code, problems will take months to discover.  The only
practical way to get this code vetted for inclusion is a close review.

And that is a sizeable task.  The core implementation file is
1,600 lines.  And I wonder how many people have counted the
number of comments in there?

Well, I'll make it easy: zero.  Nil.  Nada.

(Well, OK, a copyright header, and something which got cut-n-pasted
from inode.c)

In my wildly unconventional opinion this alone makes epoll just a hack,
of insufficient quality for inclusion in Linux.  We *have* to stop doing
this to ourselves!


epoll seems to be a good and desirable thing.  To move forward I
believe we need to get this code reviewed, and documented.

I can do that if you like; it will take me several weeks to get onto
it.  But until that is completed I would oppose inclusion of this
code.
