Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWBAFJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWBAFJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWBAFJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:05 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:56210 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030308AbWBAFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:02 -0500
Message-Id: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 00/18] Input updates for 2.6.16-rc1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider doing a pull from:

	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/

or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git/

The tree contains several patches that fix crashes and a memory leak
in several input drivers; many of them are candidates for -stable as
well. Additionally there is new ixp4xx beeper driver, and a couple of
cleanups.

Full changelog:

    Input: hiddev - fix off-by-one for num_values in uref_multi
	   requests (Ben Collins)
    Input: iforce - fix detection of USB devices
    Input: a3d - convert to dynamic input_dev allocation
    Input: tmdc - handle errors from input_register_device()
    Input: turbografx - handle errors from input_register_device()
    Input: gamecon - handle errors from input_register_device()
    Input: gamecon - fix crash when accessing device
    Input: sidewinder - handle errors from input_register_device()
    Input: sidewinder - fix an oops (Zinx Verituse)
    Input: db9 - handle errors from input_register_device()
    Input: db9 - fix possible crash with Saturn gamepads
    Input: grip - handle errors from input_register_device()
    Input: grip - fix crash when accessing device
    Input: make needlessly global code static (Adrian Bunk)
    Input: mousedev - fix memory leak (Kimball Murray)
    Input: iforce - do not return ENOMEM upon successful
	   allocation (Alexey Dobriyan)
    Input: psmouse - set name for Genius mice
    Input: add ixp4xx beeper driver (Alessandro Zummo)

Diffstat:

 input/joystick/a3d.c                   |   88 ++++----
 input/joystick/db9.c                   |   85 ++++---
 input/joystick/gamecon.c               |  357 ++++++++++++++++++---------------
 input/joystick/grip.c                  |   11 -
 input/joystick/iforce/iforce-main.c    |    2 
 input/joystick/iforce/iforce-packets.c |    4 
 input/joystick/iforce/iforce-usb.c     |    1 
 input/joystick/sidewinder.c            |   10 
 input/joystick/tmdc.c                  |   15 +
 input/joystick/turbografx.c            |   20 +
 input/joystick/twidjoy.c               |    4 
 input/misc/Kconfig                     |   12 +
 input/misc/Makefile                    |    1 
 input/misc/ixp4xx-beeper.c             |  183 ++++++++++++++++
 input/mouse/psmouse-base.c             |    1 
 input/mousedev.c                       |    9 
 input/touchscreen/mk712.c              |    2 
 usb/input/hiddev.c                     |    2 
 18 files changed, 543 insertions(+), 264 deletions(-)

--
Dmitry

