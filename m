Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266533AbUGLLmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUGLLmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUGLLmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:42:17 -0400
Received: from S010600104b97db1e.gv.shawcable.net ([24.68.211.67]:45316 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S266533AbUGLLmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:42:13 -0400
Date: Mon, 12 Jul 2004 04:36:29 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: mouse in 2.6.8-rc1 not working
Message-ID: <20040712113629.GA3151@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The mouse attached to the Type 5 keyboard on my Ultra 5
stopped working when I upgraded from 2.6.7-rc3 to 2.6.8-rc1.

Previously, even with 2.6.7-rc3, I had to boot into 2.4.x
and "wiggle" the mouse to get it initialized.  2.6.7-rc3
recognizes that a mouse is attached.  2.6.8-rc1 doesn't.

Doing a cat /dev/input/mouse0:

2.6.7-rc3 w/o booting into 2.4.x first:
Nothing is read.

2.6.8-rc1 regardless of 2.4.x being used:
mouse device isn't seen.

2.6.7-rc3 after initializing moue under 2.4.x:
works.

CONFIG_SERIAL_SUNCORE=y
CONFIG_SERIAL_SUNZILOG=y
CONFIG_SERIAL_SUNSU=y
CONFIG_SERIAL_SUNSAB=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_SPARCSPKR=y

-- DN
Daniel
