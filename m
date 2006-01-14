Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWANQBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWANQBh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWANQBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:01:16 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:2975 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932287AbWANQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:01:09 -0500
Message-Id: <20060114151645.035957000.dtor_core@ameritech.net>
Date: Sat, 14 Jan 2006 10:16:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [git pull 0/7] Another input update for 2.6.15
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please do a pull from:

	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git/

The main feature is psmouse resync patch which should make PS/2 mice
useable with cheap KVMs that reset mice when switching between boxes.
Also there is a fix for OOps in PID code, build for for powerpc and
HID tweaks to make new USB-based keyboards behave like older ADB ones.

Changelog:

	Input: i8042 - add Sony Vaio FSC-115b to MUX blacklist (Vojtech)
	Input: HID - add support for Cherry Cymotion keyboard (Vojtech)
	Input: HID - fix an oops in PID initialization code
	Input: psmouse - attempt to re-synchronize mouse every 5 seconds
	Input: HID - add more simulation usages
	Input: wacom - fix compile on PowerPC
	Input: HID - add support for fn key on Apple PowerBooks (Michael Hanselmann)

Diffstat:

 input/mouse/alps.c            |   38 +++++
 input/mouse/logips2pp.c       |    2 
 input/mouse/psmouse-base.c    |  316 +++++++++++++++++++++++++++++++++---------
 input/mouse/psmouse.h         |    9 +
 input/mouse/synaptics.c       |    2 
 input/serio/i8042-x86ia64io.h |    7 
 usb/input/Kconfig             |   10 +
 usb/input/hid-core.c          |   30 +++
 usb/input/hid-input.c         |  179 +++++++++++++++++++++++
 usb/input/hid.h               |   30 ++-
 usb/input/pid.c               |    2 
 usb/input/wacom.c             |   14 -
 12 files changed, 551 insertions(+), 88 deletions(-)

Thanks!

--
Dmitry

