Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTA2PVo>; Wed, 29 Jan 2003 10:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTA2PVo>; Wed, 29 Jan 2003 10:21:44 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:487 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S266228AbTA2PVn>; Wed, 29 Jan 2003 10:21:43 -0500
Date: Wed, 29 Jan 2003 10:31:00 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: Bootscreen [had to throw in 2 cents worth, sorry]
In-reply-to: <200301291448.h0TEmAs18379@Port.imtp.ilyichevsk.odessa.ua>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Balram Adlakha <b_adlakha@softhome.net>, linux-kernel@vger.kernel.org
Reply-to: rwilkens@alumni.clemson.edu
Message-id: <1043854259.877.25.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <200301290318.20817.b_adlakha@softhome.net>
 <200301291448.h0TEmAs18379@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 09:46, Denis Vlasenko wrote:
> Yeah, dude, let's dumb down our users... don't allow them
> to become curious and start learning.

As I recall, the way Windows 95/98/ME operated with the bootscreen (and
this might be wise for Linux as well) is to display a bootscreen, but
have it disappear if someone taps the escape key and returned to the
console where they CAN OPTIONALLY read the messages if their heart
desires.  In Windows 2000/XP, this is no longer, sadly, how it works,
but there still was (I believe) a mode in that OS where it displays all
the boot messages (/SOS option or similar).

In Novell Netware 5, which uses X-Windows incidentally (I believe), the
way out of the bootscreen was alt-escape if you wanted to switch over to
the boot console, IIRC.

The answer is that there is nothing they should have to see in the boot
messages that is useful to the end users unless an error occurs.  Even
if there is, the boot messages do and should scroll by too quickly to be
meaningful.

It's not called dumbing down users, it's called abstracting the boot
process so that the users don't have to think about it and instead can
think about higher order tasks.

Incidentally, a lot of the init "scripted" startup processes, like
"initializing hotplug system: usb" which stop for several seconds really
should occur in parallel rather than sequentially occuring.  However,
the nature of expecting their output to be plopped onto a text display
almost require them to be serialized.  If they were instead
parallellized, and set up to output to a system log when
failures/succcesses occured, sort of like the windows event log (or the
existing linux dmesg log) the boot process might occur much more
quickly.

Of course, that last paragraph is admittedly off-topic for the lkml,
since the init scripts are not a kernel issue, they are in userland. 
The kernel spawns them, though, so I consider it partially relevant (and
the bootscreen, theoretically would still be displayed as they executed,
so I still consider it relevant to this thread).

-Rob
p.s. I'm hoping this thread is about the possibility of putting some
sort of graphical bootscreen up.  I'm tuning in late, so if I'm on the
wrong page, just ignore me.  Most people on this list have already
filtered me out (plonked me), so you can too.  I won't be offfended.

