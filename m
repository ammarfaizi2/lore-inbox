Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbTFWQQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbTFWQQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:16:56 -0400
Received: from quechua.inka.de ([193.197.184.2]:30425 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264939AbTFWQPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:15:33 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Organization: nobody home
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Date: Mon, 23 Jun 2003 18:30:43 +0200
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Message-Id: <pan.2003.06.23.16.30.42.431561@dungeon.inka.de>
References: <m2smqhqk4k.fsf@p4.localdomain> <20030615001905.A27084@ucw.cz> <m2he6rv8i6.fsf@telia.com> <20030615142838.A3291@ucw.cz> <m2of0zqr4i.fsf@telia.com> <20030615192731.A6972@ucw.cz> <m2d6hbgdhw.fsf@telia.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003 23:44:45 +0000, Peter Osterlund wrote:
> I have modified the X driver now, so that it doesn't depend on packets
> arriving one second after the last event, and so that it uses wall
> clock time instead of counting packets. This version therefore works
> with an unpatched 2.5.72 kernel. It is available here:
> 
>         http://w1.894.telia.com/~u89404340/touchpad/index.html

Hi,

I tried that driver with 2.5.73. The synaptics option is gone, so it is
always on by default? No way to turn it off?

My XF86Config-4 is:

Section "InputDevice"
        Identifier  "Mouse1"
        Driver      "synaptics"
        Option      "Protocol" "event"
        Option      "Device" "/dev/input/event1"
        Option      "Emulate3Buttons" "on"
EndSection

it's debian unstable and hardware is a dell latitude c600 laptop.

the trackpoint (or how it is called?) does not work: nothing happends.
The touchpad is working ok, but the mouse is moving either slow or too
fast. I guess there is a way I can configure that?

a bigger problem is: X froze once, but I could login via network and
kill -9 it. No idea why, there is nothing special in the log file.


kernel messages:
mice: PS/2 mouse device common for all mice
input: PC Speaker
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firware: 5.5
 180 degree mounted touchpad
 Sensor: 27
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12

xfree log:

(II) LoadModule: "synaptics"
(II) Loading /usr/X11R6/lib/modules/input/synaptics_drv.o
(II) Module synaptics: vendor="The XFree86 Project"
        compiled for 4.2.0, module version = 1.0.0
        Module class: XFree86 XInput Driver
        ABI class: XFree86 XInput driver, version 0.3
...
(**) Option "Device" "/dev/input/event1"
(II) xfree driver for the synaptics touchpad 0.11.3p3
(**) Option "CorePointer"
(**) Mouse1: Core Pointer
(II) Keyboard "Keyboard0" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse1" (type: MOUSE)
Synaptics DeviceInit called
SynapticsCtrl called.
Synaptics DeviceOn called
(II) xfree driver for the synaptics touchpad 0.11.3p3
Could not init font path element /usr/X11R6/lib/X11/fonts/Speedo/, removing from
 list!
Could not init font path element /usr/X11R6/lib/X11/fonts/Type1/, removing from 
list!
SynapticsCtrl called.

so far it's working fine.

btw: I'm used to tip twice on the touchpad to get a left click. 
That doesn't work anymore (I might have stopped a few kernel or 
xfree versions before). Is there a way to enable that again?

Thanks. Regards, Andreas

