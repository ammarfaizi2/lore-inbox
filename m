Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUAMTE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbUAMTE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:04:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28643 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265444AbUAMTEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:04:51 -0500
Date: Tue, 13 Jan 2004 20:04:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-ID: <20040113190443.GR9677@fs.tum.de>
References: <20040109014003.3d925e54.akpm@osdl.org> <20040109233714.GL1440@fs.tum.de> <3FFF79E5.5010401@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFF79E5.5010401@winischhofer.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 05:04:53AM +0100, Thomas Winischhofer wrote:
> Adrian Bunk wrote:
> 
> > On Fri, Jan 09, 2004 at 01:40:03AM -0800, Andrew Morton wrote:
> >
> >> ...
> >> All 393 patches
> >> ...
> >> use-soft-float.patch
> >>  Use -msoft-float
> >> ...
> >
> >
> 
> I know. The version of sisfb in 2.6 vanilla is from stone-age. This is 
> has been fixed a long time ago in my current development version (and 
> will be in 2.4 as soon as Marcelo applies my patch which I sent him 
> about a week ago). For 2.6, using my current version requires James 
> Simmons's fbdev-patch because of low-level fbdev-interface changes (like 
> sysfs usage, etc).
> 
> The whole framebuffer stuff in 2.6 is ancient. (Look at the file dates.)

Until the framebuffer stuff in 2.6 gets updated, I'm suggesting the 
patch below to mark FB_SIS as BROKEN.

> Thomas

cu
Adrian

--- linux-2.6.1-mm2/drivers/video/Kconfig.old	2004-01-13 20:02:28.000000000 +0100
+++ linux-2.6.1-mm2/drivers/video/Kconfig	2004-01-13 20:02:55.000000000 +0100
@@ -696,7 +696,7 @@
 
 config FB_SIS
 	tristate "SIS acceleration"
-	depends on FB && PCI
+	depends on FB && PCI && BROKEN
 	help
 	  This is the frame buffer device driver for the SiS 630 and 640 Super
 	  Socket 7 UMA cards.  Specs available at <http://www.sis.com.tw/>.
