Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271619AbRIJTXD>; Mon, 10 Sep 2001 15:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271621AbRIJTWy>; Mon, 10 Sep 2001 15:22:54 -0400
Received: from TK157251.telekabel.at ([195.34.157.251]:34809 "EHLO purple-haze")
	by vger.kernel.org with ESMTP id <S271619AbRIJTWp>;
	Mon, 10 Sep 2001 15:22:45 -0400
Date: Mon, 10 Sep 2001 21:23:04 +0200
From: Thomas Krennwallner <krennwallner@aon.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] apm, 2.4.9
Message-ID: <20010910212304.A1167@purple-haze>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.9 on an i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Just found out that either apm=on or apm=off supplied as bootparam
turns apm off. No bootparam enables apm.

So long
Thomas

-- 
  ___    Obviously we do not want to leave zombies around.
_/___\     - W. Richard Stevens
 ( ^ >
 /   \   Thomas Krennwallner <krennwallner at aon dot at>
(__\/_)_ Fingerprint: 9484 D99D 2E1E 4E02 5446  DAD9 FF58 4E59 67A1 DA7B

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="apm-bootparam-2.4.9.patch"

--- linux-2.4.9/arch/i386/kernel/apm.c	Tue Aug 14 01:39:28 2001
+++ linux/arch/i386/kernel/apm.c	Fri Sep  7 10:41:59 2001
@@ -1652,7 +1652,7 @@
 	if (realmode_power_off)
 		apm_info.realmode_power_off = 1;
 	/* User can override, but default is to trust DMI */
-	if (apm_disabled != -1)
+	if (apm_disabled > 0)
 		apm_info.disabled = 1;
 
 	/*

--9amGYk9869ThD9tj--
