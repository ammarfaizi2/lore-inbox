Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSKOFOc>; Fri, 15 Nov 2002 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSKOFOb>; Fri, 15 Nov 2002 00:14:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6381 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265798AbSKOFOa>;
	Fri, 15 Nov 2002 00:14:30 -0500
Date: Thu, 14 Nov 2002 21:20:33 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Corey Minyard <cminyard@mvista.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       John Levon <levon@movementarian.org>,
       Dipankar Sarma <dipankar@gamebox.net>, <linux-kernel@vger.kernel.org>
Subject: Re: NMI handling rework for x86
In-Reply-To: <3DD47858.3060404@mvista.com>
Message-ID: <Pine.LNX.4.33L2.0211142118510.4777-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Corey Minyard wrote:

| Linus,
|
| John Levon suggested I send this to you.  It's a cleanup of the NMI
| handling to make it into a request/release mechanism (instead of
| hard-coding everything into traps.c).  It renames "nmi.c" to
| "nmi_watchdog.c" (as it should be named) and moves the real NMI handling
| code from traps.c to nmi.c.  It's been posted and reworked on lkml, and
| it seems to have finally met approval.  The "cc-ed" people have reviewed
| the patch (or at least made helpful suggestions :-).
|
| Since a lot of things are hacking into this code (lkcd, kdb, oprofile,
| nmi watchdog, and now my IPMI watchdog pretimeout), it would be very
| nice to get their junk out of this code and allow them to bind in
| nicely, and allow binding from modules.

Switching topics:
Where is the watchdog pretimeout interface ("API") defined?
Has there been any discussion of it?

| (And this time it's a -p1 diff)

Looks like a -p0 diff to me.

-- 
~Randy

