Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314155AbSDLWv4>; Fri, 12 Apr 2002 18:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314156AbSDLWvz>; Fri, 12 Apr 2002 18:51:55 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:58631 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S314155AbSDLWvy>;
	Fri, 12 Apr 2002 18:51:54 -0400
Date: Fri, 12 Apr 2002 18:51:50 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: See Spot Updates (More Watchdog stuff)
Message-ID: <Pine.LNX.4.33.0204121839030.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See Spot.  See Spot Run.  Run Spot Run.

I've put up the newest set of my watchdog updates at:
http://osinvestor.com/bigwatchdog-9.diff
It's still against 2.4.19-pre5-ac3.

The diff is now 108k and 4000 lines long with context.

 Documentation/pcwd-watchdog.txt       |  132 -----------
 Documentation/watchdog-api.txt        |  390 ----------------------------------
 Documentation/watchdog.txt            |  113 ---------
 Documentation/watchdog/api.txt        |  139 ++++++++++++
 Documentation/watchdog/howtowrite.txt |   62 +++++
 Documentation/watchdog/status.txt     |  137 +++++++++++
 drivers/char/acquirewdt.c             |  100 +++++---
 drivers/char/advantechwdt.c           |   88 ++++---
 drivers/char/alim7101_wdt.c           |   85 ++++---
 drivers/char/eurotechwdt.c            |   65 +++--
 drivers/char/i810-tco.c               |   77 ++++--
 drivers/char/ib700wdt.c               |   87 ++++---
 drivers/char/machzwd.c                |   96 ++++----
 drivers/char/mixcomwd.c               |   28 +-
 drivers/char/pcwd.c                   |   25 +-
 drivers/char/sbc60xxwdt.c             |  113 +++++----
 drivers/char/sc1200wdt.c              |   83 ++++---
 drivers/char/sc520_wdt.c              |  102 +++++---
 drivers/char/shwdt.c                  |   86 ++++---
 drivers/char/softdog.c                |   36 ++-
 drivers/char/w83877f_wdt.c            |   94 ++++----
 drivers/char/wafer5823wdt.c           |   65 ++++-
 drivers/char/wdt.c                    |   35 ++-
 drivers/char/wdt285.c                 |   26 --
 drivers/char/wdt977.c                 |  137 ++++++++---
 drivers/char/wdt_pci.c                |   25 --
 drivers/sbus/char/riowatchdog.c       |    6
 27 files changed, 1246 insertions(+), 1186 deletions(-)

The latest changes include a bunch of updates to inline comments and a fix for
(yet another) stupid error I introduced.  Next up on my todo list so people
know (especially if they want to help) is seeing if there's any way to
reduce the includes in all of these files.  After that I guess I'll send
individual patches off to any current maintainers, and just tag which files
are unmaintained, and then see about syncing up 2.4 and 2.5.

Regards,
Rob Radez


