Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbTAWUX3>; Thu, 23 Jan 2003 15:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTAWUX3>; Thu, 23 Jan 2003 15:23:29 -0500
Received: from auto-matic.ca ([216.209.85.42]:4112 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S264986AbTAWUX2>;
	Thu, 23 Jan 2003 15:23:28 -0500
Date: Thu, 23 Jan 2003 15:40:56 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <jamie@shareable.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030123204056.GC2490@mark.mielke.cc>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc> <20030123182831.GA8184@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123182831.GA8184@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 06:28:31PM +0000, Jamie Lokier wrote:
> Mark Mielke wrote:
> > Or, fix sys_poll(). With the +1, this means that sys_poll() would have
> > a 1 in 1001 chance per second of returning one jiffie too early.
> Nope.  Read the expression again.

Sorry... not 1 in 1001... almost 100% chance of returning of one
jiffie too many. In practice, even on a relatively idle system,
the process will not be able to wake up as frequently as it might
be able to expect.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

