Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbVIAXNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVIAXNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbVIAXNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:13:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29711 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030463AbVIAXNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:13:00 -0400
Date: Fri, 2 Sep 2005 01:12:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
Cc: dev-etrax@axis.com
Subject: [2.6 patch] drivers/serial/crisv10.c: remove {,un}register_serial dummies
Message-ID: <20050901231258.GD3657@stusta.de>
References: <20050831103352.A26480@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831103352.A26480@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 10:33:52AM +0100, Russell King wrote:
>...
> In addition, the following drivers declare functions of the same name.
> The maintainers of these need to look to see why, and eliminate them
> where possible.
> 
> drivers/serial/crisv10.c:register_serial(struct serial_struct *req)
> drivers/serial/crisv10.c:void unregister_serial(int line)


It seems we can simply kill these dummies with this patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/drivers/serial/crisv10.c.old	2005-09-02 01:10:07.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/serial/crisv10.c	2005-09-02 01:10:27.000000000 +0200
@@ -5038,17 +5038,3 @@
 /* this makes sure that rs_init is called during kernel boot */
 
 module_init(rs_init);
-
-/*
- * register_serial and unregister_serial allows for serial ports to be
- * configured at run-time, to support PCMCIA modems.
- */
-int
-register_serial(struct serial_struct *req)
-{
-	return -1;
-}
-
-void unregister_serial(int line)
-{
-}

