Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTD0JC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 05:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTD0JC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 05:02:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22214 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263852AbTD0JC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 05:02:57 -0400
From: bunk@fs.tum.de
Date: Sun, 27 Apr 2003 11:15:06 +0200
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, vandrove@vc.cvut.cz, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4] was: Matrox FB problem in latest 2.4.21-rc1-BK
Message-ID: <20030427091506.GI10256@fs.tum.de>
References: <20030427083232.GA171@pcw.home.local> <20030427085711.GA181@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030427085711.GA181@pcw.home.local>
User-Agent: Mutt/1.4.1i
3BFrom: Adrian Bunk <bunk@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 10:57:11AM +0200, Willy TARREAU wrote:

> Hi again,
> 
> OK I found it to be a typo in cset-1.1134 (intel fb fixes) which disabled CFB8.
> It now works with this patch. Christoph, you might also have the typo in your
> tree.

The patch below fixes another place in the same file:
I'm not sure whether the new "y"-o (no space) gets correctly parsed by 
all config tools, but the "$CONFIG_FB_STI" = "y" (not introduced by the 
recent patch) seems to be definitely wrong.

> Cheers,
> Willy
>...

cu
Adrian

--- linux-2.4.21-rc1-modular/drivers/video/Config.in.old	2003-04-27 11:05:53.000000000 +0200
+++ linux-2.4.21-rc1-modular/drivers/video/Config.in	2003-04-27 11:06:52.000000000 +0200
@@ -299,7 +299,7 @@
 	   "$CONFIG_FB_PMAG_BA" = "y" -o "$CONFIG_FB_PMAGB_B" = "y" -o \
 	   "$CONFIG_FB_MAXINE" = "y" -o "$CONFIG_FB_TX3912" = "y" -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" -o \
-	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" -o
+	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" -o \
 	   "$CONFIG_FB_INTEL" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB8 y
       else
@@ -402,7 +402,7 @@
 	      "$CONFIG_FB_3DFX" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_PVR2" = "m" -o "$CONFIG_FB_VOODOO1" = "m" -o \
-	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_STI" = "y"-o \
+	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_STI" = "m" -o \
 	      "$CONFIG_FB_INTEL" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi
