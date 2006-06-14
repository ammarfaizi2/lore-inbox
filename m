Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWFNWX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWFNWX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWFNWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:23:27 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:52798 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964813AbWFNWXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:23:03 -0400
Message-ID: <44909A69.2070407@oracle.com>
Date: Wed, 14 Jun 2006 16:23:21 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
CC: akpm <akpm@osdl.org>, perex@suse.cz
Subject: [Ubuntu PATCH] sound/pci/: Add hp_only quirk for Dell D800 laptops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: crimsun@fungus.sh.nu <crimsun@fungus.sh.nu>

[UBUNTU:sound/pci/] Add hp_only quirk for Dell D800 laptops

UpstreamStatus: Not merged
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=9ad787cd9670c3f3b8f3db235e84baf00a2ea526

Anders Ostling comments in Malone #41015 that his Dell D800 laptop's
volume control works correctly when the hp_only quirk is passed to
modprobe. This commit adds his hardware's sub{vendor,device} ids to
the quirk list for the intel8x0 driver.

Signed-off-by: Daniel T Chen <crimsun@ubuntu.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1758,6 +1758,12 @@ static struct ac97_quirk ac97_quirks[] _
 	},
 	{
 		.subvendor = 0x1028,
+		.subdevice = 0x014e,
+		.name = "Dell D800", /* STAC9750/51 */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.subvendor = 0x1028,
 		.subdevice = 0x0163,
 		.name = "Dell Unknown",	/* STAC9750/51 */
 		.type = AC97_TUNE_HP_ONLY

