Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbSJIKgE>; Wed, 9 Oct 2002 06:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSJIKgE>; Wed, 9 Oct 2002 06:36:04 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:4367 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261639AbSJIKgD>;
	Wed, 9 Oct 2002 06:36:03 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021009082215.C1890@ucw.cz>
References: <20020927091040.B1715@ucw.cz>
	<1033127503.589.6.camel@chevrolet> <20021007150052.A1380@ucw.cz>
	<1034020510.1499.8.camel@chevrolet> <20021007220106.A1640@ucw.cz>
	<1034036449.688.8.camel@chevrolet> <20021008101711.F4290@ucw.cz>
	<1034097546.902.13.camel@chevrolet> <20021008192512.B26021@ucw.cz>
	<1034120899.855.9.camel@chevrolet>  <20021009082215.C1890@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 12:42:12 +0200
Message-Id: <1034160133.629.1.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 2002-10-09 kl. 08:22 skrev Vojtech Pavlik:
> On Wed, Oct 09, 2002 at 01:48:11AM +0200, Stian Jordet wrote:
> > tir, 2002-10-08 kl. 19:25 skrev Vojtech Pavlik:
> > > On Tue, Oct 08, 2002 at 07:18:06PM +0200, Stian Jordet wrote:
> > > > tir, 2002-10-08 kl. 10:17 skrev Vojtech Pavlik:
> > [snip]
> > > > > I really wonder what your keyboard sends for those keys. To avoid the
> > > > > freeze (and rescanning of the keyboard), you should be able to
> > > > > comment-out these lines in atkbd.c:
> > > > > 
> > > > >          case ATKBD_KEY_BAT:
> > > > >                  serio_rescan(atkbd->serio);
> > > > >                  return;
> > > > >  
> > > > It didn't help at all. I just tried 2.5.41 instead of .40, and now I get
> > > > an Oops. Earlier it just froze. Should I write it down?
> > > 
> > > Yes!
> > It won't oops anymore (?) This is really weird, I don't know what I did
> > last night, I was terribly tired, so that must be the reason. .41 and
> > your alt-alt patch, does NOT crash my computer now. No oops, nothing.
> > Attached is a parts of my syslog with debug enabled (and with your
> > alt-alt patch). I logged in, did a echo cut-here >> /var/log/syslog to
> > know what to send you (didn't want everyone at lkml to know my root
> > password, for instance). Then I did this:
> > 
> > Right Shift+Pageup
> > Right Shift+Pageup
> > Right Shift+Pagedown
> > Right Shift+Pagedown
> > Left Shift+Pageup
> > Left Shift+Pageup
> > Left Shift+Pagedown
> > Left Shift+Pagedown
> > Right Shift+Pageup
> > Right Shift+Pageup
> > Right Shift+Pagedown
> > Right Shift+Pagedown
> > Left Shift+Pageup
> > Left Shift+Pageup
> > Left Shift+Pagedown
> > Left Shift+Pagedown
> > 
> > ARROW-UP (to get the echo-line back)
> > ENTER (to make a new mark in syslog).
> > 
> > What I have attached is what is between those cut-here marks.
> > 
> > When I press the right-shift and Page up, I first get unknown scancode
> > 0x1b6. Then, I'll get 0x1aa on every button I press untill I started to
> > press the left-shift instead. After that, the right shift works like it
> > should. I'm totally confused. But I guess you're better reading the logs
> > than I'm. 
> 
> Thanks a lot for helping me here ....
> 
> > Well, as I'm still the only one with the problem, I'm very, very
> > greatful you're taking the time to try to solve this :) Sorry for the
> > delay.
> 
> Actually, Linus was the second who was bitten by it. :) And I managed to
> reproduce it locally yesterday as well, so it's now fixed.
Thank you very, very much. :) It works like a charm now. Maybe I'll get
to sleep the next night :) Great work, and I appreciate that you've been
taking the time sort this out.

Best regards,
Stian Jordet

