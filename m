Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUC1ThM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUC1ThM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:37:12 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:28691 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262389AbUC1ThH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:37:07 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6]: suspend to disk only available if non-modular IDE
Date: Sun, 28 Mar 2004 21:36:55 +0200
User-Agent: KMail/1.6.1
Cc: swsusp-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403282136.55435.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

resume from disk doesn't work when using modular IDE so this patch disables
this in config:

--- kernel/power/Kconfig~       2004-03-28 21:32:03.198944320 +0200
+++ kernel/power/Kconfig        2004-03-28 21:32:25.988479784 +0200
@@ -44,7 +44,7 @@

 config PM_DISK
        bool "Suspend-to-Disk Support"
-       depends on PM && SWAP
+       depends on PM && SWAP && IDE=y && BLK_DEV_IDEDISK=y
        ---help---
          Suspend-to-disk is a power management state in which the contents
          of memory are stored on disk and the entire system is shut down or

Info here:
http://groups.google.com/groups?selm=1BdIH-5WB-17%40gated-at.bofh.it&oe=UTF-8&output=gplain
-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
