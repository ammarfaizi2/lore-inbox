Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbUKQTgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUKQTgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbUKQTeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:34:11 -0500
Received: from colino.net ([213.41.131.56]:46833 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262408AbUKQTcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:32:24 -0500
Date: Wed, 17 Nov 2004 20:31:39 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: hotplug_path no longer exported
Message-ID: <20041117203139.7c9f5e95.colin@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

hotplug_path is no longer exported, is this on purpose ? It breaks 
linux-wlan-ng. If it is on purpose, I suppose linux-wlan-ng 
should use kobject_hotplug() ? If not, here's a patch.

Signed-off-by: Colin Leroy <colin@colino.net>
--- lib/kobject_uevent.c.orig	2004-11-17 20:31:02.258535288 +0100
+++ lib/kobject_uevent.c	2004-11-17 20:28:12.341366624 +0100
@@ -312,6 +312,7 @@
 	return;
 }
 EXPORT_SYMBOL(kobject_hotplug);
+EXPORT_SYMBOL(hotplug_path);
 
 /**
  * add_hotplug_env_var - helper for creating hotplug environment variables
