Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUE3M64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUE3M64 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 08:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUE3M64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 08:58:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59520 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263640AbUE3M6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 08:58:54 -0400
Date: Sun, 30 May 2004 14:59:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040530125918.GA1611@ucw.cz>
References: <20040528154307.142b7abf.akpm@osdl.org> <20040529070953.GB850@ucw.cz> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <MPG.1b23d2eba99fff039896a6@news.gmane.org> <20040530114332.GA1441@ucw.cz> <MPG.1b23f41bee99410e9896a8@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b23f41bee99410e9896a8@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 02:38:08PM +0200, Giuseppe Bilotta wrote:

> > The kernel input layer doesn't treat modifiers as special keys, and
> > currently (include/linux/input.h) has shift, alt, ctrl and meta keys.
> > Both left and right.  This covers all keyboards I've seen so far,
> > including SGI, Sun, Mac, and other keyboards.
> > 
> > This is different from the X keysym modifiers, because the super and
> > hyper modifiers usually don't correspond to real physical keys on the
> > keyboard.
> 
> Sorry but this is untrue. My Win keys are configured as super, 
> for example.

The Linux kernel reports them as KEY_LEFTMETA, KEY_RIGHTMETA and
KEY_COMPOSE.

> > > * No (documented) set of keycodes to assign to get mapped to 
> > > multimedia/internet keys (volume up/down, play, stop, next, 
> > > prev, email, internet, blah blah blah)
> > 
> > include/linux/input.h has the documented set of keycodes. It's largely
> > based on what 2.4 uses for keycodes - sanitized PS/2 codes.
> 
> Ah good. I was looking at the wrong headers :)

> > It was written for 2.4 unfortunately, and 2.6's emulated rawmode
> > confuses it no end.
> 
> It could be updated though.

It can be updated, yes.

> > The X step could be avoided if we had a definition file for xkb for the
> > kernel emulated keyboard.
> 
> That's exactly what I'm saying. But there isn't. Which is what 
> pisses off most users.

I'm not very familiar with xkb configuration. Perhaps you'd be willing
to write that definition file? I'll certainly help you from the kernel
side - I can even generate a list of keycode - scancode - meaning
relations for you.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
