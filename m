Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSKVMEI>; Fri, 22 Nov 2002 07:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSKVMEI>; Fri, 22 Nov 2002 07:04:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39582 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264672AbSKVMEG>;
	Fri, 22 Nov 2002 07:04:06 -0500
Date: Fri, 22 Nov 2002 12:09:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK] Move watchdog drivers to drivers/char/watchdog/
Message-ID: <20021122120921.GA17439@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone suggested moving the dozen or so watchdog drivers we
have in drivers/char/ to their own dir in drivers/char/watchdog
a few weeks ago. Then nothing happened, so I got bored waiting
and did it myself.

No code changes, just moving files around.

For the bk-impaired/agnostic, the (large) GNU diff from this is at 
ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.48/move-watchdogs.diff.gz

Pull from bk://linux-dj.bkbits.net/watchdog

		Dave

diffstat:
 Kconfig                 |  284 --------------------
 Makefile                |   23 -
 acquirewdt.c            |  251 -----------------
 advantechwdt.c          |  280 --------------------
 eurotechwdt.c           |  501 -----------------------------------
 i810-tco.c              |  431 ------------------------------
 ib700wdt.c              |  311 ----------------------
 machzwd.c               |  557 ---------------------------------------
 mixcomwd.c              |  282 --------------------
 pcwd.c                  |  672 ------------------------------------------------
 sbc60xxwdt.c            |  354 -------------------------
 scx200_wdt.c            |  277 -------------------
 shwdt.c                 |  417 -----------------------------
 softdog.c               |  196 --------------
 w83877f_wdt.c           |  366 --------------------------
 watchdog/Kconfig        |  286 ++++++++++++++++++++
 watchdog/Makefile       |   27 +
 watchdog/acquirewdt.c   |  251 +++++++++++++++++
 watchdog/advantechwdt.c |  280 ++++++++++++++++++++
 watchdog/eurotechwdt.c  |  501 +++++++++++++++++++++++++++++++++++
 watchdog/i810-tco.c     |  431 ++++++++++++++++++++++++++++++
 watchdog/i810-tco.h     |   42 +++
 watchdog/ib700wdt.c     |  311 ++++++++++++++++++++++
 watchdog/machzwd.c      |  557 +++++++++++++++++++++++++++++++++++++++
 watchdog/mixcomwd.c     |  282 ++++++++++++++++++++
 watchdog/pcwd.c         |  672 ++++++++++++++++++++++++++++++++++++++++++++++++
 watchdog/sbc60xxwdt.c   |  354 +++++++++++++++++++++++++
 watchdog/scx200_wdt.c   |  277 +++++++++++++++++++
 watchdog/shwdt.c        |  417 +++++++++++++++++++++++++++++
 watchdog/softdog.c      |  196 ++++++++++++++
 watchdog/w83877f_wdt.c  |  366 ++++++++++++++++++++++++++
 watchdog/wd501p.h       |   91 ++++++
 watchdog/wdt.c          |  565 ++++++++++++++++++++++++++++++++++++++++
 watchdog/wdt285.c       |  193 +++++++++++++
 watchdog/wdt977.c       |  346 ++++++++++++++++++++++++
 watchdog/wdt_pci.c      |  653 ++++++++++++++++++++++++++++++++++++++++++++++
 wd501p.h                |   91 ------
 wdt.c                   |  565 ----------------------------------------
 wdt285.c                |  193 -------------
 wdt977.c                |  346 ------------------------
 wdt_pci.c               |  653 ----------------------------------------------

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
