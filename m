Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279233AbRKKRJW>; Sun, 11 Nov 2001 12:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRKKRJN>; Sun, 11 Nov 2001 12:09:13 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18050
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S279233AbRKKRJB>; Sun, 11 Nov 2001 12:09:01 -0500
Date: Sun, 11 Nov 2001 10:08:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.4.11 is available
Message-ID: <20011111100850.A9460@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <26919.1005458129@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26919.1005458129@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 04:55:29PM +1100, Keith Owens wrote:

> Changelog extract
> 
> 	* Add taint printing to lsmod.
> 	* PPC64 support.  Alan Modra, Anton Blanchard.  Tweaked by Keith Owens.

This (and all PPC support) won't compile now.  There's an extra #endif
in include/elf_ppc64.h

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--- modutils-2.4.11/include/elf_ppc64.h.orig	Sun Nov 11 10:03:12 2001
+++ modutils-2.4.11/include/elf_ppc64.h	Sun Nov 11 10:03:35 2001
@@ -85,5 +85,3 @@
 #define R_PPC64_GNU_VTINHERIT   R_PPC_GNU_VTINHERIT
 #define R_PPC64_GNU_VTENTRY     R_PPC_GNU_VTENTRY
 #endif	/* R_PPC64_ADDR64 */
-
-#endif
