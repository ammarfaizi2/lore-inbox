Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbSJGTta>; Mon, 7 Oct 2002 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSJGTta>; Mon, 7 Oct 2002 15:49:30 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:64006 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S262669AbSJGTt2>;
	Mon, 7 Oct 2002 15:49:28 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007150052.A1380@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet>
	<20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet>
	<20020926133725.A8851@ucw.cz> <1033054211.587.6.camel@chevrolet>
	<20020926185717.B27676@ucw.cz> <1033080648.593.12.camel@chevrolet>
	<20020927091040.B1715@ucw.cz> <1033127503.589.6.camel@chevrolet> 
	<20021007150052.A1380@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Oct 2002 21:55:10 +0200
Message-Id: <1034020510.1499.8.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 2002-10-07 kl. 15:00 skrev Vojtech Pavlik:
> On Fri, Sep 27, 2002 at 01:51:43PM +0200, Stian Jordet wrote:
> > fre, 2002-09-27 kl. 09:10 skrev Vojtech Pavlik:
> > > Unfortunately the little bit of information I needed scrolled away
> > > already. Can you try with the other shift (right?)? That won't
> > > probably crash your machine, but will most likely generate an "Unknown
> > > scancode" message. Again, send me the log lines. This time they should
> > > make it in the syslog well.
> > Ok, the combination which freezes the computer is right SHIFT, and
> > pageup/down, etc. Left SHIFT works just like expected. This time I first
> > wrote 'cp /var/log/syslog /tmp/syslog', then 'echo cut-here >
> > /var/log/syslog' Left-SHIFT+PAGEUP, arrow up two times, to get the cp..,
> > enter. Then I edited /tmp/syslog and copied only what was after
> > "cut-here". So the keystrokes included here should be Left-SHIFT+PAGEUP,
> > ARROW-UP, ARROW-UP, ENTER. If this works like I think it should. As you
> > can see, it did not generate an "Unknown scancode"...
> 
> Can you test whether the attached patch helps?

I was starting to think you had forgot me :)

The patch helped a lot. Now it doesn't crash at all. But when I use
RIGHT-ALT+PAGE-UP, I get these errors a couple of times, then it
suddenly works as it should.

atkbd.c: Unknown key (set 2, scancode 0x1b6, on isa0060/serio0) pressed.
input: AT Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key (set 2, scancode 0x1c9, on isa0060/serio0) pressed.
input: AT Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key (set 2, scancode 0x1c9, on isa0060/serio0) pressed.
input: AT Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key (set 2, scancode 0x1c9, on isa0060/serio0) pressed.
input: AT Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key (set 2, scancode 0x1c9, on isa0060/serio0) pressed.
input: AT Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key (set 2, scancode 0x1c9, on isa0060/serio0) pressed.
input: AT Set 2 keyboard on isa0060/serio0   
atkbd.c: Unknown key (set 2, scancode 0x1c9, on isa0060/serio0) pressed.

I think the first key is LEFT-SHIFT+PAGE-UP, and the rest the same with
right-shift. Anyway, after those first errors, it works perfect. No
freeze like before. Thanks :) Great work :)

Best regards,
Stian Jordet

