Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSHaXdf>; Sat, 31 Aug 2002 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSHaXdf>; Sat, 31 Aug 2002 19:33:35 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:43538 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S315198AbSHaXdf>; Sat, 31 Aug 2002 19:33:35 -0400
Date: Sat, 31 Aug 2002 18:32:51 -0500 (CDT)
Message-Id: <200208312332.g7VNWpL37633@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Krzysiek.Taraszka@sullivan.realtime.net (dzimi@pld.org.pl)
In-Reply-To: <Pine.LNX.4.44L.0208301938150.24037-200000@ep09.kernel.pl>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Reply-to: linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At Fri Aug 30 2002 - 12:54:37 EST Krzysiek Taraszka (dzimi@pld.org.pl) wrote:
> Great work, but in 2.2.22rc2 powerpc's still broken.
> First of All Sources have got a lot of unsed stuff.
> For example look like that:
> 
> [dzimi@cyborg linux]$ rgrep -n -R '*.*' 'CONFIG_PPC64' . 
...

Doesn't sound like -rc (release canidate) changes.

> Second kernel-2.2.21 still have got time init problems in symbios driver
> on powerpc platform.
> I send to you my ugly hack witch work, but IMHO he's ugly ;) I need to do
> it correct.

> Third, kernel for powerpc boot and work on g3-266 but on g3-333 Ops ...
> (kernel traps, kernel wrote: Caused by SRR1 or somethink like that, in 2.3
> i saw #define FIX_SRR1 macro ...)

Well, SRR1 doesn't cause traps, but it does help tell you why they occurred.
And the FIX_SRR1 stuff isn't the solution either if you look at it closer.
How about a decoded oops?  Also, you didn't say what platform you were using.

As far as the open-pic changes you posted, how about explaining what your
trying to fix (partly hidden by the rename and move to chrp_setup.c from
open_pic.c)?

I see you are wrapping the 8259 checks, but it also refers to a few new
functions/macros I didn't see defined.

How about discussing these problems and patches over at
linuxppc-dev@lists.linuxppc.org ? (I set the reply-to there).

milton
