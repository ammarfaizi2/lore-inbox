Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRAVL7q>; Mon, 22 Jan 2001 06:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRAVL7g>; Mon, 22 Jan 2001 06:59:36 -0500
Received: from [213.221.172.237] ([213.221.172.237]:13326 "EHLO
	smtp-relay2.barrysworld.com") by vger.kernel.org with ESMTP
	id <S130154AbRAVL7T>; Mon, 22 Jan 2001 06:59:19 -0500
Date: Mon, 22 Jan 2001 11:58:26 +0000
From: Scaramanga <scaramanga@barrysworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Firewall netlink question...
Message-ID: <20010122115826.A11297@lemsip.lan>
Reply-To: scaramanga@barrysworld.com
In-Reply-To: <20010122073343.A3839@lemsip.lan> <Pine.LNX.4.21.0101221045380.25503-100000@titan.lahn.de> <20010122102600.A4458@lemsip.lan> <E14Kf9W-0008PJ-00@kabuki.eyep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14Kf9W-0008PJ-00@kabuki.eyep.net>; from daniel@kabuki.eyep.net on Mon, Jan 22, 2001 at 11:28:41 +0000
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This is true. This is called ipqmpd or something similar and written by
> Harald Welte, yes?
> Your best option is to either check out libipq (can be found in the
> directory of the same name in the iptables sources), which provides
> clean C interfaces, or the PERL interface, available from
> http://www.intercode.com.au/jamesm/

Yeah, I think that was the one.


>> What was wrong with the firewall netlink? My re-implementation works great
>> here. I can't see why anything else would be needed, QUEUE seems twice as
>> complex. Unless with QUEUE the userspce applications can make decisions on
>> what to do with the packet? In which case, it would be far too inefficient
>> for an application like mine, where all i need is to be able to read the
>> IP datagrams..
> 
> It can modify and then reinject the packet if it so wishes.

Excellent, I didn't pick up on that, with the cursory glance at the code i took.

I wonder, would there be any interest/point in my NETLINK module, which
provides a backward compatible netlink interface. There are a good few
apps out there which rely on it, and its nice not to have to run a daemon
and install a new library, and re-write them just to continue using them...

--
// Gianni Tedesco <scaramanga@barrysworld.com>
Fingerprint: FECC 237F B895 0379 62C4  B5A9 D83B E2B0 02F3 7A68
Key ID: 02F37A68

egg.microsoft.com: Remote operating system guess: Solaris 2.6 - 2.7

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
