Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRIMQrJ>; Thu, 13 Sep 2001 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRIMQrE>; Thu, 13 Sep 2001 12:47:04 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:17157 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271848AbRIMQqv>; Thu, 13 Sep 2001 12:46:51 -0400
Date: Thu, 13 Sep 2001 18:39:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 7/11] Fix RIP register name collision in ixj.c
Message-ID: <20010913183928.A2615@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch changes name of one *unused* struct field (RIP) in the ixj.c
telephony driver to a different name (XRIP), because it collides with
the RIP register name on the x86-64.

--- linux/drivers/telephony/ixj.h	Thu Sep 13 16:13:23 2001
+++ linux-64-latest/drivers/telephony/ixj.h	Thu Sep 13 16:16:59 2001
@@ -574,7 +574,7 @@
 				struct _CR0_BITREGS {
 					BYTE CLK_EXT:1;		/* cr0[0:0] */
 
-					BYTE RIP:1;	/* cr0[1:1] */
+					BYTE XRIP:1;	/* cr0[1:1] */
 
 					BYTE AR:1;	/* cr0[2:2] */
 
-- 
Vojtech Pavlik
SuSE Labs

