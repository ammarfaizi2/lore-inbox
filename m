Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272395AbTHIPCc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272396AbTHIPCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:02:32 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:26497
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S272395AbTHIPBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:01:44 -0400
Date: Sat, 9 Aug 2003 11:00:57 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test3: logo patch
In-Reply-To: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0308091059490.2587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch has been floating around forever.  Can we get it in 
mainstream sometime in the near future?

--- linux-2.5-tm/drivers/video/cfbimgblt.c.orig	2003-08-08 17:42:16.000000000 -0500
+++ linux-2.5-tm/drivers/video/cfbimgblt.c	2003-08-08 17:42:30.000000000 -0500
@@ -325,7 +325,7 @@
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
 					start_index, pitch_index);
-	} else if (image->depth == bpp) 
+	} else if (image->depth <= bpp) 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
 

