Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbTALUFR>; Sun, 12 Jan 2003 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTALUFM>; Sun, 12 Jan 2003 15:05:12 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:42250
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267481AbTALUFH>; Sun, 12 Jan 2003 15:05:07 -0500
Subject: Re: [PATCH] add explicit Pentium II support
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, L.A.van.der.Duim@student.rug.nl,
       akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301121125370.14031-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0301121125370.14031-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042402432.834.70.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Jan 2003 15:13:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 14:26, Linus Torvalds wrote:

> The thing I reacted to was that the P4 entry should include the
> P4-based celerons. I have no idea what those are called, though.
> 
> Anyway, applied.

I was thinking the same thing, but the lame name of the chips held me
back - the new Celerons are also called "Celerons".

Regardless, I updated the comments and I call the new Celerons "P4-based
Celerons" which should be descriptive enough.

Patch is against current BK.

	Robert Love

 arch/i386/Kconfig |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)


diff -urN linux-2.5.56/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-2.5.56/arch/i386/Kconfig	2003-01-12 15:05:16.000000000 -0500
+++ linux/arch/i386/Kconfig	2003-01-12 15:10:45.000000000 -0500
@@ -120,7 +120,7 @@
 	  - "Pentium-Pro" for the Intel Pentium Pro.
 	  - "Pentium-II" for the Intel Pentium II or pre-Coppermine Celeron.
 	  - "Pentium-III" for the Intel Pentium III or Coppermine Celeron.
-	  - "Pentium-4" for the Intel Pentium 4.
+	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
 	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
 	  - "Crusoe" for the Transmeta Crusoe series.
@@ -183,11 +183,13 @@
 	  extensions.
 
 config MPENTIUM4
-	bool "Pentium-4"
+	bool "Pentium-4/Celeron(P4-based)"
 	help
-	  Select this for Intel Pentium 4 chips.  Presently these are
-	  treated almost like Pentium IIIs, but with a different cache
-	  shift.
+	  Select this for Intel Pentium 4 chips.  This includes both
+	  the Pentium 4 proper and P4-based Celeron chips.  This option
+	  enables compile flags optimized for the core, uses the
+	  correct cache shift, and applies any applicable Pentium III
+	  optimizations.
 
 config MK6
 	bool "K6/K6-II/K6-III"



