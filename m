Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270516AbRHHQJk>; Wed, 8 Aug 2001 12:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270517AbRHHQJa>; Wed, 8 Aug 2001 12:09:30 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:23560 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S270516AbRHHQJT>; Wed, 8 Aug 2001 12:09:19 -0400
Date: Wed, 8 Aug 2001 18:09:24 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Via chipset
In-Reply-To: <20010807164740.U23718@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0108081534180.1282-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Larry McVoy wrote:

> This is a reoccurring question on this (and many other) list[s].  It seems
> like someone ought to maintain a database of boards that are known to work
> and what they are used for.  For example,  lots of people say "such and such
> works for me" but what they don't say is "I only have 1 disk and 1 CDROM and
> nothing else".
>
> I've had fairly good luck with just about any board as long as I don't
> beat on the IDE on a VIA chipset board.  I switched all my servers over
> to 3ware Escalades to get off the IDE; that helped tremendously but it
> adds about $400 to a system (3ware card and you will probably want a
> better PS and cooling, so maybe more).
>
> Yeah, I know, if I'm whining I should volunteer the space.  OK, I'll do the
> following: if someone starts gathering the data in a simple way (see below)
> then I'll archive it all in a database and make it accessible via the web.
> If you are interested in doing this, which means you write the script that
> gathers the info, contact me offline and we'll set it up.
>
> The data format I want is simple.  Imagine a perl script gathering the
> info into an associative array, the key is the field name like "cpu" or
> "motherboard" etc., and the value is the value, like "AMD K7" or "ASUS A7V".
> It would be good to have a set of required fields so people can query
> across those fields, but there need not be any limit on how many fields and
> all fields need not be present in all records.
>
> Once you have that, I can send you some code that will shlep over that data
> to me and I have tools here that will eat it and store it into a database.
> Our bugdatabase is lot like this, it's a fairly trivial change to support
> this as a sort of bugdatabase like thing.
>

First, we need to filter out unrelated info. E.g., I'm happily running
many MSI K7V Pro2-As, all with 1 or 2 fast ATA/100 disks (IBM DTLA-307030),
SW RAID 0 or 1 for dual disks systems. Never seen any problem, but
those are all Red Hat 6.2 with Red Hat's latest kernel (2.2.19-something).
I doubt this info is useful at all.

We should create a checklist of requirements an user has to meet to
provide useful info, e.g.:

- what kernel version(s) to test, what compile options to set/unset;
- what subsystems to test (e.g. IDE driver?), how, and also how to check
  that the test conditions are ok (DMA really enabled, and so on);
- what type of problems to look for (data corruption, OOPSes, ...).

Otherwise, you could receive a lot of works-for-me reports, most useless.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

