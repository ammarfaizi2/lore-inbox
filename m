Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277551AbRJOQFd>; Mon, 15 Oct 2001 12:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277552AbRJOQFN>; Mon, 15 Oct 2001 12:05:13 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:60942 "EHLO
	smtp.alcove-fr") by vger.kernel.org with ESMTP id <S277551AbRJOQFI>;
	Mon, 15 Oct 2001 12:05:08 -0400
Date: Mon, 15 Oct 2001 18:05:37 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] meye camera driver EXPORT_NO_SYMBOLS
Message-ID: <20011015180537.P4523@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <25612.1002800758@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25612.1002800758@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 09:45:58PM +1000, Keith Owens wrote:

> Starting with modutils 2.5, modules must explicitly say what their
> intention is for symbols.  That will break a lot of existing modules.

Here is the patch for drivers/media/video/meye.c

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.12-ac2.orig/drivers/media/video/meye.c linux-2.4.12-ac2/drivers/media/video/meye.c
--- linux-2.4.12-ac2.orig/drivers/media/video/meye.c	Sun Sep 30 21:26:06 2001
+++ linux-2.4.12-ac2/drivers/media/video/meye.c	Mon Oct 15 18:01:17 2001
@@ -1482,6 +1482,7 @@
 MODULE_DESCRIPTION("video4linux driver for the MotionEye camera");
 MODULE_LICENSE("GPL");
 
+EXPORT_NO_SYMBOLS;
 
 MODULE_PARM(gbuffers,"i");
 MODULE_PARM_DESC(gbuffers,"number of capture buffers, default is 2 (32 max)");

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
