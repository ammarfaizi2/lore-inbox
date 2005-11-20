Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVKTGrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVKTGrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVKTGrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:47:11 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:5485 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750710AbVKTGrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:10 -0500
Message-Id: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 00/14] Input updates for 2.6.15
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling from:

	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git

It corrects couple of problems caused by recein input dynalloc
conversion, converts uinput driver to dynamic allocation and
adds new wistron button driver which was siting in -mm for quite
a while.

Vojtech, please bless the pull.

Changelog:

 Fix missing initialization in ir-kbd-gpio.c
 Fix an OOPS when initializing IR remote on saa7134
 Input: make serio and gameport more swsusp friendly
 Input: handle failures in input_register_device()
 Input: uinput - don't use "interruptible" in FF code
 Input: uinput - add UI_SET_SWBIT ioctl
 Input: uinput - convert to dynalloc allocation
 Input: wistron - disable wifi/bluetooth on suspend
 Input: wistron - add PM support
 Input: wistron - convert to dynamic input_dev allocation
 Input: wistron - add support for Acer Aspire 1500 notebooks
 Input: wistron - disable for x86_64
 Input: add Wistron driver
 Input: atkbd - speed up setting leds/repeat state

Diffstat:

 MAINTAINERS                                 |    5 
 drivers/input/gameport/gameport.c           |   12 
 drivers/input/input.c                       |   63 +--
 drivers/input/keyboard/atkbd.c              |   99 +++-
 drivers/input/misc/Kconfig                  |   10 
 drivers/input/misc/Makefile                 |    1 
 drivers/input/misc/uinput.c                 |  323 ++++++++--------
 drivers/input/misc/wistron_btns.c           |  561 ++++++++++++++++++++++++++++
 drivers/input/serio/serio.c                 |   12 
 drivers/media/video/ir-kbd-gpio.c           |    5 
 drivers/media/video/saa7134/saa7134-input.c |    2 
 include/linux/uinput.h                      |   13 
 12 files changed, 880 insertions(+), 226 deletions(-)

--
Dmitry

