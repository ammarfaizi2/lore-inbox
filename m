Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRCCS6h>; Sat, 3 Mar 2001 13:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRCCS61>; Sat, 3 Mar 2001 13:58:27 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:30853 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129664AbRCCS6Y>; Sat, 3 Mar 2001 13:58:24 -0500
Message-ID: <3AA13DC6.D6DA5501@coplanar.net>
Date: Sat, 03 Mar 2001 13:53:58 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Forwarding broadcast traffic
In-Reply-To: <200103031054.KAA29868@localhost.localdomain> <3AA12CD8.7F948E0D@coplanar.net> <3AA138A1.72E99C7C@jonmasters.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:

> Jeremy Jackson wrote:
>
> > try bridging instead if ip forwarding.  use netfilter too if you want
>
> I mentioned bridging before - I don't want some kind of transparent
> bridge, really so what I would need is for the router to be contactable
> in the same way as before and for regular traffic to pass normally but
> with a special arrangement for certain broadcast traffic.
>
> Is it possible to selectively bridge broadcast traffic in the way I have
> described?
>
> Normally of course I'd have the router either being a standard router or
> a bridge but in this case some kind of hybrid arrangement would be
> preferable.
>
> Thanks for your help,
>                         --jcm

Well it you give the server an ip alias address that's on the subnet
of the clients, bridge the two segments together,
but use netfilter to drop all packets that aren't your
broadcasts, it might do the trick.  I'm not to familiar with
bridging, but i'm confident that 2.4's netfilter can do it...
you can filter/route based on pretty much *any* data
in the packet, by manually specifying an arbitrary offset
in the headers and bit pattern if necessary IIRC.

if you know which port IP port it's easy.

Can you be more specific... is this an IP broadcast?
or ethernet only like IPX or NetBEUI?
perhaps subnetting with "invalid" netmasks could
cause broadcast to reach entire supernet even
though subnets are on diff segments (in case of IP)

