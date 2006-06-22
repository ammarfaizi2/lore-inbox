Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWFVV3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWFVV3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWFVV3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:29:24 -0400
Received: from xenotime.net ([66.160.160.81]:27048 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030406AbWFVV3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:29:23 -0400
Date: Thu, 22 Jun 2006 14:32:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] parport: add to kernel-doc
Message-Id: <20060622143207.adf9cea6.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add parport interfaces to kernel-doc template.
Small doc. cleanups in 2 parport source files.


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    9 ++++++++-
 drivers/parport/daisy.c               |    2 +-
 drivers/parport/share.c               |    2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

--- linux-2617-g4.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-g4/Documentation/DocBook/kernel-api.tmpl
@@ -390,7 +390,6 @@ X!Edrivers/pnp/system.c
      </sect1>
   </chapter>
 
-
   <chapter id="blkdev">
      <title>Block Devices</title>
 !Eblock/ll_rw_blk.c
@@ -401,6 +400,14 @@ X!Edrivers/pnp/system.c
 !Edrivers/char/misc.c
   </chapter>
 
+  <chapter id="parportdev">
+     <title>Parallel Port Devices</title>
+!Iinclude/linux/parport.h
+!Edrivers/parport/ieee1284.c
+!Edrivers/parport/share.c
+!Idrivers/parport/daisy.c
+  </chapter>
+
   <chapter id="viddev">
      <title>Video4Linux</title>
 !Edrivers/media/video/videodev.c
--- linux-2617-g4.orig/drivers/parport/daisy.c
+++ linux-2617-g4/drivers/parport/daisy.c
@@ -283,7 +283,7 @@ void parport_close (struct pardevice *de
  *
  *	This tries to locate a device on the given parallel port,
  *	multiplexor port and daisy chain address, and returns its
- *	device number or -NXIO if no device with those coordinates
+ *	device number or %-ENXIO if no device with those coordinates
  *	exists.
  **/
 
--- linux-2617-g4.orig/drivers/parport/share.c
+++ linux-2617-g4/drivers/parport/share.c
@@ -218,7 +218,7 @@ static void free_port (struct parport *p
  *	parport_get_port - increment a port's reference count
  *	@port: the port
  *
- *	This ensure's that a struct parport pointer remains valid
+ *	This ensures that a struct parport pointer remains valid
  *	until the matching parport_put_port() call.
  **/
 


---
