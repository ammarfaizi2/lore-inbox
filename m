Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTIUSy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTIUSy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:54:56 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:65477
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261988AbTIUSyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:54:55 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Keyboard oddness.
Date: Sun, 21 Sep 2003 14:51:39 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200309201633.22414.rob@landley.net> <20030921001838.A3619@pclin040.win.tue.nl>
In-Reply-To: <20030921001838.A3619@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309211451.39180.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 September 2003 18:18, Andries Brouwer wrote:
> On Sat, Sep 20, 2003 at 04:33:22PM -0400, Rob Landley wrote:
> > I've mentioned my keyboard repeat problems before.  I grepped through the
> > logs and found a whole bunch of these type messages:
> >
> > Aug 17 05:28:48 atkbd.c: Unknown key (set 2, scancode 0x1d0,
> > on isa0060/serio0) pressed.
> > Aug 19 09:06:51 atkbd.c: Unknown key (set 2, scancode 0x8e,
> > on isa0060/serio0) pressed.
>
> ...
>
> These are key releases for keys i8042.c didnt know were down.
> If otherwise your keyboard functions well, this is harmless.

It doesn't.  It's missing key release events left and right.  About twice an 
hour a key well get "stuck".  X is okay once you press a second key, but if a 
VT gets a key stuck, it doesn't come back.

> > Sep  2 13:37:52 atkbd.c: Unknown key (set 0, scancode 0xfc,
> > on isa0060/serio1) pressed.
> > Sep  2 13:37:52 atkbd.c: Unknown key (set 0, scancode 0xfc,
> > on isa0060/serio1) pressed.
>
> I suppose these are error codes from your mouse.
> If so, it is a bug that they ever went to atkbd.c.

The mouse sometimes sticks as well, just like the keyboard.  (Click and the 
button is held down for no reason.)

I suspect the bug is actually in the new input core...

> Andries

Rob
