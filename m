Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbSKMCDh>; Tue, 12 Nov 2002 21:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267100AbSKMCDh>; Tue, 12 Nov 2002 21:03:37 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:38673
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267097AbSKMCDg>; Tue, 12 Nov 2002 21:03:36 -0500
Date: Tue, 12 Nov 2002 21:04:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] init_timer for smc91c92cs_cs.c
Message-ID: <Pine.LNX.4.44.0211122055220.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.47/drivers/net/pcmcia/smc91c92_cs.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.47/drivers/net/pcmcia/smc91c92_cs.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smc91c92_cs.c
--- linux-2.5.47/drivers/net/pcmcia/smc91c92_cs.c	11 Nov 2002 03:57:06 -0000	1.1.1.1
+++ linux-2.5.47/drivers/net/pcmcia/smc91c92_cs.c	13 Nov 2002 00:02:49 -0000
@@ -358,6 +358,7 @@
     memset(smc, 0, sizeof(struct smc_private));
     link = &smc->link; dev = &smc->dev;
     spin_lock_init(&smc->lock);
+    init_timer(&link->release);
     link->release.function = &smc91c92_release;
     link->release.data = (u_long)link;
     link->io.NumPorts1 = 16;

-- 
function.linuxpower.ca


