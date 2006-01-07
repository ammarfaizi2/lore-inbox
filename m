Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWAGTIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWAGTIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWAGTIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:21 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:41625 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030547AbWAGTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:21 -0500
Message-Id: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:15:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 00/24] Input patches for 2.6.15
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

Nothing terribly important except for a fix for some optical PS/2
mice going to sleep and turning their light off as soon as psmouse
tried to initialize them.

Changelog:

    Input: ibmasm - convert to dynamic input_dev allocation (Vernon Mauery)
    Input: i8042 - add OQO Zepto to noloop dmi table (Ben Collins)
    Input: add missing keys from input.h to hid-debug.h (Michael Hanselmann)
    Input: atkbd - don't lose keymap settings when reconnecting keyboard
    Input: wistron - convert to the new platform device interface
    Input: maceps2 - convert to the new platform device interface
    Input: q40kbd - convert to the new platform device interface
    Input: ct82c710 - convert to the new platform device interface
    Input: i8042 - convert to the new platform device interface
    Input: logips2pp - add signature of MouseMan Wheel Mouse (87)
    Input: sparcspkr - register with driver core as a platfrom device
    Input: m68kspkr - register with driver core as a platfrom device
    Input: pcspkr - register with driver core as a platfrom device
    Input: lifebook - add DMI signature of Fujitsu Lifebook B142 (Daniele Gozzi)
    Input: add help entry for FM801 gameport driver to Kconfig
    Input: i8042 - disable MUX mode for Sharp MM20
    Input: psmouse - don't leave mouse asleep
    Input: ALPS - add signature for HP ze1115 (Larry Finger)
    Input: appletouch - add support for Geyser 2 (Michael Hanselmann)
    Input: add the fn key to hid-debug.h (Michael Hanselmann)
    Input: wistron - add Acer TravelMate 240 to DMI table (Ashutosh Naik)
    Input: logips2pp - add new signature (85) (Jasper Spaans)
    Input: mousedev - make module parameters visible in sysfs
    Input: evdev - consolidate compat and regular code

Diffstat:

 Documentation/input/appletouch.txt    |    5 
 drivers/input/evdev.c                 |  491 ++++++++++++++--------------------
 drivers/input/gameport/Kconfig        |    7 
 drivers/input/keyboard/atkbd.c        |    2 
 drivers/input/misc/m68kspkr.c         |  104 +++++--
 drivers/input/misc/pcspkr.c           |   86 +++++
 drivers/input/misc/sparcspkr.c        |  162 +++++++----
 drivers/input/misc/wistron_btns.c     |  133 ++++++---
 drivers/input/mouse/alps.c            |    1 
 drivers/input/mouse/lifebook.c        |    7 
 drivers/input/mouse/logips2pp.c       |    2 
 drivers/input/mouse/psmouse-base.c    |   15 -
 drivers/input/mousedev.c              |   10 
 drivers/input/serio/ct82c710.c        |   89 ++++--
 drivers/input/serio/i8042-x86ia64io.h |   15 +
 drivers/input/serio/i8042.c           |  116 ++++----
 drivers/input/serio/maceps2.c         |   68 +++-
 drivers/input/serio/q40kbd.c          |   91 ++++--
 drivers/misc/ibmasm/ibmasm.h          |    6 
 drivers/misc/ibmasm/remote.c          |   82 +++--
 drivers/usb/input/appletouch.c        |  145 +++++++---
 drivers/usb/input/hid-debug.h         |   15 +
 22 files changed, 1032 insertions(+), 620 deletions(-)

Thanks!

--
Dmitry

