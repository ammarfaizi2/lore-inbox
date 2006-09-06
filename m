Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWIFXP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWIFXP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWIFXP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:15:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:59595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964815AbWIFXAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:55 -0400
Date: Wed, 6 Sep 2006 15:55:03 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, rpurdie@rpsys.net,
       linux@dominikbrodowski.net, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/37] spectrum_cs: Fix firmware uploading errors
Message-ID: <20060906225503.GC15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="spectrum_cs-fix-firmware-uploading-errors.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Richard Purdie <rpurdie@rpsys.net>

This fixes firmware upload failures which prevent the driver from working.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/wireless/spectrum_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.11.orig/drivers/net/wireless/spectrum_cs.c
+++ linux-2.6.17.11/drivers/net/wireless/spectrum_cs.c
@@ -245,7 +245,7 @@ spectrum_reset(struct pcmcia_device *lin
 	u_int save_cor;
 
 	/* Doing it if hardware is gone is guaranteed crash */
-	if (pcmcia_dev_present(link))
+	if (!pcmcia_dev_present(link))
 		return -ENODEV;
 
 	/* Save original COR value */

--
