Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVIVHvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVIVHvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVIVHuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:37555 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751449AbVIVHuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:50:25 -0400
Date: Thu, 22 Sep 2005 00:49:45 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: [patch 17/18] ub: Comment out unconditional stall clear
Message-ID: <20050922074944.GR15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ub-fix-ipaq.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Zaitcev <zaitcev@redhat.com>

This code appears to be more trouble than it's worth, considering that
no normal users reload drivers. So, we comment it for now. It is not
removed outright for the benefit of hackers (that is, myself).

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/block/ub.c |    2 ++
 1 file changed, 2 insertions(+)

--- scsi-2.6.orig/drivers/block/ub.c	2005-09-21 17:29:38.000000000 -0700
+++ scsi-2.6/drivers/block/ub.c	2005-09-21 17:29:54.000000000 -0700
@@ -2217,8 +2217,10 @@
 	 * This is needed to clear toggles. It is a problem only if we do
 	 * `rmmod ub && modprobe ub` without disconnects, but we like that.
 	 */
+#if 0 /* iPod Mini fails if we do this (big white iPod works) */
 	ub_probe_clear_stall(sc, sc->recv_bulk_pipe);
 	ub_probe_clear_stall(sc, sc->send_bulk_pipe);
+#endif
 
 	/*
 	 * The way this is used by the startup code is a little specific.

--
