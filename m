Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUIKAH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUIKAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUIKAH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:07:56 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:29577 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S268040AbUIKAHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:07:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Keyboard and mouse interfere in 2.6
X-Draft-From: ("lists.kernel" 8)
References: <opsd3vx7i3u7wa79@smtp.nildram.co.uk>
	<20040910190924.GB8799@mars.ravnborg.org>
From: Starling <pubsynxj8jw@pacbell.net>
Date: Fri, 10 Sep 2004 16:55:18 -0700
In-Reply-To: <20040910190924.GB8799@mars.ravnborg.org> (Sam Ravnborg's
 message of "Fri, 10 Sep 2004 21:09:24 +0200")
Message-ID: <871xh94r2x.fsf_-_@pacbell.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, is there any way the input from the keyboard can interfere with
the input from the mouse?  Because they are interfering, on my
computer.  If I hold ctrl, the mouse jumps randomly about if I try to
move it.  And then the ctrl key gets stuck in the 'on' position until
I rapidly tap it to somehow get it reset.

The same occurs for the shift key, which is very disturbing as it
opens every possible right-click menu on my GUI.

It's not the video card: I've used 2 different cards since the problem
started.  It's not the sound card either, as I have used 2 different
sound cards as well.  The problem started when I switched from 2.4 to
2.6, and seems confined entirely to the keyboard and mouse drivers.

I have a USB mouse, and a PS/2 keyboard; both worked perfectly before
2.6.  I run fvwm, and a recent compile of X.org.  Video driver is "S3
Savage4" or a proprietary Nvidia one, take your pick.  (The Nvidia
card went and broke on me, S3 is on-board.)

I don't think quoting the whole .config would be appreciated, but
here's what seemed like it would be relavent.  Is there any setting I
might have not properly applied?

CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y

CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
