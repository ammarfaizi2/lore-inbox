Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUBEGR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 01:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUBEGR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 01:17:29 -0500
Received: from outbound03.telus.net ([199.185.220.222]:61675 "EHLO
	priv-edtnes11-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S261539AbUBEGR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 01:17:27 -0500
Subject: Re: psmouse.c, throwing 3 bytes away
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1075961885.15135.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 04 Feb 2004 23:18:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aha!  So it isn't just me or the mouse getting old!  Ok.  My mouse is a
ps/2 style HP wheel mouse.  I'm running 2.6.2 with Fedora Core (updated
with yum).  I have the same problem as others have described --mouse
goes crazy (usually left/right, not up/down), apps pop open, mouse
pointer moves very fast.  /var/log/messages gives:
Feb  4 20:34:10 localhost kernel: psmouse.c: Wheel Mouse at
isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Feb  4 22:07:12 localhost kernel: psmouse.c: Wheel Mouse at
isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.

After a second or two, the mouse regains it's footing and all is well. 
My mobo is Soyo P4S Dragon Ultra c/w SiS 645 chipset.
Mouse build is:
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

and XF86Config has
(in Section "ServerLayout")
InputDevice    "Mouse0" "CorePointer"
(in Section "InputDevice")
Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Protocol" "IMPS/2"
        Option      "Device" "/dev/psaux"
        Option      "ZAxisMapping" "4 5"
        Option      "Buttons" "3"
        Option      "Resolution" "250"

...and yes...I taint Feisty Dunnart with an NVidia binary for my video. 
The system runs at 1.8GHz and I'm not overclocking.  TIA

Bob

