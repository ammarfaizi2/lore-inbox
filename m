Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUBKVxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUBKVxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:53:43 -0500
Received: from elektra.telenet-ops.be ([195.130.132.49]:14829 "EHLO
	elektra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266172AbUBKVwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:52:40 -0500
Date: Wed, 11 Feb 2004 22:46:45 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
       Guido Guenther <agx@sigxcpu.org>
Subject: [WATCHDOG] v2.6.2 patches
Message-ID: <20040211224645.A25177@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/i810-tco.c     |  437 ----------------------
 drivers/char/watchdog/i810-tco.h     |   42 --
 arch/m68k/Kconfig                    |   45 --
 arch/sh/Kconfig                      |   56 --
 arch/sparc/Kconfig                   |   15 
 arch/sparc64/Kconfig                 |   15 
 drivers/char/watchdog/Kconfig        |  506 ++++++++++++++------------
 drivers/char/watchdog/Makefile       |    4 
 drivers/char/watchdog/acquirewdt.c   |   59 ++-
 drivers/char/watchdog/advantechwdt.c |    2 
 drivers/char/watchdog/alim1535_wdt.c |    1 
 drivers/char/watchdog/alim7101_wdt.c |    1 
 drivers/char/watchdog/amd7xx_tco.c   |    2 
 drivers/char/watchdog/i8xx_tco.c     |  510 ++++++++++++++++++++++++++
 drivers/char/watchdog/i8xx_tco.h     |   42 ++
 drivers/char/watchdog/indydog.c      |  111 ++++-
 drivers/char/watchdog/pcwd_pci.c     |  681 +++++++++++++++++++++++++++++++++++
 drivers/char/watchdog/sbc60xxwdt.c   |    1 
 drivers/char/watchdog/sc520_wdt.c    |    1 
 drivers/char/watchdog/scx200_wdt.c   |    1 
 drivers/char/watchdog/shwdt.c        |  131 ++++--
 drivers/char/watchdog/softdog.c      |    5 
 drivers/char/watchdog/wafer5823wdt.c |    1 
 23 files changed, 1764 insertions(+), 905 deletions(-)

through these ChangeSets:

<willy@debian.org> (04/02/11 1.1613)
   [WATCHDOG] v2.6.2 watchdog-architecture-cleanup
   
   In order to make the watchdog menu useful for some architectures, we need
   to only be able to select the watchdogs that can compile.  This patch also
   moves the SuperH watchdog from its own Kconfig file to the normal one.

<wim@iguana.be> (04/02/11 1.1614)
   [WATCHDOG] v2.6.2 shwdt-cleanup
   
   Make heartbeat a module parameter and some general clean-up.

<wim@iguana.be> (04/02/11 1.1615)
   [WATCHDOG] v2.6.2 watchdog-module_*-update
   
   Update MODULE_* information

<wim@iguana.be> (04/02/11 1.1616)
   [WATCHDOG] v2.6.2 acquirewdt-cleanup
   
   small cleanup

<wim@iguana.be> (04/02/11 1.1617)
   [WATCHDOG] v2.6.2 indydog-v0.3_update
   
   Added notifier support
   Moved start and stop code to their own subroutines
   Extended ioctl support
   Add MODULE_* info

<wim@iguana.be> (04/02/11 1.1618)
   [WATCHDOG] v2.6.2 i8xx_tco-v0.06_update
   
   Version 0.06 of the intel i8xx TCO driver:
   * change i810_margin to heartbeat (in seconds)
   * use module_param
   * added notify system support
   * renamed module to i8xx_tco

<wim@iguana.be> (04/02/11 1.1619)
   [WATCHDOG] v2.6.2 watchdog-Kconfig-patch
   
   Cleanup/Restructuring of drivers/char/watchdog/Kconfig

<wim@iguana.be> (04/02/11 1.1620)
   [WATCHDOG] v2.6.2 indydog-Kconfig+Makefile-patch
   
   Apparently we ported the indydog code to the 2.5/2.6 kernel series,
   but we forgot to put it in the kernel configuration file + the Makefile

<wim@iguana.be> (04/02/11 1.1621)
   [WATCHDOG] v2.6.2 pcwd_pci-watchdog
   
   Add the Berkshire Products PCI-PC Watchdog driver

<wim@iguana.be> (04/02/11 1.1622)
   [WATCHDOG] v2.6.2 arch-[m68k/sparc/sparc64]-Kconfig-patch
   
   Source WATCHDOG config info from drivers/char/watchdog/Kconfig
   for m68k, sparc and sparc64 architectures


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

Greetings,
Wim.

