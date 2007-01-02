Return-Path: <linux-kernel-owner+w=401wt.eu-S1754562AbXABMtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbXABMtg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbXABMtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:49:36 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:2899 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbXABMtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:49:35 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] sound: aoa of_node_put and kfree cleanup
Date: Tue, 2 Jan 2007 13:50:57 +0100
User-Agent: KMail/1.9.5
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021350.57816.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument checks for of_node_put() and kfree().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
--- linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-12-28 12:57:54.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2007-01-02 01:50:26.000000000 +0100
@@ -1034,9 +1034,9 @@ static int aoa_fabric_layout_probe(struc
 	list_del(&ldev->list);
 	layouts_list_items--;
  outnodev:
- 	if (sound) of_node_put(sound);
+ 	of_node_put(sound);
  	layout_device = NULL;
- 	if (ldev) kfree(ldev);
+ 	kfree(ldev);
 	return -ENODEV;
 }
 


-- 
Regards,

	Mariusz Kozlowski
