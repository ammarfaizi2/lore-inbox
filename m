Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbULENSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbULENSA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 08:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULENSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 08:18:00 -0500
Received: from kane.otenet.gr ([195.170.0.27]:56749 "EHLO kane.otenet.gr")
	by vger.kernel.org with ESMTP id S261302AbULENR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 08:17:57 -0500
Message-Id: <200412051317.iB5DHrOL026570@kane.otenet.gr>
From: "Nicholas Papadakos" <panic@quake.gr>
To: "'Francois Romieu'" <romieu@fr.zoreil.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: realtek r8169 + kernel 2.4.24 (openmosix)
Date: Sun, 5 Dec 2004 15:17:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20041205122414.GA22383@electric-eye.fr.zoreil.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTaxsSZIJOG3TFYTkqQ1C0UpvHbAQABTvEA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I must be doing something wrong cauz I still get the same error when I try
to apply the patch.

I use :
patch -p0 < r8169-mini-fix.patch 

patching file drivers/net/r8169.c
Hunk #1 FAILED at 1161.
1 out of 1 hunk FAILED -- saving rejects to file drivers/net/r8169.c.rej

Dump of rej file :

***************
*** 1161,1167 ****

  static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)
  {
-       desc->addr = 0x0badbadbadbadbad;
        desc->status &= ~cpu_to_le32(OWNbit | RsvdMask);
  }

--- 1161,1167 ----

  static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)
  {
+       desc->addr = 0x0badbadbadbadbadull;
        desc->status &= ~cpu_to_le32(OWNbit | RsvdMask);
  }

I saved the file from my windows machine (outlook 2003) to a samba share on
the machine needed to be patched. 
I don't believe that has anything to do with it, right ?

When commenting the line out the module did compile but It still connection
froze after a while like before.

I tried to apply the patch in both kernel versions same result.
Am I missing something ?

Thank you for your patience
Regards, 
Nicholas Papadakos








