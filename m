Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVBWSdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVBWSdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVBWSdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:33:52 -0500
Received: from mail00.svc.cra.dublin.eircom.net ([159.134.118.16]:45067 "HELO
	mail00.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S261525AbVBWSdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:33:49 -0500
Message-ID: <421CCCEF.7000906@eircom.net>
Date: Wed, 23 Feb 2005 18:35:27 +0000
From: Telemaque Ndizihiwe <telendiz@eircom.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de, Ingo.Wilken@informatik.uni-oldenburg.de
CC: marcelo.tosatti@cyclades.com, torvalds@osdl.org, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Removes unnecessary "if" statement from drivers/block/z2ram.c
Content-Type: multipart/mixed;
 boundary="------------030105030100010204090708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030105030100010204090708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This Patch removes unnecessary "if" statement from a function without 
implementation (in kernel 2.6.x and  2.4.x),
the function returns "0" with or without the "if" statement.

Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>


--- linux-2.6.10/drivers/block/z2ram.c.orig    2005-02-23 
18:02:51.011967584 +0000
+++ linux-2.6.10/drivers/block/z2ram.c    2005-02-23 18:05:31.617551824 
+0000
@@ -304,9 +304,6 @@ err_out:
 static int
 z2_release( struct inode *inode, struct file *filp )
 {
-    if ( current_device == -1 )
-    return 0;    
-
     /*
      * FIXME: unmap memory
      */




--------------030105030100010204090708
Content-Type: text/x-patch;
 name="z2ram.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="z2ram.patch"

--- linux-2.6.10/drivers/block/z2ram.c.orig	2005-02-23 18:02:51.011967584 +0000
+++ linux-2.6.10/drivers/block/z2ram.c	2005-02-23 18:05:31.617551824 +0000
@@ -304,9 +304,6 @@ err_out:
 static int
 z2_release( struct inode *inode, struct file *filp )
 {
-    if ( current_device == -1 )
-	return 0;     
-
     /*
      * FIXME: unmap memory
      */

--------------030105030100010204090708--
