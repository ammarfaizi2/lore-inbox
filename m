Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbSIWWxz>; Mon, 23 Sep 2002 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbSIWWxy>; Mon, 23 Sep 2002 18:53:54 -0400
Received: from mark.mielke.cc ([216.209.85.42]:50950 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261466AbSIWWxy>;
	Mon, 23 Sep 2002 18:53:54 -0400
Date: Mon, 23 Sep 2002 18:56:35 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923185635.C26887@mark.mielke.cc>
References: <20020923083004.B14944@work.bitmover.com> <Pine.LNX.4.44.0209231433560.16864-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209231433560.16864-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Mon, Sep 23, 2002 at 02:41:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 02:41:33PM -0700, dean gaudet wrote:
> so while this is I/O, it's certainly less efficient to have thousands of
> tasks blocked in read(2) versus having thousands of entries in <pick your
> favourite poll/select/etc. mechanism>.

In terms of kernel memory, perhaps. In terms of 'efficiency', I
wouldn't be so sure. Java uses a wack of user space storage to
represent threads regardless of whether they are green or native.  The
only difference is - is Java calling poll()/select()/ioctl()
routinely? Or are the tasks sitting in an efficient kernel task queue?

Which has a better chance of being more efficient, in terms of dispatching,
(especially considering that most of the time, most java threads are idle),
and which has a better chance of being more efficient in terms of the
overhead of querying whether a task is ready to run? I lean towards the OS
on both counts.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

