Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWDBQou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWDBQou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWDBQot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:44:49 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:56467 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932394AbWDBQos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:44:48 -0400
Message-ID: <442FFF80.9090205@free.fr>
Date: Sun, 02 Apr 2006 18:44:48 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: Re: [PATCH 3/4] UEAGLE : null pointer dereference fix
References: <442FFE55.4010500@free.fr>
In-Reply-To: <442FFE55.4010500@free.fr>
Content-Type: multipart/mixed;
 boundary="------------060107010003060607050606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060107010003060607050606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Hi,
> 
> this patch fix potential null pointer dereference.  Found by the 
> Coverity checker.
> 

add correct path for the file name

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------060107010003060607050606
Content-Type: text/plain;
 name="ueagle3.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ueagle3.patch"

Index: ueagle-atm.c
===================================================================
--- linux-2.6.15.old/drivers/usb/atm/ueagle-atm.c	(révision 265)
+++ linux-2.6.15/drivers/usb/atm/ueagle-atm.c	(révision 266)
@@ -1673,7 +1673,7 @@
 
 	sc = kzalloc(sizeof(struct uea_softc), GFP_KERNEL);
 	if (!sc) {
-		uea_err(INS_TO_USBDEV(sc), "uea_init: not enough memory !\n");
+		uea_err(usb, "uea_init: not enough memory !\n");
 		return -ENOMEM;
 	}
 

--------------060107010003060607050606--
