Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRAFIeh>; Sat, 6 Jan 2001 03:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130372AbRAFIe1>; Sat, 6 Jan 2001 03:34:27 -0500
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:63749 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S130018AbRAFIeP>;
	Sat, 6 Jan 2001 03:34:15 -0500
Date: Sat, 6 Jan 2001 10:33:27 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
Reply-To: Matan Ziv-Av <matan@svgalib.org>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] svgalib error in mmap documentation
Message-ID: <Pine.LNX.4.21_heb2.09.0101061029360.1256-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

svgalib needs to be compiled without background support in order to run
under kernl 2.4.0 or newer. Here's a patch to Documentation/Changes that
says this.

--- /usr/src/linux.b/Documentation/Changes        Tue Dec 12 18:43:22 2000
+++ linux/Documentation/Changes     Sat Jan  6 10:28:20 2001
@@ -517,6 +517,14 @@
 Older isdn4k-utils versions don't support EXTRAVERSION into kernel version
 string. A upgrade to isdn4k-utils.v3.1beta7 or later is recomented.

+SVGAlib
+=======
+If you want svgalib programs to run with kernel 2.4.0 or newer, svgalib
+needs to be compiled without background support (BACKGROUND not defined in
+Makefile.cfg). This is relevant to any svgalib version.
+This is because svgalib uses mmap of /proc/mem to emulate vga's memory bank
+switching when in background, and kernel 2.4.0 stopped supporting this feature.
+


-- 
Matan Ziv-Av.                         matan@svgalib.org


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
