Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWJQD4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWJQD4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 23:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJQD4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 23:56:54 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:29710 "EHLO
	asav00.insightbb.com") by vger.kernel.org with ESMTP
	id S932108AbWJQD4y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 23:56:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AesRANDwM0WBSoQmhi0s
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [git pull] Input patches for 2.6.19-rc2
Date: Mon, 16 Oct 2006 23:56:49 -0400
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610162356.52100.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

        git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

or
        master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for input subsystem. The tree contains a fix for
lockdep warning in psmouse driver and improved blinking durng panic
in i8042 plus couple more minor fixes.

Changelog:
----------

Andrew Morton:
      Lockdep: fix compile error in drivers/input/serio/serio.c

Dmitry Torokhov:
      Input: add missing exports to fix modular build
      Input: i8042 - supress ACK/NAKs when blinking during panic
      Input: atkbd - supress "too many keys" error message
      Input: serio core - handle errors returned by device_bind_driver()
      Input: gameport core - handle errors returned by device_bind_driver()

Jeff Garzik:
      Input: fm801-gp - handle errors from pci_enable_device()

Jiri Kosina:
      Input: serio - add lockdep annotations

Peter Zijlstra:
      Lockdep: add lockdep_set_class_and_subclass() and lockdep_set_subclass()


Diffstat:
----------
 b/drivers/char/random.c             |    1 
 b/drivers/input/gameport/fm801-gp.c |   22 ++++++++++----
 b/drivers/input/gameport/gameport.c |   18 ++++++++++--
 b/drivers/input/keyboard/atkbd.c    |   54 +++++++++++++++++++++++++++---------
 b/drivers/input/serio/i8042.c       |   13 +++++++-
 b/drivers/input/serio/libps2.c      |    3 +-
 b/drivers/input/serio/serio.c       |   16 +++++++++-
 b/include/linux/lockdep.h           |    2 +
 b/include/linux/serio.h             |    1 
 b/kernel/lockdep.c                  |   10 ++++--
 b/kernel/mutex-debug.c              |    2 -
 b/lib/kobject.c                     |    1 
 b/lib/rwsem-spinlock.c              |    2 -
 b/lib/rwsem.c                       |    2 -
 b/lib/spinlock_debug.c              |    4 +-
 b/net/core/sock.c                   |    2 -
 drivers/input/serio/serio.c         |    6 +++-
 include/linux/lockdep.h             |   15 +++++++---
 18 files changed, 132 insertions(+), 42 deletions(-)



-- 
Dmitry
