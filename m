Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314018AbSDKKfs>; Thu, 11 Apr 2002 06:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314019AbSDKKfr>; Thu, 11 Apr 2002 06:35:47 -0400
Received: from arm.t19.ds.pwr.wroc.pl ([156.17.236.105]:7441 "EHLO misie.k.pl")
	by vger.kernel.org with ESMTP id <S314018AbSDKKfr> convert rfc822-to-8bit;
	Thu, 11 Apr 2002 06:35:47 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: atyfb on 2.4.18
X-Attribution: arekm
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
Organization: PLD Linux Distribution Team
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Date: 11 Apr 2002 12:35:45 +0200
Message-ID: <87ofgqjzem.fsf@arm.t19.ds.pwr.wroc.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without this compilation of atyfb on powerpc using gcc 2.95.4 prerelease
fails. Unfortunately I'm not sure if this patch is really correct. Is it?

--- linux/drivers/video/aty/atyfb_base.c~	Mon Feb 25 19:38:07 2002
+++ linux/drivers/video/aty/atyfb_base.c	Thu Apr 11 10:04:45 2002
@@ -310,7 +310,7 @@
     const char *name;
     int pll, mclk;
     u32 features;
-} aty_chips[] __initdata = {
+} aty_chips[] __devinitdata = {
 #ifdef CONFIG_FB_ATY_GX
     /* Mach64 GX */
     { 0x4758, 0x00d7, 0x00, 0x00, m64n_gx,      135,  50, M64F_GX },

-- 
Arkadiusz Mi¶kiewicz   IPv6 ready PLD Linux at http://www.pld.org.pl
misiek(at)pld.org.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PWr

