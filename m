Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWD2FnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWD2FnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 01:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWD2FnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 01:43:20 -0400
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:34988 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750724AbWD2FnU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 01:43:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input update for 2.6.17-rc3
Date: Sat, 29 Apr 2006 01:43:17 -0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2730
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200604290143.18191.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

to get various input layer updates.

Diffstat:

 drivers/char/keyboard.c             |   38 ++-
 drivers/input/evdev.c               |   21 +
 drivers/input/input.c               |   11
 drivers/input/keyboard/spitzkbd.c   |    4
 drivers/input/misc/wistron_btns.c   |   30 ++
 drivers/input/mouse/psmouse-base.c  |    4
 drivers/input/touchscreen/ads7846.c |  414 +++++++++++++++++++++++++++++-------
 include/linux/input.h               |  109 ++++-----
 include/linux/mod_devicetable.h     |   48 ++++
 include/linux/spi/ads7846.h         |    7
 scripts/mod/file2alias.c            |   36 +--
 11 files changed, 555 insertions(+), 167 deletions(-)

Changelog:

Dmitry Torokhov:
      Input: allow passing NULL to input_free_device()
      Input: move input_device_id to mod_devicetable.h
      Input: psmouse - fix new device detection logic
      Input: ressurect EVIOCGREP and EVIOCSREP
      Input: make EVIOCGSND return meaningful data

Imre Deak:
      Input: ads7846 - add pen_down sysfs attribute
      Input: ads7846 - power down ADC a bit later
      Input: ads7846 - debouncing and rudimentary sample filtering
      Input: ads7846 - miscellaneous fixes
      Input: ads7846 - handle IRQs that were latched during disabled IRQs
      Input: ads7846 - report 0 pressure value along with pen up event
      Input: ads7846 - improve filtering for thumb press accuracy

John Reed Riley:
      Input: wistron - add support for Fujitsu N3510

Juha Yrjola:
      Input: ads7846 - use msleep() instead of udelay() in suspend

Richard Purdie:
      Input: spitzkbd - fix the reversed Address and Calender keys

Samuel Thibault:
      Input: allow using several chords for braille

Stefan Rompf:
      Input: wistron - add signature for Amilo M7400

-- 
Dmitry
