Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbTH3O7G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 10:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTH3O7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 10:59:06 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:59046 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264837AbTH3O7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 10:59:03 -0400
Date: Sat, 30 Aug 2003 16:59:00 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Re:Re: Linux 2.6.0-test4
Message-ID: <20030830145900.GB6862@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030830095858.0895.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830095858.0895.CHRIS@heathens.co.nz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Heath <chris@heathens.co.nz>:
> > I still have issues with the keyboard -- sometimes when typing in the
> > frambuffer console I get an "unknown scancode" and after that the CTRL
> > key is stuck forever, which forces me to reboot.
> 
> Please post the full error message.  Does the error message always
> contain the same scancode?

I'll do that.

Aug 27 18:53:41 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Aug 27 19:15:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
Aug 27 19:42:50 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Aug 28 10:14:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.

Basically, CTRL was stuck. Even when I switched to X11.

> My guess is you can get out of that without a reboot.  Next time it
> happens, try this:
>    1. Press and release each Ctrl key. (This makes sure the key_down
>       array is correct.)
>    2. Switch to another console and back again. (This executes the
>       compute_shiftstate function, which recalculates the shift
>       state from the key_down array.)

Ah, good idea.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
