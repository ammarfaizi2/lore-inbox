Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUDFLeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUDFLcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:32:16 -0400
Received: from witte.sonytel.be ([80.88.33.193]:33922 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263781AbUDFL3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:29:14 -0400
Date: Tue, 6 Apr 2004 13:29:04 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, linux-dvb-maintainer@linuxtv.org
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] DVB dependency
Message-ID: <Pine.GSO.4.58.0404061328310.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DVB_TWINHAN_DST depends on DVB_BT8XX (dependency is explicitly mentioned in
help text, but not enforced)

--- linux-2.6.5/drivers/media/dvb/frontends/Kconfig.orig	2004-02-29 09:31:56.000000000 +0100
+++ linux-2.6.5/drivers/media/dvb/frontends/Kconfig	2004-03-31 12:42:08.000000000 +0200
@@ -3,7 +3,7 @@

 config DVB_TWINHAN_DST
 	tristate "TWINHAN DST based DVB-S frontend (QPSK)"
-	depends on DVB_CORE
+	depends on DVB_CORE && DVB_BT8XX
 	help
 	  Used in such cards as the VP-1020/1030, Twinhan DST,
 	  VVmer TV@SAT. Say Y when you want to support frontends

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
