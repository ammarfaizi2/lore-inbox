Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUBQWXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUBQWVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:21:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:16378 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266693AbUBQWNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:13:11 -0500
From: Emmeran Seehuber <rototor@rototor.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Tue, 17 Feb 2004 23:13:38 +0000
User-Agent: KMail/1.6
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200402112344.23378.rototor@rototor.de> <20040216143617.GA959@ucw.cz> <200402170118.05753.dtor_core@ameritech.net>
In-Reply-To: <200402170118.05753.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402172313.39140.rototor@rototor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d84d732d8ddd2281dac05c143a411240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 06:18, Dmitry Torokhov wrote:
[...]
>
> It can't be Pass-through problem as the touchpad is not identified as
> Synaptics, so it must be MUX...
>
> Emmeran, what happens if you "cat /dev/input/mice" and try working the
> touchpad and the trackball? Do you see anything when you use the touchpad?
Yes, when I move the touchpad some output is generated, but not when I move 
the mouse. The same is with /dev/mouse and /dev/psaux.

> If not, please #define DEBUG in i8042.c again and after reboot try using
> touchpad first, then type something (so we'll see the point when you
> stopped using the touchpad), move trackball and type something again and
> post your dmesg one more time. This way we would see if there is anything
> comes out from the touchpad in MUX mode, etc, etc.
>
> And could you please post your /proc/bus/input/devices?
$ cat /proc/bus/input/devices
I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
H: Handlers=kbd
B: EV=40001
B: SND=6

I: Bus=0011 Vendor=0002 Product=0002 Version=0049
N: Name="PS2++ Logitech Mouse"
P: Phys=isa0060/serio2/input0
H: Handlers=mouse0
B: EV=7
B: KEY=f0000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=isa0060/serio4/input0
H: Handlers=mouse1
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd
B: EV=120003
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: LED=7

I: Bus=0003 Vendor=045e Product=0024 Version=0121
N: Name="Microsoft Microsoft Trackball Explorer®"
P: Phys=usb-0000:00:03.2-1/input0
H: Handlers=mouse2
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103

cu,
  Emmy
