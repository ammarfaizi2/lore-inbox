Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263871AbUEXDiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUEXDiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 23:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUEXDiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 23:38:51 -0400
Received: from ktown.kde.org ([131.246.103.200]:11911 "HELO ktown.kde.org")
	by vger.kernel.org with SMTP id S263871AbUEXDit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 23:38:49 -0400
Date: Mon, 24 May 2004 05:38:47 +0200
From: Oswald Buddenhagen <ossi@kde.org>
To: linux-kernel@vger.kernel.org
Subject: (one more) PCI quirk for SMBus bridge on Asus P4 boards
Message-ID: <20040524033847.GA906@ugly.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

heya,

my board has one of those "clever" bioses that hide the smbus. this tiny
patch adds it to the Bad Guy List (TM).

greetings

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quirks.c.diff"

--- quirks.c.orig	2004-05-24 05:35:42.000000000 +0200
+++ quirks.c	2004-05-24 05:25:49.000000000 +0200
@@ -705,6 +705,7 @@
 		}
 	if (dev->device == PCI_DEVICE_ID_INTEL_82845G_HB)
 		switch(dev->subsystem_device) {
+ 		case 0x80b1: /* P4GE-V */
 		case 0x80b2: /* P4PE */
  		case 0x8093: /* P4B533-V */
 			asus_hides_smbus = 1;

--7AUc2qLy4jB3hD7Z--
