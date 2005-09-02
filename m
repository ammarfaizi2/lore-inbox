Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVIBWTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVIBWTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVIBWTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:19:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161085AbVIBWTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:19:22 -0400
Date: Sat, 3 Sep 2005 00:19:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Documentation/arm/README: small update
Message-ID: <20050902221911.GZ3657@stusta.de>
References: <20050824103653.GI5603@stusta.de> <20050828181750.A14294@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050828181750.A14294@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 06:17:50PM +0100, Russell King wrote:
> On Wed, Aug 24, 2005 at 12:36:53PM +0200, Adrian Bunk wrote:
> > - egcs is not supported by kernel 2.6
> 
> Ok.
> 
> > - Am I right to assume that gcc 2.95.3 is not worse than gcc 2.95.1?
> 
> No idea - I've given up tracking what compilers work and don't work on
> the grounds that I'm too scared to change my compiler!  gcc 3.3 works
> fine here which is the only version I use (until it's proven far too
> buggy through local experience).
> 
> That probably means we should say "at least GCC 3.3" though I'm not
> sure if that's entirely accurate.
> 
> Toolchains are just pure evil as far as stability on ARM goes.

What about the patch below to simply recommend gcc 3.3?

It doesn't imply other compilers weren't usable and removes the 
references to the older compilers.

> Russell King

cu
Adrian


<--  snip  -->


- egcs is not supported by kernel 2.6
- gcc 3.3 seems to be a good choice on ARM


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/Documentation/arm/README.old	2005-09-03 00:02:55.000000000 +0200
+++ linux-2.6.13-mm1-full/Documentation/arm/README	2005-09-03 00:03:51.000000000 +0200
@@ -8,10 +8,9 @@
 ---------------------
 
   In order to compile ARM Linux, you will need a compiler capable of
-  generating ARM ELF code with GNU extensions.  GCC 2.95.1, EGCS
-  1.1.2, and GCC 3.3 are known to be good compilers.  Fortunately, you
-  needn't guess.  The kernel will report an error if your compiler is
-  a recognized offender.
+  generating ARM ELF code with GNU extensions.  GCC 3.3 is known to be
+  a good compiler.  Fortunately, you needn't guess.  The kernel will report
+  an error if your compiler is a recognized offender.
 
   To build ARM Linux natively, you shouldn't have to alter the ARCH = line
   in the top level Makefile.  However, if you don't have the ARM Linux ELF

