Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSCXQ2j>; Sun, 24 Mar 2002 11:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293721AbSCXQ23>; Sun, 24 Mar 2002 11:28:29 -0500
Received: from mark.mielke.cc ([216.209.85.42]:44548 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S293713AbSCXQ2P>;
	Sun, 24 Mar 2002 11:28:15 -0500
Date: Sun, 24 Mar 2002 11:23:36 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Erik Tews <erik.tews@gmx.net>
Cc: "Little, John" <JOHN.LITTLE@okdhs.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: fork() DoS?
Message-ID: <20020324112336.A13562@mark.mielke.cc>
In-Reply-To: <E7B0663E34409F45B77EFDB62AE0E4D2022360BD@s99mail02.okdhs.org> <20020323220903.GA8752@no-maam.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The simplest way would be to limit _SC_CHILD_MAX. _POSIX_CHILD_MAX
looks like it is only 6. Another way would be to introduce a scheduler
which forced process/threads owned by the same uid to combat with each
other for a time slice, and each user be given a fair time slice. (A
little more complicated, but probably doable)

mark


On Sat, Mar 23, 2002 at 11:09:03PM +0100, Erik Tews wrote:
> On Fri, Mar 22, 2002 at 09:16:00AM -0600, Little, John wrote:
> > I'm really not a programmer, just learning, but was able to bring the system
> > to it's knees.  This is a redhat 7.2 kernel.  Is there anyway of preventing
> > this?
> 
> There are some kernel-patches existing which limit the number of allowed
> forks per second. But there is a much shorter way for launching a
> forkbomb:
> 
> :(){ :|:&};:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

