Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVBSIlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVBSIlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVBSIk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:40:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21262 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261656AbVBSIjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:39:15 -0500
Date: Sat, 19 Feb 2005 09:39:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/shaper.c: make a variable static
Message-ID: <20050219083909.GQ4337@stusta.de>
References: <20050219001018.GK4337@stusta.de> <421685CB.4010606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421685CB.4010606@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 07:18:19PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >This patch contains the following cleanups:
> >- remove an unused #define SHAPER_BANNER
> >- remove the sh_debug flag
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> you are removing presumably-useful debug code; NAK.

OK, less invasive patch below.


<--  snip  -->


This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/shaper.c.old	2005-02-16 18:20:33.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/shaper.c	2005-02-19 09:27:53.000000000 +0100
@@ -96,7 +96,7 @@
 }; 
 #define SHAPERCB(skb) ((struct shaper_cb *) ((skb)->cb))
 
-int sh_debug;		/* Debug flag */
+static int sh_debug;		/* Debug flag */
 
 #define SHAPER_BANNER	"CymruNet Traffic Shaper BETA 0.04 for Linux 2.1\n"
 

