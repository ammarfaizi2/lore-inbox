Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131252AbRANIws>; Sun, 14 Jan 2001 03:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbRANIwi>; Sun, 14 Jan 2001 03:52:38 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:57104 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S131252AbRANIwc>;
	Sun, 14 Jan 2001 03:52:32 -0500
Date: Sun, 14 Jan 2001 09:52:16 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: Harald Welte <laforge@gnumonks.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <20010114093623.M6055@coruscant.gnumonks.org>
Message-ID: <Pine.LNX.4.30.0101140948080.16388-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Jan 13, 2001 at 05:37:01PM +0100, Igmar Palsenberg wrote:
> > Hi,
> >
> > kernel : 2.4.0 vanilla
> > iproute2 version : ss001007
> >
> > After building I've got a few problems :
> >
> > ./ip rule list
> > RTNETLINK answers: Invalid argument
> > Dump terminated
>
> You forgot to set CONFIG_IP_ADVANCED_ROUTER

Nope. Still the same error after that one is set :

CONFIG_IP_ADVANCED_ROUTER=y

[root@base root]# ip rule list
RTNETLINK answers: Invalid argument
Dump terminated

According to net/ipv4/Config.in :

if [ "$CONFIG_IP_ADVANCED_ROUTER" = "y" ]; then
   define_bool CONFIG_RTNETLINK y
   define_bool CONFIG_NETLINK y

CONFIG_IP_ADVANCED_ROUTER just sets those two values, and adapts the
questions. To make sure I just recompiled with Advanced Router turned on,
and still the same error.

I tested the other command of the ip command, and this one is the only one
that gives problems, the others are fine.




	Regards,


		Igmar



-- 

--
Igmar Palsenberg
JDI Media Solutions

Jansplaats 11
6811 GB Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
