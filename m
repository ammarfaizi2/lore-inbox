Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269603AbUJSQUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269603AbUJSQUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269570AbUJSQTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:19:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2821 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269511AbUJSQQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:16:39 -0400
Date: Tue, 19 Oct 2004 18:16:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       Denis Zaitsev <zzz@anda.ru>
Subject: [PATCH] Another one ISA PnP modem (USR0009)
Message-ID: <20041019161607.GB1960@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is a patch from Denis Zaitsev <zzz@anda.ru> with the following two 
adjustments:
- applies with -p1 (not -p0)
- USRobotics -> U.S. Robotics (consistent with the rest of the entries)


Original comment of Denis Zaitsev:

<--  snip  -->

This patch adds the USR Courier INT (one of them?) into the list of
the PnP devices IDs in 8250_pnp.  Before the patch this modem hasn't
been activated by 8250_pnp.

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- l/drivers/serial/8250_pnp.c.orig	2004-08-14 16:54:47.000000000 +0600
+++ l/drivers/serial/8250_pnp.c	2004-10-10 03:33:53.000000000 +0600
@@ -293,6 +293,8 @@ static const struct pnp_device_id pnp_de
 	{	"USR0006",		0	},
 	/* U.S. Robotics 33.6K Voice EXT PnP */
 	{	"USR0007",		0	},
+	/* U.S. Robotics Courier V.Everything INT PnP */
+	{	"USR0009",		0	},
 	/* U.S. Robotics 33.6K Voice INT PnP */
 	{	"USR2002",		0	},
 	/* U.S. Robotics 56K Voice INT PnP */
