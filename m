Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275002AbRIYNqG>; Tue, 25 Sep 2001 09:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275003AbRIYNp4>; Tue, 25 Sep 2001 09:45:56 -0400
Received: from ns.suse.de ([213.95.15.193]:9990 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S275002AbRIYNpt>;
	Tue, 25 Sep 2001 09:45:49 -0400
Date: Tue, 25 Sep 2001 15:46:15 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.10 acpi warnings
In-Reply-To: <18980.1001423714@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.30.0109251545110.25212-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Keith Owens wrote:

> Almost every ACPI file gets warnings for wbinvd.
> drivers/acpi/include/platform/acgcc.h:104: warning: `wbinvd' redefined
> include/asm/system.h:128: warning: this is the location of the previous definition

I sent the ACPI guys a patch for this a while ago, and they said it
would be merged. Guess it missed the 2.4.10 merge.
Here it is again.

regards,

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
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

