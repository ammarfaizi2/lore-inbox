Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWDBQkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWDBQkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWDBQj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:39:59 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:54428 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932391AbWDBQju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:39:50 -0400
Message-ID: <442FFE55.4010500@free.fr>
Date: Sun, 02 Apr 2006 18:39:49 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 3/4] UEAGLE : null pointer dereference fix
Content-Type: multipart/mixed;
 boundary="------------050005020508060106040803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050005020508060106040803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch fix potential null pointer dereference.  Found by the 
Coverity checker.

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>



--------------050005020508060106040803
Content-Type: text/plain;
 name="ueagle3.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ueagle3.patch"

Index: ueagle-atm.c
===================================================================
--- ueagle-atm.c	(révision 265)
+++ ueagle-atm.c	(révision 266)
@@ -1673,7 +1673,7 @@
 
 	sc = kzalloc(sizeof(struct uea_softc), GFP_KERNEL);
 	if (!sc) {
-		uea_err(INS_TO_USBDEV(sc), "uea_init: not enough memory !\n");
+		uea_err(usb, "uea_init: not enough memory !\n");
 		return -ENOMEM;
 	}
 

--------------050005020508060106040803--
