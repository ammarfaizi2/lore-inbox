Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313450AbSDMNOq>; Sat, 13 Apr 2002 09:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313511AbSDMNOp>; Sat, 13 Apr 2002 09:14:45 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:60423 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313450AbSDMNOo>;
	Sat, 13 Apr 2002 09:14:44 -0400
Date: Sat, 13 Apr 2002 09:14:41 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: Yet More Watchdog Stuff
Message-ID: <Pine.LNX.4.33.0204130912040.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, you're all probably getting annoyed with the stupid watchdog driver
updates, so hopefully this can be the last announcement for a while.  Maybe.
Anyways, http://osinvestor.com/bigwatchdog-11.diff is up against
2.4.19-pre5-ac3 still.

Diff is 4400 lines long and 119k big with context.

 Documentation/pcwd-watchdog.txt       |  132 -----------
 Documentation/watchdog-api.txt        |  390 ----------------------------------
 Documentation/watchdog.txt            |  113 ---------
 Documentation/watchdog/api.txt        |  139 ++++++++++++
 Documentation/watchdog/howtowrite.txt |   62 +++++
 Documentation/watchdog/status.txt     |  137 +++++++++++
 drivers/char/acquirewdt.c             |  107 +++++----
 drivers/char/advantechwdt.c           |   95 ++++----
 drivers/char/alim7101_wdt.c           |  103 ++++----
 drivers/char/eurotechwdt.c            |   71 +++---
 drivers/char/i810-tco.c               |   80 ++++--
 drivers/char/ib700wdt.c               |   93 ++++----
 drivers/char/machzwd.c                |  103 ++++----
 drivers/char/mixcomwd.c               |   30 +-
 drivers/char/pcwd.c                   |   29 +-
 drivers/char/sbc60xxwdt.c             |  118 +++++-----
 drivers/char/sc1200wdt.c              |   95 +++++---
 drivers/char/sc520_wdt.c              |  106 +++++----
 drivers/char/shwdt.c                  |   87 ++++---
 drivers/char/softdog.c                |   42 ++-
 drivers/char/w83877f_wdt.c            |   98 ++++----
 drivers/char/wafer5823wdt.c           |   66 ++++-
 drivers/char/wdt.c                    |   39 ++-
 drivers/char/wdt285.c                 |   27 --
 drivers/char/wdt977.c                 |  139 ++++++++----
 drivers/char/wdt_pci.c                |   28 --
 drivers/sbus/char/cpwatchdog.c        |   16 -
 drivers/sbus/char/riowatchdog.c       |    6
 28 files changed, 1278 insertions(+), 1273 deletions(-)

Changes from last time include the include cleanups and fixing some minor
copy-and-paste nits.

Regards,
Rob Radez


