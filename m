Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUCBWWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUCBWWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:22:10 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:51977 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261946AbUCBWVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:21:49 -0500
Date: Wed, 3 Mar 2004 00:17:48 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: macserial.c missing variable declaration
In-Reply-To: <1078263053.21573.176.camel@gaston>
Message-ID: <Pine.LNX.4.58L.0403030014530.30738@alpha.zarz.agh.edu.pl>
References: <1078263053.21573.176.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in file drivers/macintosh/macserial.c are two undeclared variable named 
"cmd" 

based on 2.6.4-rc1+cset-20040302_0821.
fixed by this patch.

--- linux-2.6.4-rc1/drivers/macintosh/macserial.c.org	2004-02-27 23:21:29.000000000 +0100
+++ linux-2.6.4-rc1/drivers/macintosh/macserial.c	2004-03-02 21:49:44.533392464 +0100
@@ -1781,6 +1781,7 @@
 {
 	struct mac_serial * info = (struct mac_serial *)tty->driver_data;
 	unsigned char control, status;
+	unsigned int cmd;
 	unsigned long flags;
 
 #ifdef CONFIG_KGDB
@@ -1811,6 +1812,7 @@
 {
 	struct mac_serial * info = (struct mac_serial *)tty->driver_data;
 	unsigned int arg, bits;
+	unsigned int cmd; 
 	unsigned long flags;
 
 #ifdef CONFIG_KGDB


-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
