Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270714AbTHAKo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273031AbTHAKo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:44:27 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:54545 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270714AbTHAKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:20 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] Cleanup SCSI lowlevel driver submenu
Date: Fri, 1 Aug 2003 12:39:46 +0200
User-Agent: KMail/1.5.2
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200307312215.57784.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yNkK/DSepkLGL1b"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yNkK/DSepkLGL1b
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

I've been getting complaints about the menu structure from the linux kernel 
config subsystem for a _long time_. Now let's clean up the SCSI lowlevel 
driver submenu. It's now possible to select/deselect SCSI lowlevel drivers at 
once.

More cleanups for different menu's are following.

Please apply for 2.4.22-pre10. Thank you :)

ciao, Marc

--Boundary-00=_yNkK/DSepkLGL1b
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-scsi-config-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-scsi-config-cleanup.patch"

--- a/drivers/scsi/Config.in	2002-12-31 09:39:19.000000000 +0100
+++ b/drivers/scsi/Config.in	2002-12-31 10:02:27.000000000 +0100
@@ -31,6 +31,8 @@ bool '  SCSI logging facility' CONFIG_SC
 
 mainmenu_option next_comment
 comment 'SCSI low-level drivers'
+bool 'SCSI low-level drivers' CONFIG_SCSI_LOWLEVEL
+if [ "$CONFIG_SCSI_LOWLEVEL" != "n" ]; then
 
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    dep_tristate 'SGI WD93C93 SCSI Driver' CONFIG_SGIWD93_SCSI $CONFIG_SCSI
@@ -257,6 +259,8 @@ if [ "$CONFIG_ZORRO" = "y" ]; then
    fi
 fi
 
+fi
+
 endmenu
 
 if [ "$CONFIG_HOTPLUG" = "y" -a "$CONFIG_PCMCIA" != "n" ]; then

--Boundary-00=_yNkK/DSepkLGL1b--


