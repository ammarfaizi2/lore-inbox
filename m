Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUE3Mid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUE3Mid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUE3Mid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:38:33 -0400
Received: from main.gmane.org ([80.91.224.249]:31175 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263429AbUE3Mi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:38:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sun, 30 May 2004 14:38:08 +0200
Message-ID: <MPG.1b23f41bee99410e9896a8@news.gmane.org>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-82-129.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 12:20:32PM +0200, Giuseppe Bilotta wrote:
> > My thoughts are that, even without an event driver interface 
> > for X, it is possible to use the present model provided that 
> > the emulated rawmode provides the widest possible set of 
> > features provided by the union of 'all' available keyboards. 
> > With a (possibly documented) set of keycodes that needs to be 
> > assigned to get this or that function.
> 
> The emulated rawmode unfortunately cannot cover every keyboard out
> there, because of the limitations of the PS/2 protocol, which only can
> transfer about 240 different scancodes.

This is bad.

> The event interface of course doesn't have this limitation.
> 
> > With my limited knowledge (i.e. by what I see looking at the 
> > source files and include headers) I see the kernel lacking in 
> > two fields:
> > 
> > * X allows for the shift, ctrl, alt, meta, super, hyper (left 
> > and right) modifiers. In the kernel headers I only see 
> > references to shift ctrl and alt. (Actually X also has a wild 
> > bunch of other modifiers for group shift, composition etc.)
> 
> The kernel input layer doesn't treat modifiers as special keys, and
> currently (include/linux/input.h) has shift, alt, ctrl and meta keys.
> Both left and right.  This covers all keyboards I've seen so far,
> including SGI, Sun, Mac, and other keyboards.
> 
> This is different from the X keysym modifiers, because the super and
> hyper modifiers usually don't correspond to real physical keys on the
> keyboard.

Sorry but this is untrue. My Win keys are configured as super, 
for example.

> > * No (documented) set of keycodes to assign to get mapped to 
> > multimedia/internet keys (volume up/down, play, stop, next, 
> > prev, email, internet, blah blah blah)
> 
> include/linux/input.h has the documented set of keycodes. It's largely
> based on what 2.4 uses for keycodes - sanitized PS/2 codes.

Ah good. I was looking at the wrong headers :)

> > And I noticed there was this excellent "keyfuzz" utility 
> > recently released which is aimed at providing exactly this 
> > feauture. But it doesn't work as expected. Not yet. Because 
> > keycodes have to be assigned by trial and error and trying to 
> > re-do assignments causes strange effects since scancodes start 
> > shifting as well in a very strange way. Which is why at a 
> > certain point (over a month now) I just gave up and patched 
> > atkbd.c directly to have it work with my keyboard.
> 
> It was written for 2.4 unfortunately, and 2.6's emulated rawmode
> confuses it no end.

It could be updated though.

> The X step could be avoided if we had a definition file for xkb for the
> kernel emulated keyboard.

That's exactly what I'm saying. But there isn't. Which is what 
pisses off most users.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

