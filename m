Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268256AbTGTXnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbTGTXnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:43:23 -0400
Received: from pop.gmx.de ([213.165.64.20]:25994 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268256AbTGTXnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:43:22 -0400
From: Michael Schierl <schierlm-usenet@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 and LILO problem: "Device 0x0300: Invalid partition table, 1st entry"
Date: Mon, 21 Jul 2003 01:57:53 +0200
Reply-To: schierlm@gmx.de
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S268256AbTGTXnW/20030720234322Z+3835@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(sorry if i am wrong here; could in that case someone tell me the
right place to report this?)

I installed 2.6.0-test1 kernel on my acer laptop. Seems to run quite
well (even APM works now), but when I try to rerun LILO (when I
recompiled the kernel), it does not work on 2.6.0-test1 kernel:

---
LILO version 22.2, Copyright (C) 1992-1998 Werner Almesberger
Development beyond version 21 Copyright (C) 1999-2001 John Coffman
Released 05-Feb-2002 and compiled at 20:57:26 on Apr 13 2002.
MAX_IMAGES = 27

Reading boot sector from /dev/hda2
Merging with /boot/boot-menu.b
Boot image: /vmlinuz -> boot/vmlinuz
Added Linux

[...]

Boot image: /boot/vmlinuz-2.4
Added Linux2.4

Boot other: /dev/hda1, on /dev/hda, loader /boot/chain.b
Device 0x0300: Invalid partition table, 1st entry
  3D address:     1/1/261 (263151)
  Linear address: 1/12/4159 (4193028)
---

hda1 is a fat32 partition w/ windows on it.

When I boot 2.4.20, i can rewrite LILO w/o errors.

looking at /proc/ide/hda/geometry reveals on 2.4.20:

---
physical     19485/16/63
logical      1222/255/63
---

on 2.6.0-test1:

---
physical     19485/16/63
logical      19485/16/63
---

/proc/partitions is in both cases:

---
major minor  #blocks  name

   3     0    9820440 hda
   3     1    7719201 hda1
   3     2    1992028 hda2
   3     3     104422 hda3
---

Michael
