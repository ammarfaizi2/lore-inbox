Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbTFZKbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTFZKbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:31:37 -0400
Received: from arm.t19.ds.pwr.wroc.pl ([156.17.236.105]:52234 "EHLO misie.k.pl")
	by vger.kernel.org with ESMTP id S265530AbTFZKbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:31:35 -0400
Date: Thu, 26 Jun 2003 12:45:46 +0200
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Synaptics support kills my mouse
Message-ID: <20030626104546.GA12096@arm.t19.ds.pwr.wroc.pl>
References: <Pine.LNX.4.44.0306251857390.921-100000@lap.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0306251857390.921-100000@lap.molina>
User-Agent: Mutt/1.4.1i
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/
X-Operating-System: Linux dark 4.0.20 #119 czw cze 26 12:34:29 CEST 2003 i986 pld
Organization: Self Organizing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On/Dnia Wed, Jun 25, 2003 at 07:06:40PM -0600, Thomas Molina wrote/napisa³(a)
> I realized I forgot to include some useful information.  Following are the 
> relevant boot messages.  It appears to correctly detect my touchpad but 
> doesn't give me a mouse cursor, even in text consoles.
> 
> Jun 25 18:41:26 lap kernel: mice: PS/2 mouse device common for all mice
> Jun 25 18:41:26 lap kernel: Synaptics Touchpad, model: 1
> Jun 25 18:41:26 lap kernel:  Firware: 4.6
> Jun 25 18:41:26 lap kernel:  Sensor: 15
> Jun 25 18:41:26 lap kernel:  new absolute packet format
> Jun 25 18:41:26 lap kernel:  Touchpad has extended capability bits
> Jun 25 18:41:26 lap kernel:  -> four buttons
> Jun 25 18:41:26 lap kernel:  -> multifinger detection
> Jun 25 18:41:26 lap kernel:  -> palm detection
> Jun 25 18:41:26 lap kernel: input: Synaptics Synaptics TouchPad on 
> isa0060/serio1

I have the same problem. I'm using MaxData Mbook 1000T which has
synaptics touchpad too and it stopped working in .72 and still doesn't
work in .73 :-(

Synaptics Touchpad, model: 1
 Firware: 4.1
 Sensor: 8
 new absolute packet format
input: Synaptics Synaptics TouchPad on isa0060/serio2
mice: PS/2 mouse device common for all mice

I tried to use XFree86 4.3.99.6 with
http://w1.894.telia.com/~u89404340/touchpad/ driver but that doesn't
work either:
(**) Option "Device" "/dev/input/mice"
(**) Option "LeftEdge" "1900"
(**) Option "RightEdge" "5400"
(**) Option "TopEdge" "3900"
(**) Option "BottomEdge" "1800"
(**) Option "MaxTapTime" "15"
(**) Option "MaxTapMove" "220"
(**) Option "VertScrollDelta" "100"
(II) xfree driver for the synaptics touchpad 0.11.3p2
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(II) Keyboard "Keyboard0" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
Synaptics DeviceInit called
SynapticsCtrl called.
Synaptics DeviceOn called
(II) xfree driver for the synaptics touchpad 0.11.3p2
Synaptics DeviceOff called
SynapticsCtrl called.
(--) SAVAGE(0): Chose mode 117 at 85Hz.
Synaptics DeviceOn called
(II) xfree driver for the synaptics touchpad 0.11.3p2
Synaptics DeviceOff called

Doesn't work means that button presses nor touchpad moves are not detected.

btw. which driver provides /dev/input/inputX (as in xfree synaptics
driver documentation) ? I found only /dev/input/eventX driver.

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekmatssedotpl AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
