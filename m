Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRCCRqd>; Sat, 3 Mar 2001 12:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRCCRq1>; Sat, 3 Mar 2001 12:46:27 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:58842 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129631AbRCCRqH>; Sat, 3 Mar 2001 12:46:07 -0500
Message-ID: <3AA12CD8.7F948E0D@coplanar.net>
Date: Sat, 03 Mar 2001 12:41:44 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Forwarding broadcast traffic
In-Reply-To: <200103031054.KAA29868@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:

> Hello,
>         I have a brain-dead application here which relies on broadcast
> traffic for client/server discovery and I have a question with regard
> to forwarding broadcast traffic.

try bridging instead if ip forwarding.  use netfilter too if you want

>
>
> A small part of my local LAN looks like this:
>
>                  REST OF LAN
>                       |
>                       | (router eth1)
>                       |
>                  masquerading
>                 router (kernel 2.2.14)
>                       |
>                       | (router eth0)
>                       |
>                    desktop (private IP)
>                     boxen  (kernel 2.4.2)
>
> * upgrading the router is not a problem[0].
>
> I wish to have the router forward certain broadcast traffic coming
> from either side out to the other (as well as itself).
>
> e.g. on desktop a broadcast udp packet (with a specified port) needs to
> go not only to itself and the router but also the "REST OF LAN" part
> too - and vice versa. Removing the router is not an option.
>
> I know this isn't a *nice* idea and ordinarily I wouldn't be jumping up
> and down suggesting one throws broadcast traffic around however I need
> to do this for various reasons and the solution appears to be
> non-obvious at least to me[1].
>
> I have considered the idea of creating a transparent bridge however I
> would really rather not do that here for various reasons.
>
> I have posted this message to groups elsewhere however I have not yet
> had any useful responses beyond basic instruction of IP forwarding,
> etc. which is not what I need here :P
>
> Any ideas? I think this one has come up before but I could not find a
> helpful answer in my archives.
>
> Appreciate your time,
>                         --jcm
>
> P.S. My lkml feed at home is great but here it is not so could you
>      please CC me on replies thanks.
>
> [0] Yeah, yeah, I know 2.2.14 is old but it's an old router and when I
>     move that box over to Debian I'll upgrade the kernel at the same
>     time :P
> [1] either due to general stupidity or tiredness, or both.
> -

