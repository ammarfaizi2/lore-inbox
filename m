Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUFJTST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUFJTST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUFJTSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:18:18 -0400
Received: from [217.73.129.129] ([217.73.129.129]:34025 "EHLO
	car.linuxhacker.ru") by vger.kernel.org with ESMTP id S262453AbUFJTQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:16:10 -0400
Date: Thu, 10 Jun 2004 22:15:12 +0300
Message-Id: <200406101915.i5AJFCBu197611@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Toshiba keyboard lockups
To: Fernando.Paredes@sun.com, linux-kernel@vger.kernel.org
References: <40A162BA.90407@sun.com> <200405121149.37334.rjwysocki@sisk.pl> <40C7880C.4000401@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Fernando Paredes <Fernando.Paredes@sun.com> wrote:

FP> Applied these patches. Nothing while tail'ing /var/log/messages. Nothing 
FP> in the root console that I can see either.
FP> Patched the source to 2.6.6. Still get the same lockups, totally random.
FP> Any more ideas?

Not sure if I have exact problem like you do, but at least I have something
similar. Once in a while keyboard suddenly stopps working, touchpad still work
though (I have Toshiba Satellite Pro (centrino based) laptop here).
I figured out that if I leave the keyboard for some time (up to 2 minutes),
it starts to work again, at least this was the case with XFree 4.4,
during those no-keyboard times, mouse cursor was moving with small jumps
(when keyboard works it moves smoothly).
I upgraded to FC2 (and hence to xorg X server) today, and lockup happened
once already, the "wait for some time" strategy did not work, so I
remembered initially I thought this was something bad pressed on keyboard
(btw, usually lockups happens when I press several keys at the same time by
accident (but not always when I do this)), so I was pressing various 
modifier keys and Fn-Fx stuff. (Fn is one key, Fx is set of functional keys).
So today after some waiting I jut pressed alt+ctrl+shifts in some
conbinations and it unfroze almost immediately to my surprise.
Also I can add that sometimes when I press more than one alphanumeric key,
I get this sort of message from kernel:
"atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed."
Also sometimes (not always) after the freeze/unfreeze I get various messages
from atkbd.c, here are some examples:
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
(numbers may differ from time to time)
atkbd.c: Unknown key pressed (translated set 0, code 0x1d on isa0060/serio0).
atkbd.c: Use 'setkeycodes 1d <keycode>' to make it known.
(numbers may differ from time to time voth in keycode and in translated set)
atkbd.c: Unknown key pressed (translated set 0, code 0x22 on isa0060/serio0).
(again numbers may vary)

atkbd.c: Failed to enable keyboard on isa0060/serio0
(this is some ancient message from October 25th, 2004, seen it only once,
just prior to reeboot, according to logs, do not remember details).

And also I often see multiple
"input: AT Translated Set 2 keyboard on isa0060/serio0" messages.
And new ones are appearing after the freeze/unfreeze. (not every time, though).

May be that will help someone.

Bye,
    Oleg
