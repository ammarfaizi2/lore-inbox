Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWASRtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWASRtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWASRtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:49:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4868 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751374AbWASRtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:49:12 -0500
Date: Thu, 19 Jan 2006 18:49:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Michael H. Warfield" <mhw@WittsEnd.com>
Subject: [git patch] Move ip2.c and ip2main.c to drivers/char/ip2/
Message-ID: <20060119174911.GV19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following change:

    Move ip2.c and ip2main.c to drivers/char/ip2/ where the other files
    used by this driver reside.
    
    Renamed ip2.c to ip2base.c to allow ip2.o to be built from multiple
    objects.
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Acked-by: Michael H. Warfield <mhw@WittsEnd.com>


The diffstat is big, but changes are actually only:
- move ip2.c and ip2main.c to drivers/char/ip2/
- rename ip2.c to ip2base.c (the module is still called ip2)
- adjust some #include's in the moved files to the new location

Further cleanup patches will go the usual way through Michael/Andrew, 
but this straightforward moving of files should be done through git.


 drivers/char/Makefile      |    2 
 drivers/char/ip2.c         |  109 -
 drivers/char/ip2/Makefile  |    8 
 drivers/char/ip2/ip2base.c |  109 +
 drivers/char/ip2/ip2main.c | 3260 +++++++++++++++++++++++++++++++++++++
 drivers/char/ip2main.c     | 3260 -------------------------------------
 6 files changed, 3378 insertions(+), 3370 deletions(-)


