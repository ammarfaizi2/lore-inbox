Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWHERiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWHERiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 13:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWHERiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 13:38:17 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17728 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1422657AbWHERiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 13:38:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAG9z1ESBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input update for 2.6.18-rc3
Date: Sat, 5 Aug 2006 13:38:13 -0400
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608051338.13913.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I redid the 'for-linus' branch to resolve conflicts with Greg and added
the fix for atkbd to restore repeat rate upon resume, please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

Changelog:

Andrew Morton:
      Input: wistron - fix section reference mismatches
      Input: fix list iteration in input_release_device()

Dmitry Torokhov:
      Input: remove accept method from input_dev
      Input: add start() method to input handlers
      Input: introduce input_inject_event() function
      Input: fm801-gp - fix use after free
      Input: libps2 - warn instead of oopsing when passed bad arguments
      Input: iforce - check array bounds before accessing elements
      Input: HID - fix potential out-of-bound array access
      Input: add missing handler->start() call
      Input: hiddev - use standard list implementation
      Input: keyboard - remove static variable and clean up initialization
      Input: keyboard - simplify emulate_raw() implementation
      Input: keyboard - change to use kzalloc
      Input: trackpoint - activate protocol when resuming
      Input: atkbd - restore repeat rate when resuming
      Input: ati_remote - relax permissions sysfs module parameters
      Input: ati_remote - add missing input_sync()
      Input: ati_remote - use msec instead of jiffies

Edwin Huffstutler:
      Input: ati_remote - make filter time a module parameter

Nick Martin:
      Input: spaceball - make 4000FLX Lefty work

Przemek Iskra:
      Input: iforce - add Trust Force Feedback Race Master support

Randy Dunlap:
      Input: serio/gameport - check whether driver core calls succeeded

Roberto Castagnola:
      Input: logips2pp - fix button mapping for MX300


Diffstat:

 drivers/char/keyboard.c                     |  139 ++++++++++++----------
 drivers/input/evdev.c                       |   10 -
 drivers/input/gameport/fm801-gp.c           |    4 
 drivers/input/gameport/gameport.c           |   66 +++++++---
 drivers/input/input.c                       |   57 +++++++--
 drivers/input/joystick/iforce/iforce-main.c |   19 +--
 drivers/input/joystick/spaceball.c          |    2 
 drivers/input/keyboard/atkbd.c              |  103 +++++++++-------
 drivers/input/misc/wistron_btns.c           |   20 +--
 drivers/input/mouse/logips2pp.c             |    3 
 drivers/input/mouse/trackpoint.c            |   52 +++++---
 drivers/input/serio/libps2.c                |    5 
 drivers/input/serio/serio.c                 |   65 ++++++++--
 drivers/usb/input/ati_remote.c              |  173 ++++++++++++++++------------
 drivers/usb/input/hid-input.c               |    3 
 drivers/usb/input/hiddev.c                  |   72 ++++++-----
 include/linux/input.h                       |   24 +++
 17 files changed, 509 insertions(+), 308 deletions(-)


--  
Dmitry
