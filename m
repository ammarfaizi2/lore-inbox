Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbTCIJUo>; Sun, 9 Mar 2003 04:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbTCIJUo>; Sun, 9 Mar 2003 04:20:44 -0500
Received: from AMarseille-201-1-2-231.abo.wanadoo.fr ([193.253.217.231]:12583
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262484AbTCIJUn>; Sun, 9 Mar 2003 04:20:43 -0500
Subject: Re: [patch] oprofile for ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sourceforge.net,
       linuxppc-dev@lists.linuxppc.org, Segher Boessenkool <segher@koffie.nl>,
       o.oppitz@web.de, afleming@motorola.com, linux-kernel@vger.kernel.org
In-Reply-To: <1047151830.2012.149.camel@cube>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
	 <1047032003.12206.5.camel@zion.wanadoo.fr>  <1047061862.1900.67.camel@cube>
	 <1047136206.12202.85.camel@zion.wanadoo.fr>
	 <1047151830.2012.149.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047159672.12202.111.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Mar 2003 22:41:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Bound the alarm clock (decrementer or an alternative)
> setting such that it always fires between 10000 bus
> cycles (safe number?) and 1/4000 second into the future.
> Update jiffies purely based on the timebase register.
> HZ is 1000. This ought to help with high-res timers.

As I told you, current ppc timer.c should already bind on
timebase and so be safe with increased DEC irq frequency.

> If that special page at the top of user-space got
> implemented (did it?), supply timebase frequency and
> offset info there for non-SMP systems. (and for SMP
> too if somebody cares to count the 60x/MPX bus cycles
> involved in synchronizing timebase registers)

I don't think it is on PPC, though I'm still thinking about
it to also provide userspace with some stuff like atomic ops
etc... so that CPU specific workarounds like additional
sync's on 405gp can be left out of glibc.

I'll look for more detailed infos about the G4 bug, possibly
tomorrow or next week.

Ben.

