Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWATGJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWATGJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWATGIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:08:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:5527 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422689AbWATGIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:08:07 -0500
Cc: bunk@stusta.de
Subject: [PATCH] W1: fix W1_MASTER_DS9490_BRIDGE dependencies
In-Reply-To: <11377372364116@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jan 2006 22:07:16 -0800
Message-Id: <11377372363607@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] W1: fix W1_MASTER_DS9490_BRIDGE dependencies

W1_DS9490 was renamed to W1_MASTER_DS9490, but the entry in the
dependencies of W1_MASTER_DS9490_BRIDGE was forgotten.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b6036c958a190777a16e89dc53088bd9fabfc2ff
tree 1583be4e025a9574b08ae7d8041edee0dafd7dc9
parent 41e00d8d7535fc78425b8ac2436a7be3d4d2ccdf
author Adrian Bunk <bunk@stusta.de> Fri, 06 Jan 2006 18:41:01 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 19 Jan 2006 21:53:26 -0800

 drivers/w1/masters/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 1ff11b5..c6bad4d 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -26,7 +26,7 @@ config W1_MASTER_DS9490
 
 config W1_MASTER_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
-	depends on W1_DS9490
+	depends on W1_MASTER_DS9490
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using DS9490R USB bridge.

