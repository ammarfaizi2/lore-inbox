Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWFZGfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWFZGfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWFZGfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:35:09 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:64665 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964837AbWFZGfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:35:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input update for 2.6.17
Date: Mon, 26 Jun 2006 02:35:03 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 4842
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200606260235.03718.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

It contains support for Intellimouse 4.0 in psmouse driver, improved
support for korean keyboards; sprintf changed into snprintf to make
sure we don't stop on data adjacent to buffer and some other changes.

Diffstat:

 MAINTAINERS                                 |    3 
 drivers/char/keyboard.c                     |   16 +-
 drivers/input/evdev.c                       |   10 +
 drivers/input/input.c                       |   85 +++++++---
 drivers/input/joydev.c                      |   69 +++++---
 drivers/input/joystick/a3d.c                |    2 
 drivers/input/joystick/analog.c             |   23 +-
 drivers/input/joystick/cobra.c              |    3 
 drivers/input/joystick/db9.c                |    3 
 drivers/input/joystick/gamecon.c            |    3 
 drivers/input/joystick/gf2k.c               |    2 
 drivers/input/joystick/grip.c               |    3 
 drivers/input/joystick/guillemot.c          |    2 
 drivers/input/joystick/iforce/iforce-ff.c   |    8 -
 drivers/input/joystick/iforce/iforce-main.c |    6 
 drivers/input/joystick/interact.c           |    2 
 drivers/input/joystick/magellan.c           |    2 
 drivers/input/joystick/sidewinder.c         |   15 +
 drivers/input/joystick/spaceball.c          |    2 
 drivers/input/joystick/spaceorb.c           |    2 
 drivers/input/joystick/stinger.c            |    2 
 drivers/input/joystick/twidjoy.c            |    2 
 drivers/input/joystick/warrior.c            |    2 
 drivers/input/keyboard/atkbd.c              |  219 +++++++++++++++++-----------
 drivers/input/keyboard/lkkbd.c              |    9 -
 drivers/input/keyboard/newtonkbd.c          |    2 
 drivers/input/keyboard/sunkbd.c             |    2 
 drivers/input/keyboard/xtkbd.c              |    2 
 drivers/input/mouse/alps.c                  |    2 
 drivers/input/mouse/psmouse-base.c          |   39 ++++
 drivers/input/mouse/sermouse.c              |    2 
 drivers/input/mouse/vsxxxaa.c               |   22 +-
 drivers/input/mousedev.c                    |   42 +++--
 drivers/input/touchscreen/gunze.c           |    2 
 drivers/input/touchscreen/h3600_ts_input.c  |    2 
 drivers/input/touchscreen/mtouch.c          |    2 
 drivers/input/tsdev.c                       |   22 +-
 drivers/macintosh/Makefile                  |    2 
 drivers/macintosh/adbhid.c                  |    2 
 drivers/macintosh/via-pmu-event.c           |   80 ++++++++++
 drivers/macintosh/via-pmu-event.h           |    8 +
 drivers/macintosh/via-pmu.c                 |    8 +
 drivers/usb/input/fixp-arith.h              |   15 -
 drivers/usb/input/hid-debug.h               |    2 
 include/linux/input.h                       |   10 -
 45 files changed, 515 insertions(+), 248 deletions(-)

Changelog:

Andreas Mohr:
      Input: constify drivers/char/keyboard.c

Anssi Hannula:
      Input: iforce - use ENOSPC instead of ENOMEM
      Input: fix accuracy of fixp-arith.h

Dmitry Torokhov:
      Input: fix potential overflows in driver/input/mouse
      Input: fix potential overflows in driver/input/joystick
      Input: fix potential overflows in driver/input/touchscreen
      Input: fix potential overflows in driver/input/keyboard
      Input: change my e-mail address in MAINTAINERS file
      Input: reset name, phys and uniq when unregistering
      Input: fix formatting to better follow CodingStyle
      Input: rearrange exports
      Input: atkbd - fix HANGEUL/HANJA keys

Jerome Pinot:
      Input: fix misspelling of Hangeul key

Jesper Juhl:
      Input: iforce - remove some pointless casts

Johannes Berg:
      Input: via-pmu - add input device support

Pozsar Balazs:
      Input: psmouse - add support for Intellimouse 4.0

Richard Purdie:
      Input: return correct size when reading modalias attribute

-- 
Dmitry
