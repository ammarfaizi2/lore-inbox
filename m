Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbULEBYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbULEBYR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 20:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULEBYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 20:24:17 -0500
Received: from kane.otenet.gr ([195.170.0.27]:32913 "EHLO kane.otenet.gr")
	by vger.kernel.org with ESMTP id S261221AbULEBYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 20:24:12 -0500
Message-Id: <200412050124.iB51O6Ym014932@kane.otenet.gr>
From: "Nicholas Papadakos" <panic@quake.gr>
To: "'Francois Romieu'" <romieu@fr.zoreil.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: realtek r8169 + kernel 2.4.24 (openmosix)
Date: Sun, 5 Dec 2004 00:41:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20041204173327.GA4026@electric-eye.fr.zoreil.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTaJ4CjG2zSD3+nT52+xPMIqBAq0AAKmSuQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I commented out the line recompiled but still same problem.
I couldn't apply the patch because whenever I tried I got :

patch -p0 < rtl 
patching file drivers/net/r8169.c
Hunk #1 FAILED at 1161.
1 out of 1 hunk FAILED -- saving rejects to file drivers/net/r8169.c.rej


A dump of r8169.c.rej :


***************
*** 1161,1167 ****

  static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)  {
-       desc->addr = 0x0badbadbadbadbad;
        desc->status &= ~cpu_to_le32(OWNbit | RsvdMask);  }



--- 1161,1167 ----

  static inline void rtl8169_make_unusable_by_asic(struct RxDesc *desc)  {
+       desc->addr = 0x0badbadbadbadbadull;
        desc->status &= ~cpu_to_le32(OWNbit | RsvdMask);  }


I tried to apply the patch both in the older version and in the new one but
nothing.

And yeah values greater than 1500 would improve openmosix a lot a believe.

Thank you for your time,
Regards,

Nicholas Papadakos

