Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUJIWxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUJIWxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUJIWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:53:13 -0400
Received: from gw.anda.ru ([212.57.164.72]:32004 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S267511AbUJIWxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:53:08 -0400
Date: Sun, 10 Oct 2004 04:53:00 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] Another one ISA PnP modem
Message-ID: <20041010045300.B1639@natasha.ward.six>
Mail-Followup-To: Russell King <rmk+serial@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the USR Courier INT (one of them?) into the list of
the PnP devices IDs in 8250_pnp.  Before the patch this modem hasn't
been activated by 8250_pnp.

For the description inside a comment I used what the modem tells about
itself literally - 'USRobotics' vs. 'U.S. Robotics' used elsewhere in
the file.  May be it is undesirably?

Please, apply the patch.


--- drivers/serial/8250_pnp.c.orig	2004-08-14 16:54:47.000000000 +0600
+++ drivers/serial/8250_pnp.c	2004-10-10 03:33:53.000000000 +0600
@@ -293,6 +293,8 @@ static const struct pnp_device_id pnp_de
 	{	"USR0006",		0	},
 	/* U.S. Robotics 33.6K Voice EXT PnP */
 	{	"USR0007",		0	},
+	/* USRobotics Courier V.Everything INT PnP */
+	{	"USR0009",		0	},
 	/* U.S. Robotics 33.6K Voice INT PnP */
 	{	"USR2002",		0	},
 	/* U.S. Robotics 56K Voice INT PnP */
