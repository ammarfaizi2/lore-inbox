Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUKMWjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUKMWjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUKMWjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:39:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:61579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261184AbUKMWj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:39:27 -0500
Message-ID: <41968CBC.2050301@osdl.org>
Date: Sat, 13 Nov 2004 14:37:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi/mesh: module_param corrections
References: <200411112325.iABNPsWo013185@hera.kernel.org> <Pine.GSO.4.61.0411121232570.27077@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0411121232570.27077@waterleaf.sonytel.be>
Content-Type: multipart/mixed;
 boundary="------------020607040401080206070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607040401080206070107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Correct MODULE_PARM to module_param (somehow I changed the
macro parameters but not the macro invocation).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  drivers/scsi/mesh.c |   10 +++++-----
  1 files changed, 5 insertions(+), 5 deletions(-)


-- 

--------------020607040401080206070107
Content-Type: text/x-patch;
 name="mesh_modprm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mesh_modprm.patch"

diff -Naurp ./drivers/scsi/mesh.c~mesh_modprm ./drivers/scsi/mesh.c
--- ./drivers/scsi/mesh.c~mesh_modprm	2004-11-13 14:19:12.141219000 -0800
+++ ./drivers/scsi/mesh.c	2004-11-13 14:31:47.915324320 -0800
@@ -66,15 +66,15 @@ static int resel_targets = 0xff;
 static int debug_targets = 0;	/* print debug for these targets */
 static int init_reset_delay = CONFIG_SCSI_MESH_RESET_DELAY_MS;
 
-MODULE_PARM(sync_rate, int, 0);
+module_param(sync_rate, int, 0);
 MODULE_PARM_DESC(sync_rate, "Synchronous rate (0..10, 0=async)");
-MODULE_PARM(sync_targets, int, 0);
+module_param(sync_targets, int, 0);
 MODULE_PARM_DESC(sync_targets, "Bitmask of targets allowed to set synchronous");
-MODULE_PARM(resel_targets, int, 0);
+module_param(resel_targets, int, 0);
 MODULE_PARM_DESC(resel_targets, "Bitmask of targets allowed to set disconnect");
-MODULE_PARM(debug_targets, int, 0644);
+module_param(debug_targets, int, 0644);
 MODULE_PARM_DESC(debug_targets, "Bitmask of debugged targets");
-MODULE_PARM(init_reset_delay, int, 0);
+module_param(init_reset_delay, int, 0);
 MODULE_PARM_DESC(init_reset_delay, "Initial bus reset delay (0=no reset)");
 
 static int mesh_sync_period = 100;

--------------020607040401080206070107--
