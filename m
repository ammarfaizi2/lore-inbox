Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSEaAT2>; Thu, 30 May 2002 20:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSEaAT1>; Thu, 30 May 2002 20:19:27 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:57611 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313070AbSEaAT0>;
	Thu, 30 May 2002 20:19:26 -0400
Date: Thu, 30 May 2002 20:19:23 -0400
From: Rob Radez <rob@osinvestor.com>
To: linux-kernel@vger.kernel.org
Subject: Watchdog Updates
Message-ID: <20020530201923.Q30977@osinvestor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, new version and location of the big watchdog patch.  Work continues on
getting it integrated into the mainline kernel.  Patches are now at
http://junker.org/~rradez/wd/
Patches are against 2.4.19-pre9 and 2.4.19-pre9-ac3.  Little is changed
functionally, just a resync against newer kernels.  The patches are a lot
smaller this time since Marcelo took the changes to advantechwdt.c and
sc1200wdt.c.  Diffstat follows.

 Documentation/pcwd-watchdog.txt       |  132 ---
 Documentation/watchdog-api.txt        |  390 -----------
 Documentation/watchdog.txt            |  113 ---
 Documentation/watchdog/api.txt        |  148 ++++
 Documentation/watchdog/howtowrite.txt |   78 ++
 Documentation/watchdog/status.txt     |  151 ++++
 drivers/char/acquirewdt.c             |  173 +++--
 drivers/char/alim7101_wdt.c           |  121 +--
 drivers/char/i810-tco.c               |  104 +--
 drivers/char/i810-tco.h               |   10 
 drivers/char/ib700wdt.c               |  164 ++--
 drivers/char/indydog.c                |   57 +
 drivers/char/machzwd.c                |  147 ++--
 drivers/char/mixcomwd.c               |   91 +-
 drivers/char/pcwd.c                   | 1159 +++++++++++++++++++++-------------
 drivers/char/sbc60xxwdt.c             |  213 +++---
 drivers/char/sc520_wdt.c              |  142 ++--
 drivers/char/softdog.c                |   79 +-
 drivers/char/w83877f_wdt.c            |  135 ++-
 drivers/char/wafer5823wdt.c           |  125 ++-
 drivers/char/wdt.c                    |   46 -
 drivers/char/wdt285.c                 |   73 --
 drivers/char/wdt977.c                 |  153 +++-
 drivers/char/wdt_pci.c                |   45 -
 drivers/sbus/char/cpwatchdog.c        |   16 
 drivers/sbus/char/riowatchdog.c       |    6 
 26 files changed, 2204 insertions(+), 1867 deletions(-)

Regards,
Rob Radez
