Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVI2PsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVI2PsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVI2PsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:48:19 -0400
Received: from aveiro.procergs.com.br ([200.198.128.42]:52965 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S932156AbVI2PsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:48:18 -0400
From: Otavio Salvador <otavio@debian.org>
To: Phil Dibowitz <phil@ipom.com>, Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linus TorvaldsLinus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.14] Support to a new USB Flash Disk
Organization: OS Systems Ltda.
X-URL: http://www.debian.org/~otavio/
X-Attribution: OS
Date: Thu, 29 Sep 2005 12:48:52 -0300
Message-ID: <87ek7727tn.fsf@nurf.casa>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I include the entry to one usb flash disk that had problem here. I
think is really good to include it on 2.6.14 since its very trivial
and worked fine here.

Thanks in advance,

Signed-off-by: Otavio Salvador <otavio@debian.org>
---
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1093,3 +1093,10 @@ UNUSUAL_DEV(  0x55aa, 0xa103, 0x0000, 0x
                US_SC_SCSI, US_PR_SDDR55, NULL,
                US_FL_SINGLE_LUN),
 #endif
+
+/* Reported by Otavio Salvador <otavio@debian.org */
+UNUSUAL_DEV(  0x10d6, 0x1100, 0x0000, 0x9999,
+               "USB",
+               "Flash Disk",
+               US_SC_DEVICE, US_PR_DEVICE, NULL,
+               US_FL_IGNORE_RESIDUE ),

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
