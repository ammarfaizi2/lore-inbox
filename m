Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261769AbSI2UQP>; Sun, 29 Sep 2002 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbSI2UQP>; Sun, 29 Sep 2002 16:16:15 -0400
Received: from [213.4.129.129] ([213.4.129.129]:50346 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id <S261769AbSI2UQH>;
	Sun, 29 Sep 2002 16:16:07 -0400
Date: Sun, 29 Sep 2002 22:15:32 +0200
From: Arador <diegocg@teleline.es>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA update [1/10] - 2002/06/24
Message-Id: <20020929221532.72e87790.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.33.0209292026550.591-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.33.0209292026550.591-100000@pnote.perex-int.cz>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002 20:30:14 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> escribió:

> Hi,
> 
> 	1-st patch from first set of ALSA update patches.


I sent a bugfix to the alsa devel list (i'm not
subscribed and i received a message that said
that my message was waiting for moderator ACK,
i don't know more). I sent it to the driver
maintainer. It's not included in ths set of
patches as i can see. It makes isapnp to work
correctly.


--- cmi8330.c.broken	Thu Sep 12 16:39:04 2002
+++ cmi8330.c	Thu Sep 12 16:39:10 2002
@@ -46,6 +46,11 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#ifndef LINUX_ISAPNP_H
+#include <linux/isapnp.h>
+#define isapnp_card pci_bus
+#define isapnp_dev pci_dev
+#endif
 #include <sound/core.h>
 #include <sound/ad1848.h>
 #include <sound/sb.h>

