Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTIVWGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTIVWGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:06:52 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:33541 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261872AbTIVWGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:06:49 -0400
Date: Tue, 23 Sep 2003 00:06:47 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Landley <rob@landley.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030923000647.A1128@pclin040.win.tue.nl>
References: <200309201633.22414.rob@landley.net> <20030921100436.GA18409@ucw.cz> <200309221506.08331.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309221506.08331.rob@landley.net>; from rob@landley.net on Mon, Sep 22, 2003 at 03:06:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 03:06:08PM -0500, Rob Landley wrote:

> Here's a cut and paste from a tail of /var/log/messages:
> 
> Sep 22 14:12:26 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x94, 
> on isa0060/serio0) pressed.
> Sep 22 14:12:26 localhost kernel: i8042 history: 18 98 18 98 26 a6 39 b9 1f 9f 
> 15 1f 95 9f 12 94

ool sys e <t release>

> Sep 22 14:22:05 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xa6, 
> on isa0060/serio0) pressed.
> Sep 22 14:22:05 localhost kernel: i8042 history: 94 15 95 39 14 b9 18 94 98 39 
> b9 23 12 a3 92 a6

y to he <l release>

>From "try to help"? The l press was lost.

> Sep 22 14:39:06 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1cb, 
> on isa0060/serio0) pressed.
> Sep 22 14:39:06 localhost kernel: i8042 history: cb e0 4b e0 cb e0 4b e0 cb e0 
> 4b e0 cb 4b e0 cb

[Left] [Left] [Left] KP-4 <[Left] release>

This is a rather clear one. You press the grey [Left] key four times.
It has make code e0 4b and break code e0 cb.
Three times we get e0 4b e0 cb but once we get 4b e0 cb.
Surely, the e0 was lost here.

> Sep 22 14:58:05 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
> on isa0060/serio0) pressed.
> Sep 22 14:58:05 localhost kernel: i8042 history: 1c 90 9c e0 48 e0 c8 23 0f a3 
> 8f 1c 9c 50 e0 d0

[Enter] [Up] h [Tab] [Enter] KP-2 <[Down] release>

Rather similar. The e0 part of e0 50 was lost.

> Sep 22 14:59:46 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xb1, 
> on isa0060/serio0) pressed.
> Sep 22 14:59:46 localhost kernel: i8042 history: 2d ad 2d ad 17 97 19 99 1e 15 
> 9e 95 17 97 22 b1

xxipayig <n release>

You were typing "paying" but the n press was not seen.

> Any clues?  (This happens to me at least once an hour...)

Some people have been reporting missing key releases (maybe also you),
but these are all missing key presses. It is easiest to blame the
keyboard, even though I could imagine ways to blame the kernel.

What about 2.4? Do you have to go back once an hour and add a symbol
that was not transmitted correctly? Does 2.4 work perfectly for you?

