Return-Path: <linux-kernel-owner+w=401wt.eu-S1755273AbXABGCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbXABGCh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 01:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbXABGCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 01:02:36 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:33710 "EHLO
	asav01.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273AbXABGCg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 01:02:36 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AusRAK6DmUVKhRO4UGdsb2JhbACHN4ZJAQEq
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input patches for 2.6.20-rc3
Date: Tue, 2 Jan 2007 01:02:17 -0500
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701020102.18310.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

to receive updates for input subsystem. There is a new driver for GPIO
connected keys from handheld.org tree and an update for ads7846 driver
from OPAM tree. Since these trees are main users of the drivers I think
chance of failure is pretty low.

Changelog:
----------
Akinobu Mita (1):
      Input: pc110pad - return proper error

David Brownell (1):
      Input: ads7846 - be more compatible with the hwmon framework

Dmitry Torokhov (1):
      Input: i8042 - really suppress ACK/NAK during panic blink

Imre Deak (5):
      Input: ads7846 - pluggable filtering logic
      Input: ads7846 - optionally leave Vref on during differential measurements
      Input: ads7846 - switch to using hrtimer
      Input: ads7846 - select correct SPI mode
      Input: ads7846 - detect pen up from GPIO state

Jiri Slaby (1):
      Input: hid-ff - add support for Logitech Momo racing wheel

Phil Blundell (1):
      Input: gpio-keys - keyboard driver for GPIO buttons

Stephen Hemminger (1):
      Input: lifebook - add support for Lifebook 6210

Diffstat:
---------
 drivers/input/keyboard/Kconfig       |   19 -
 drivers/input/keyboard/Makefile      |    5 
 drivers/input/keyboard/gpio_keys.c   |  147 ++++++++
 drivers/input/mouse/lifebook.c       |    6 
 drivers/input/mouse/pc110pad.c       |    2 
 drivers/input/serio/i8042.c          |    7 
 drivers/input/touchscreen/Kconfig    |    9 
 drivers/input/touchscreen/ads7846.c  |  581 +++++++++++++++++++++++------------
 drivers/usb/input/hid-ff.c           |    1 
 drivers/usb/input/hid-lgff.c         |    1 
 include/asm-arm/hardware/gpio_keys.h |   17 +
 include/linux/spi/ads7846.h          |   12 
 12 files changed, 604 insertions(+), 203 deletions(-)

-- 
Dmitry
