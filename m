Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUALXLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbUALXLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:11:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43734 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262705AbUALXLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:11:01 -0500
Date: Tue, 13 Jan 2004 00:10:41 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [1/3] gcc 2.95 supports -march=k6 (no need for check_gcc)
Message-ID: <20040112231041.GQ9677@fs.tum.de>
References: <20040112230839.GP9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112230839.GP9677@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 2.95 supports -march=k6 (no need for check_gcc)

--- linux-2.6.1-mm2/arch/i386/Makefile.old	2004-01-12 23:44:38.000000000 +0100
+++ linux-2.6.1-mm2/arch/i386/Makefile	2004-01-12 23:45:44.000000000 +0100
@@ -35,7 +35,7 @@
 cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
-cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
+cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4)

