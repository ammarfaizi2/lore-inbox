Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424849AbWLHG5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424849AbWLHG5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424844AbWLHG5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:57:08 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:1211 "EHLO
	asav12.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424841AbWLHG5H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:57:07 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnoUAMabeEVKhQ0nVWdsb2JhbACGfYY6ASs
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input patches for 2.6.19
Date: Fri, 8 Dec 2006 01:57:03 -0500
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612080157.04822.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

to receive updates for input subsystem.

Changelog:
----------
Akinobu Mita (2):
      Input: lightning - return proper error codes from l4_init()
      Input: handle serio_register_driver() errors

Andrew Morton (1):
      Input: lifebook - learn about hard tabs

Anssi Hannula (1):
      Input: HID - add a quirk for the Logitech USB Receiver

Brandon Philips (1):
      Input: drivers/char/keyboard.c - small cleanup in k_cur()

Dmitry Torokhov (14):
      Input: add comments to input_{allocate|free}_device()
      Input: gameport - rearrange gameport_bus initialization
      Input: i8042 - remove unneeded call to i8042_interrupt()
      Input: ads7846 - handle errors from sysfs
      Input: keyboards - handle errors when registering input devices
      Input: touchscreens - handle errors when registering input devices
      Input: joysticks - handle errors when registering input devices
      Input: mice - handle errors when registering input devices
      Input: i8042 - fix shutdown issue on some boxes with active MUXes
      Input: serio - remove serio_unregister_port_delayed()
      Input: serio - make serio_register_driver() return errors
      Input: handle errors from input_register_device in drivers/macintosh
      Input: i8042 - add another Lifebook P7010 to nomux blacklist
      Input: ucb1400 - fix compile error

Greg Chandler (1):
      Input: lifebook - add Hitachi Flora-IE 55mi tablet DMI signature

Jason Parekh (1):
      Input: appletouch - verious updates for MacBooks

Jeff Garzik (2):
      Input: trackpoint - handle sysfs errors
      Input: logips2pp - handle sysfs errors

Julien BLACHE (2):
      Input: appletouch - add Geyser IV support
      Input: appletouch - use canonical names in USB IDs

Marton Nemeth (2):
      Input: serio - rearrange serio_bus initialization
      Input: mousedev - remap BTN_FORWARD from BTN_LEFT to BTN_MIDDLE

Nicolas Bellido (1):
      Input: add driver for keyboard on AAED-2000 development board (ARM)

Nicolas Pitre (1):
      Input: add Philips UCB1400 touchscreen driver

Paul Mundt (1):
      Input: kill maple_keyb.c driver

Randy Dunlap (1):
      Input: add to kernel-api docbook

Sergey Vlasov (1):
      Input: psmouse - fix attribute access on 64-bit systems

Stelian Pop (1):
      Input: MAC mouse button emulation - relax dependencies


Diffstat:
---------
 b/Documentation/DocBook/kernel-api.tmpl        |    8 
 b/drivers/char/keyboard.c                      |    2 
 b/drivers/input/ff-core.c                      |    4 
 b/drivers/input/ff-memless.c                   |    2 
 b/drivers/input/gameport/gameport.c            |   19 
 b/drivers/input/gameport/lightning.c           |    4 
 b/drivers/input/input.c                        |   25 +
 b/drivers/input/joystick/adi.c                 |   10 
 b/drivers/input/joystick/amijoy.c              |    6 
 b/drivers/input/joystick/analog.c              |   10 
 b/drivers/input/joystick/cobra.c               |    7 
 b/drivers/input/joystick/gf2k.c                |    4 
 b/drivers/input/joystick/grip_mp.c             |   13 
 b/drivers/input/joystick/guillemot.c           |    4 
 b/drivers/input/joystick/iforce/iforce-main.c  |   14 
 b/drivers/input/joystick/iforce/iforce-serio.c |   20 
 b/drivers/input/joystick/interact.c            |    4 
 b/drivers/input/joystick/magellan.c            |    3 
 b/drivers/input/joystick/spaceball.c           |    3 
 b/drivers/input/joystick/spaceorb.c            |    3 
 b/drivers/input/joystick/stinger.c             |    3 
 b/drivers/input/joystick/twidjoy.c             |    3 
 b/drivers/input/joystick/warrior.c             |    3 
 b/drivers/input/keyboard/Kconfig               |   11 
 b/drivers/input/keyboard/Makefile              |    1 
 b/drivers/input/keyboard/aaed2000_kbd.c        |  203 ++++++++
 b/drivers/input/keyboard/amikbd.c              |   22 
 b/drivers/input/keyboard/atkbd.c               |    3 
 b/drivers/input/keyboard/corgikbd.c            |   17 
 b/drivers/input/keyboard/hil_kbd.c             |    3 
 b/drivers/input/keyboard/lkkbd.c               |    3 
 b/drivers/input/keyboard/locomokbd.c           |   28 -
 b/drivers/input/keyboard/maple_keyb.c          |   14 
 b/drivers/input/keyboard/newtonkbd.c           |    3 
 b/drivers/input/keyboard/spitzkbd.c            |   24 -
 b/drivers/input/keyboard/stowaway.c            |    3 
 b/drivers/input/keyboard/sunkbd.c              |    3 
 b/drivers/input/keyboard/xtkbd.c               |    3 
 b/drivers/input/mouse/amimouse.c               |   11 
 b/drivers/input/mouse/hil_ptr.c                |    3 
 b/drivers/input/mouse/inport.c                 |   23 
 b/drivers/input/mouse/lifebook.c               |   88 +--
 b/drivers/input/mouse/logibm.c                 |   24 -
 b/drivers/input/mouse/logips2pp.c              |   11 
 b/drivers/input/mouse/pc110pad.c               |   26 -
 b/drivers/input/mouse/psmouse-base.c           |    8 
 b/drivers/input/mouse/rpcmouse.c               |   20 
 b/drivers/input/mouse/sermouse.c               |    3 
 b/drivers/input/mouse/trackpoint.c             |   12 
 b/drivers/input/mouse/vsxxxaa.c                |    3 
 b/drivers/input/mousedev.c                     |    2 
 b/drivers/input/serio/i8042-x86ia64io.h        |    7 
 b/drivers/input/serio/i8042.c                  |   18 
 b/drivers/input/serio/serio.c                  |  107 +++-
 b/drivers/input/serio/serio_raw.c              |    3 
 b/drivers/input/touchscreen/Kconfig            |   15 
 b/drivers/input/touchscreen/Makefile           |    1 
 b/drivers/input/touchscreen/ads7846.c          |   95 ++--
 b/drivers/input/touchscreen/corgi_ts.c         |   30 -
 b/drivers/input/touchscreen/elo.c              |    3 
 b/drivers/input/touchscreen/gunze.c            |    3 
 b/drivers/input/touchscreen/h3600_ts_input.c   |    3 
 b/drivers/input/touchscreen/hp680_ts_input.c   |   29 -
 b/drivers/input/touchscreen/mk712.c            |   26 -
 b/drivers/input/touchscreen/mtouch.c           |    3 
 b/drivers/input/touchscreen/penmount.c         |    3 
 b/drivers/input/touchscreen/touchright.c       |    3 
 b/drivers/input/touchscreen/touchwin.c         |    3 
 b/drivers/input/touchscreen/ucb1400_ts.c       |  581 ++++++++++++++++++++++++-
 b/drivers/macintosh/Kconfig                    |    1 
 b/drivers/macintosh/adbhid.c                   |   10 
 b/drivers/macintosh/mac_hid.c                  |    8 
 b/drivers/usb/input/appletouch.c               |   27 -
 b/drivers/usb/input/hid-core.c                 |    7 
 b/drivers/usb/input/hid-input.c                |    4 
 b/drivers/usb/input/hid.h                      |    1 
 b/include/linux/input.h                        |   18 
 b/include/linux/serio.h                        |    7 
 drivers/input/joystick/iforce/iforce-main.c    |   17 
 drivers/input/joystick/magellan.c              |   14 
 drivers/input/joystick/spaceball.c             |   14 
 drivers/input/joystick/spaceorb.c              |   14 
 drivers/input/joystick/stinger.c               |   14 
 drivers/input/joystick/twidjoy.c               |   14 
 drivers/input/joystick/warrior.c               |   14 
 drivers/input/keyboard/atkbd.c                 |  159 +++++-
 drivers/input/keyboard/lkkbd.c                 |   14 
 drivers/input/keyboard/maple_keyb.c            |  166 -------
 drivers/input/keyboard/newtonkbd.c             |   14 
 drivers/input/keyboard/sunkbd.c                |   20 
 drivers/input/keyboard/xtkbd.c                 |   14 
 drivers/input/mouse/lifebook.c                 |    6 
 drivers/input/mouse/psmouse-base.c             |   93 ++--
 drivers/input/mouse/sermouse.c                 |   13 
 drivers/input/mouse/vsxxxaa.c                  |   13 
 drivers/input/serio/i8042.c                    |   21 
 drivers/input/serio/serio.c                    |   40 -
 drivers/input/touchscreen/gunze.c              |   14 
 drivers/input/touchscreen/mtouch.c             |   13 
 drivers/usb/input/appletouch.c                 |   68 ++
 include/linux/serio.h                          |    5 
 101 files changed, 1830 insertions(+), 709 deletions(-)


-- 
Dmitry
