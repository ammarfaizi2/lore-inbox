Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280894AbRKTTZ0>; Tue, 20 Nov 2001 14:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281225AbRKTTZQ>; Tue, 20 Nov 2001 14:25:16 -0500
Received: from chaos.ao.net ([205.244.242.21]:32711 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S280894AbRKTTYz>;
	Tue, 20 Nov 2001 14:24:55 -0500
Message-Id: <200111201924.fAKJOkYR000837@vulpine.ao.net>
To: linux-kernel@vger.kernel.org
cc: joelbeach@optushome.com.au
Subject: Re: Maximum (efficient) partition sizes for various filesystem types...
Date: Tue, 20 Nov 2001 14:24:46 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joel Beach writes:

> I think I'll fix up that bit in the Debian manual myself then if they let
> me....
> 
> For what it's worth, here's the paragraph from the "Woody" installation
> manual:
> 
> "For new users, personal Debian boxes, home systems, and other single-user
> setups, a single / partition (plus swap) is probably the easiest, simplest
> way to go. It is possible to have problems with this idea, though, with
> larger (20GB) disks. Based on limitations in how ext2 works, avoid any
> single partition greater than 6GB or so."

They're right... for home users, with unreliable power or lots of reboots.

when you have to fsck an 18 gig /home partition you really feel it.
One of the reasons all my large drives are running reiserfs now.

And I don't even like to think about how long it takes to check my 56 gig
RAID5 on one server.  Hell, it takes a long time just to mount it read/write
when it's clean!   Thank god for 2-year uptimes.

So yes, the guide is accurate.  And hopefully there will be a reiserfs/ext3
version of the debian install set out in the near future (There's one listed
as "try at your own risk", havn't done it yet.)

(as an aside, woody install is broken: pppoe requires libpcap, which dosn't get
installed initially, so the post-setup fails.  It can be worked around, but
not by newbies.  Lots of vi required)

--Dan

