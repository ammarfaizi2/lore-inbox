Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317456AbSFHVLQ>; Sat, 8 Jun 2002 17:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSFHVLP>; Sat, 8 Jun 2002 17:11:15 -0400
Received: from mark.mielke.cc ([216.209.85.42]:780 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317456AbSFHVLO>;
	Sat, 8 Jun 2002 17:11:14 -0400
Date: Sat, 8 Jun 2002 17:05:11 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Ben Greear <greearb@candelatech.com>
Cc: "David S. Miller" <davem@redhat.com>, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
Message-ID: <20020608170511.B26821@mark.mielke.cc>
In-Reply-To: <3CFFB9F8.54455B6E@nortelnetworks.com> <20020606.202108.52904668.davem@redhat.com> <3D01307C.4090503@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2002 at 03:15:24PM -0700, Ben Greear wrote:
> David S. Miller wrote:
> > Your idea is totally useless for non-datagram sockets.
> > Only datagram sockets use the interfaces where you bump
> > the counters.
> > I don't like the patch, nor the idea behind it, at all.
> Datagram sockets are the ones that drop data though (tcp will
> deal with it via re-transmits).

Outside of the specific changes suggested by Chris, I can see a
requirement to be able to detect poor connections. While TCP/IP may
not drop packets from the perspective of user space applications,
TCP/IP packets do get lost. For certain applications that require high
bandwidth, or low latency, applications may be able to optimize code
paths by analyzing statistics related to the socket.

Datagram sockets are more straight forward to implement this for, but
that does not mean that TCP/IP does not have similar potential.

I am not certain what the exact requirement is for in Chris' cases,
but I do know that in his field, he is writing something far more
complicated and resource intensive than a telnet server.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

