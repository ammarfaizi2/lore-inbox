Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUCXLmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 06:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUCXLmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 06:42:35 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:54800 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S263315AbUCXLmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 06:42:32 -0500
Date: Wed, 24 Mar 2004 12:42:25 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Cc: <dahinds@users.sourceforge.net>
Subject: Re: [PATCH] cs.c: release_cis_mem() missing?
In-Reply-To: <Pine.LNX.4.33.0403240934200.1869-100000@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.33.0403241235520.1869-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...and one more

diff -u -r1.1.1.8.6.1.2.1 cs.c
--- drivers/pcmcia/cs.c	2003/10/24 15:15:12	1.1.1.8.6.1.2.1
+++ drivers/pcmcia/cs.c	2004/03/24 11:20:44
@@ -674,6 +674,7 @@
     cs_sleep(shutdown_delay);
     s->state &= ~SOCKET_PRESENT;
     shutdown_socket(s);
+    release_cis_mem(s);
 }

 static void parse_events(void *info, u_int events)

- also with a question mark? Without this patch the mappping stays after
card removal and the resource doesn't get freed. Maybe, holds for 2.6
too. The function to be patched seems to be socket_shutdown.

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

