Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSFJGBl>; Mon, 10 Jun 2002 02:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSFJGBk>; Mon, 10 Jun 2002 02:01:40 -0400
Received: from mark.mielke.cc ([216.209.85.42]:54029 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316677AbSFJGBj>;
	Mon, 10 Jun 2002 02:01:39 -0400
Date: Mon, 10 Jun 2002 01:55:42 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
Message-ID: <20020610015542.B18388@mark.mielke.cc>
In-Reply-To: <3D029DAF.5040006@candelatech.com> <20020608.175108.84748597.davem@redhat.com> <3D039D22.2010805@candelatech.com> <20020609.213440.04716391.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 09:34:40PM -0700, David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Sun, 09 Jun 2002 11:23:30 -0700
>    I need to account for packets on a per-session basis, where a
>    session endpoint is a UDP port.  So, knowing global protocol numbers is
>    good, but it is not very useful for the detailed accounting I
>    need.
> Why can't you just disable the other UDP services, and then there is
> no question which UDP server/client is causing the drops.

If the application only had 10 or fewer, non-critical UDP ports
sending data, this conclusion might apply. However, even then, this
suggestions seems a little silly. "Why don't you call for a full stop
and then try them one by one?" is what I read this suggestion as
being.

> Every argument I hear is one out of lazyness.  And that is not a
> reason to add something.  Simply put, I don't want to add all of this
> per-socket counter bumping that only, at best, 1 tenth of 1 percent
> of people will use.  This means that the rest of the world eats the
> overhead just for this small group that actually uses it.

Is it 'laziness' that the application needs to be able to minimize every
last CPU cycle, or is it 'optimization'?

To many designers, the determination that one should *be* lazy is
considered a virtue. The opposite extreme would suggest that "well
TCP/IP shouldn't be built into the kernel anyways... application
writers are just too lazy to implement the TCP/IP stack in user
space... it doesn't belong in the kernel..."

As for the "rest of the world eats the overhead just for this small group
that actually uses it"... this would be true... if every single Linux
kernel was built with the exact same configuration.

What am I saying? I haven't seen an effective argument against the
requirement, and I can see potential uses *for* the requirement.

Feel free to provide an effective argument against. :-)

Until then...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

