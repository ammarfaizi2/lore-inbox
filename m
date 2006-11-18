Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756061AbWKRACj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbWKRACj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756066AbWKRACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:02:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47110 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756061AbWKRACh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:02:37 -0500
Date: Sat, 18 Nov 2006 01:02:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net, James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org,
       linuxppc-dev@ozlabs.org, sammy@sammy.net, sun3-list@redhat.com
Subject: [RFC: 2.6 patch] remove broken video drivers
Message-ID: <20061118000235.GV31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes video drivers that:
- had already been marked as BROKEN in 2.6.0 three years ago and
- are still marked as BROKEN.

These are the following drivers:
- FB_CYBER
- FB_VIRGE
- FB_RETINAZ3
- FB_ATARI
- FB_SUN3
- FB_PM3

Drivers that had been marked as BROKEN for such a long time seem to be 
unlikely to be revived in the forseeable future.

But if anyone wants to ever revive any of these drivers, the code is 
still present in the older kernel releases.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Due to it's size, the patch is available at
  http://ftp.kernel.org/pub/linux/kernel/people/bunk/misc/patch-remove-broken-video.gz

 drivers/video/Kconfig   |   62 
 drivers/video/Makefile  |    6 
 drivers/video/atafb.c   | 3107 ----------------------------------
 drivers/video/cyberfb.c | 2297 -------------------------
 drivers/video/cyberfb.h |  415 ----
 drivers/video/pm3fb.c   | 3641 ----------------------------------------
 drivers/video/retz3fb.c | 1588 -----------------
 drivers/video/retz3fb.h |  286 ---
 drivers/video/sun3fb.c  |  702 -------
 drivers/video/virgefb.c | 2526 ---------------------------
 drivers/video/virgefb.h |  288 ---
 include/video/pm3fb.h   | 1235 -------------
 12 files changed, 3 insertions(+), 16150 deletions(-)

