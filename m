Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287835AbSAFMTu>; Sun, 6 Jan 2002 07:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSAFMTk>; Sun, 6 Jan 2002 07:19:40 -0500
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:35753 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S287835AbSAFMTY>;
	Sun, 6 Jan 2002 07:19:24 -0500
Date: Sun, 6 Jan 2002 16:02:25 -0500
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: ajoshi@shell.unixbox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] A very little patch to make rivafb to be compiled
Message-Id: <20020106160225.5c080f76.johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ani Joshi and other hackers.

Here is patch against 2.5.2-pre9 wich make rivafb to be compiled:

--- /usr/src/linux-2.5.2-pre/drivers/video/riva/fbdev.c~        Wed Nov 14
17:52:20 2001
+++ /usr/src/linux-2.5.2-pre/drivers/video/riva/fbdev.c Sun Jan  6
15:45:04 2002
@@ -1811,7 +1811,7 @@
        info = &rinfo->info;
 
        strcpy(info->modename, rinfo->drvr_name);
-       info->node = -1;
+       info->node = to_kdev_t(-1);
        info->flags = FBINFO_FLAG_DEFAULT;
        info->fbops = &riva_fb_ops;

Now it works good.

Thanks all for your work.

---
WBR. //s0mbre
