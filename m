Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSHZFzy>; Mon, 26 Aug 2002 01:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSHZFzy>; Mon, 26 Aug 2002 01:55:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316996AbSHZFzy>;
	Mon, 26 Aug 2002 01:55:54 -0400
Date: Sun, 25 Aug 2002 22:59:47 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <torvalds@transmeta.com>, <ralf@gnu.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] reduce CONFIG_INPUT as forward symbol
Message-ID: <Pine.LNX.4.33L2.0208252243130.23948-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've been using gcml2 from Greg Banks to look at CONFIG_
variable dependencies in config.in files.

By moving drivers/input/config.in before drivers/char/Config.in
and drivers/usb/Config.in for arch/alpha and arch/mips(64),
several (7) instances of this message:
  forward declared symbol "CONFIG_INPUT" used in dependency list
and (6) instances of this one:
  forward declared symbol "CONFIG_SOUND_GAMEPORT" used in
  dependency list
can be removed.  (Yes, the latter one is for OSS drivers,
so it's not so important.)

It also adds one forward dependency for a USB joystick
in the input subsystem [still only for alpha and mips(64)].
Most other arches are already like this.

This patch is to 2.5.31-bk7 (jgarzik's latest snapshot).
Please apply.

-- 
~Randy

