Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSFJOvV>; Mon, 10 Jun 2002 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSFJOvU>; Mon, 10 Jun 2002 10:51:20 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:15560 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S315437AbSFJOvT>;
	Mon, 10 Jun 2002 10:51:19 -0400
Date: Mon, 10 Jun 2002 10:45:31 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Mark Mielke <mark@mark.mielke.cc>
cc: "David S. Miller" <davem@redhat.com>, <ltd@cisco.com>,
        <greearb@candelatech.com>, <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <20020610095702.A27037@mark.mielke.cc>
Message-ID: <Pine.GSO.4.30.0206101033450.22559-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jun 2002, Mark Mielke wrote:

> On Mon, Jun 10, 2002 at 08:24:44AM -0400, jamal wrote:
> > I think i would agree with Dave for it to be an external patch. You
> > really only need this during debugging. I had a similar patch when
> > debugging NAPI about a year ago. I didnt find it that useful after
> > a while because i could deduce the losses from SNMP/netstat output.
>
> In your case you found that you could solve it once by debugging the
> application.
>
> This doesn't mean that other applications would not be better at
> determining the code path to use at execution time.
>
> Just because eth1 is behaving perfectly (i.e. low overall dropped UDP
> packets, or low TCP/IP retransmission) does not mean that a specific
> socket currently on eth1 heading to China should assume that it can
> take the 'average' observation as adequate for observing the specific
> socket.
>
> There *are* applications that would benefit from making this decision
> at run time on a socket-by-socket basis. It is not a common requirement
> for most desktop users, but it remains a valid requirement.
>

I am confused as to which application needs this, do you have one in mind?
AFAIK, UDP/RTP type apps already know how to determine packet loss
on a per flow basis.

> Providing it as a patch, can have the effect that it becomes more trouble
> than it is worth to grant other people access to the feature, especially
> from a corporate environment that has signed off on being able to release
> patches made to Linux back to the Linux source tree.
>

You may be confusing technical merit to mean the same thing as corporate
donation. In Linux its the later that counts.

> Seems somewhat of a loss...

Your mileage may vary. Consider this - you have the opp to at least
make the patch available. Imagine trying to convince windriver.

cheers,
jamal

>

> mark
>
> --
> mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
> .  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
> |\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   |
> |  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada
>
>   One ring to rule them all, one ring to find them, one ring to bring them all
>                        and in the darkness bind them...
>
>                            http://mark.mielke.cc/
>

