Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279555AbRJXNAR>; Wed, 24 Oct 2001 09:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRJXNAI>; Wed, 24 Oct 2001 09:00:08 -0400
Received: from ns.suse.de ([213.95.15.193]:24581 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279555AbRJXNAE>;
	Wed, 24 Oct 2001 09:00:04 -0400
Date: Wed, 24 Oct 2001 15:00:36 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: <frank.van.maarseveen@altium.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux/drivers/acpi/include/platform/acgcc.h:103: warning: `wbinvd'
 redefined
In-Reply-To: <20011024144909.A6970@espoo.tasking.nl>
Message-ID: <Pine.LNX.4.30.0110241457350.31131-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Frank van Maarseveen wrote:

> linux/include/asm/system.h:128: warning: this is the location of the previous definition
> I get tons of these in both 2.4.12 and 2.4.13. Config:

Fix below sent to Linus a few times. Its been in Alans tree for a while,
and has been picked up by the ACPI guys a while ago iirc,
So will probably eventually end up in -linus next time they merge
with mainline.

Dave.


diff -urN --exclude-from=/home/davej/.exclude linux-dj/drivers/acpi/include/platform/acgcc.h linux-test/drivers/acpi/include/platform/acgcc.h
--- linux-dj/drivers/acpi/include/platform/acgcc.h	Mon Sep 24 00:36:42 2001
+++ linux-test/drivers/acpi/include/platform/acgcc.h	Mon Sep 24 15:52:56 2001
@@ -101,7 +101,6 @@
 #define disable() __cli()
 #define enable()  __sti()
 #define halt()    __asm__ __volatile__ ("sti; hlt":::"memory")
-#define wbinvd()  __asm__ __volatile__ ("wbinvd":::"memory")

 /*! [Begin] no source code translation
  *


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


