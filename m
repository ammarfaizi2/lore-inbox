Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSBUIeE>; Thu, 21 Feb 2002 03:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSBUIdo>; Thu, 21 Feb 2002 03:33:44 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:52471 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S288748AbSBUIdm>; Thu, 21 Feb 2002 03:33:42 -0500
Date: Thu, 21 Feb 2002 09:29:24 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc2
In-Reply-To: <Pine.LNX.4.21.0202181815480.25479-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0202210924450.3462-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

as discussed in the thread of your 2.4.18-rc1 announcement (see [1] and
[2]) 2.4.18 adds CONFIG_FB_TRIDENT but the code doesn't compile.  It's
IMHO not a good a idea to add a new option that doesn't compile to a
stable kernel. Please apply the patch below that disables this option as a
workaround to 2.4.18:


--- drivers/video/Config.in.old	Thu Feb 21 00:18:54 2002
+++ drivers/video/Config.in	Thu Feb 21 00:20:02 2002
@@ -145,7 +145,7 @@
 	 fi
 	 tristate '  3Dfx Banshee/Voodoo3 display support (EXPERIMENTAL)' CONFIG_FB_3DFX
 	 tristate '  3Dfx Voodoo Graphics (sst1) support (EXPERIMENTAL)' CONFIG_FB_VOODOO1
-	 tristate '  Trident support (EXPERIMENTAL)' CONFIG_FB_TRIDENT
+#	 tristate '  Trident support (EXPERIMENTAL)' CONFIG_FB_TRIDENT
       fi
    fi
    if [ "$ARCH" = "sparc" -o "$ARCH" = "sparc64" ]; then


TIA
Adrian

[1] http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-06/0985.html
[2] http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-06/0988.html


