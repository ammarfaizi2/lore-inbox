Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUE3Q7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUE3Q7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 12:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUE3Q7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 12:59:13 -0400
Received: from nj4.neoplus.adsl.tpnet.pl ([83.31.94.4]:53120 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S264192AbUE3Q7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 12:59:12 -0400
Date: Sun, 30 May 2004 18:59:08 +0200
From: Piotr Kaczuba <pepe@attika.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.7-rc2][vesafb.c] make vram boot option actually work
Message-ID: <20040530165908.GA4600@orbiter.attika.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch makes the vram boot option actually be recognized  
and its value assigned to the vram variable.




--- vesafb.c.orig       2004-05-30 18:43:42.000000000 +0200
+++ vesafb.c    2004-05-30 18:43:18.000000000 +0200
@@ -207,7 +207,7 @@
                        mtrr=1;
                else if (! strcmp(this_opt, "nomtrr"))
                        mtrr=0;
-               else if (! strcmp(this_opt, "vram"))
+               else if (! strncmp(this_opt, "vram=", 5))
                        vram = simple_strtoul(this_opt+5, NULL, 0);
        }
        return 0;


Piotr Kaczuba
