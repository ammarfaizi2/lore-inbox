Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTIOIge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTIOIge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:36:34 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:26122 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261702AbTIOIg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:36:28 -0400
Date: Mon, 15 Sep 2003 10:36:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard problems: magic key + h stuck, and keyboard errors,stuck keys with 2.6.0-test5-bk3
Message-ID: <20030915103626.A957@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0309150159030.389-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309150159030.389-100000@coredump.sh0n.net>; from spstarr@sh0n.net on Mon, Sep 15, 2003 at 02:12:21AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 02:12:21AM -0400, Shawn Starr wrote:

> I have two systems, When I turn the system next to me on the machine thats
> currently powered on spews out this each time, why is the magic key
> (alt+sysrq h) being dumped?

No doubt because that is what comes from your keyboard controller.
I do not think this is a Linux matter.
If you want to check, try 2.4 and see that the same happens.

> The other issue is:
> 
> Dec  8 17:56:45: atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> Dec  8 17:56:45: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Feb 12 23:25:29: atkbd.c: Unknown key (set 2, scancode 0xae, on isa0060/serio0) pressed.
> Feb 17 02:09:26: atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> Feb 20 23:06:04: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Feb 22 01:45:55: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Feb 24 18:33:37: atkbd.c: Unknown key (set 2, scancode 0xa0, on isa0060/serio0) pressed.
> Feb 27 00:09:52: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Mar  5 00:49:59: atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> Mar  5 00:49:59: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> ..........................
> 
> Sep  1 23:38:58: atkbd.c: Unknown key (set 2, scancode 0xc0, on isa0060/serio0) pressed.
> Sep  1 23:38:59: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Sep  1 23:39:04: atkbd.c: Unknown key (set 2, scancode 0xc0, on isa0060/serio0) pressed.
> Sep  1 23:39:35: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Sep 10 20:25:57: atkbd.c: Unknown key (set 2, scancode 0xa0, on isa0060/serio0) pressed.
> Sep 10 21:50:22: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Sep 11 22:57:07: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> Sep 13 16:16:24: atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.

These are key up sequences for keys that the kernel did not think were down.
0xb8: LAlt up
0x9d: LCtrl up
0xae: C up
0xa0: D up
0xc0: F6 up
0x9c: Enter up

> I have a small 4 port KVM switch from Startech, Is this KVM causing
> keyboard issues that the keyboard driver cannot interpret properly?

Most KVMs emit some garbage at the moment of switching.

> Why is this occuring so often? I can usually trigger this if I start using
> certain key combinations.
> 
> What also happens is a key will get 'stuck' and then repeat itself until I
> stop it from repeating the letter.

That is the opposite phenomenon: the kernel sees a key down but no key up.

> The keyboard is a Microsoft Internet keyboard PS/2 style plugged into the
> KVM.

I imagine that your problems, apart from the key repeat, are not Linux problems
but hardware problems.

Andries

