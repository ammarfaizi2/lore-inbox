Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313789AbSDPRtb>; Tue, 16 Apr 2002 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313790AbSDPRta>; Tue, 16 Apr 2002 13:49:30 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:9224 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313789AbSDPRt2>;
	Tue, 16 Apr 2002 13:49:28 -0400
Date: Tue, 16 Apr 2002 13:49:24 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Watchdog Updates
Message-ID: <Pine.LNX.4.33.0204161320110.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hah, like I'm going to attach two >100k patches to a mail going to l-k.
It's that time of day again, and instead of just one patch, I have two.
Not only that, but I only just now noticed the indydog driver, so that's
got some updates in here too.  Plus, the patches this time include the
meaning of life, the universe, and everything.  I've changed the format
of the patch slightly this time, in hopes of getting it applied sometime
soon.  So, I've put up two patches.

http://osinvestor.com/wd-2.4.19-pre5-ac3-2.diff is against, you guessed it,
2.4.19-pre5-ac3, but also includes some minor update bits from
2.4.19-pre7 (only the i810-tco changes since the other changes are bogus).

http://osinvestor.com/wd-2.4.19-pre7-2.diff is against pre7, but also
includes Lindsay Harris' pcwd rewrite that is currently in -ac.

Below is the diffstat of wd-2.4.19-pre7-2.diff:

 Documentation/pcwd-watchdog.txt       |  132 ---
 Documentation/watchdog-api.txt        |  390 -----------
 Documentation/watchdog.txt            |  113 ---
 Documentation/watchdog/api.txt        |  139 ++++
 Documentation/watchdog/howtowrite.txt |   73 ++
 Documentation/watchdog/status.txt     |  144 ++++
 drivers/char/acquirewdt.c             |  107 +--
 drivers/char/advantechwdt.c           |   95 +-
 drivers/char/alim7101_wdt.c           |  107 +--
 drivers/char/eurotechwdt.c            |   71 +-
 drivers/char/i810-tco.c               |   82 +-
 drivers/char/ib700wdt.c               |   93 +-
 drivers/char/indydog.c                |   11
 drivers/char/machzwd.c                |  109 +--
 drivers/char/mixcomwd.c               |   30
 drivers/char/pcwd.c                   | 1147 +++++++++++++++++++++-------------
 drivers/char/sbc60xxwdt.c             |  127 +--
 drivers/char/sc1200wdt.c              |   99 +-
 drivers/char/sc520_wdt.c              |  110 +--
 drivers/char/shwdt.c                  |   87 +-
 drivers/char/softdog.c                |   43 -
 drivers/char/w83877f_wdt.c            |  103 +--
 drivers/char/wafer5823wdt.c           |   66 +
 drivers/char/wdt.c                    |   39 -
 drivers/char/wdt285.c                 |   27
 drivers/char/wdt977.c                 |  139 ++--
 drivers/char/wdt_pci.c                |   32
 drivers/sbus/char/cpwatchdog.c        |   16
 drivers/sbus/char/riowatchdog.c       |    6
 29 files changed, 2012 insertions(+), 1725 deletions(-)

Regards,
Rob Radez


