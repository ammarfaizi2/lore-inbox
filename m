Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbUAGIwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 03:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUAGIwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 03:52:00 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:60832 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265423AbUAGIvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 03:51:52 -0500
Date: Wed, 7 Jan 2004 09:51:04 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Fredrik Olausson <fredrik@olaussons.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: bad scancode for USB keyboard
Message-ID: <20040107085104.GA14771@ucw.cz>
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net> <3FFB6E9E.6040500@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFB6E9E.6040500@develer.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 03:27:42AM +0100, Bernardo Innocenti wrote:

> >I have the same problem with a Logitech cordless desktop.
> >I can easily change the keycode to generate the right characters when in 
> >console-mode, but XFree gives that key and the Print Screen key the same 
> >keycode.
> >After changing the xmodmap I can get the unmodified character, 
> >but modifiers doesn't work, it just gives me the same character not 
> >matter what modifier I use (shift, alt, alt_gr etc.)
> 
> I had fixed my console keymap too, but I've not been able to
> figure out how to change the X keymap.  I've been looking in
> the /usr/X11R6/lib/X11/xkb/ directory, but perhaps XKB is not
> being used for old-style keyboard mapping?
> 
> Could you provide detailed instructions?  C coding with missing
> backslash and bar keys is quite hard :-)
> 
> Of course, I still thing its' a 2.6 kernel bug and it should be
> fixed.  Vojtech, do you have an idea why it's happening?

The reason is that this key is not the ordinary backslash-bar key, it's
the so-called 103rd key on some european keyboards. It generates a
different scancode.

2.4 used the same keycode for both the scancodes, 2.6 does not, so that
it's possible to differentiate between the keys on keyboards that have
both this one and also the standard backslash-bar.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
