Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314583AbSESQwY>; Sun, 19 May 2002 12:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314643AbSESQwX>; Sun, 19 May 2002 12:52:23 -0400
Received: from rongage.org ([63.83.235.147]:46759 "EHLO net.rongage.org")
	by vger.kernel.org with ESMTP id <S314583AbSESQwX>;
	Sun, 19 May 2002 12:52:23 -0400
Subject: [PATCH][RFQ] - Kernel Janitor Project - Compiler Cleanups
From: Ron Gage <ron@rongage.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 19 May 2002 12:46:23 -0400
Message-Id: <1021826787.7867.32.camel@portable>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks:

In my delusional attempt to contribute to the Linux Kernel, I have
chosen the "clean up compiler warnings" item from the Kernel Janitors
list.  This cleanup applies to base 2.4.18.

To expose the warnings, all one needs to do is change the CC defination
from "gcc" to "gcc -w" in the toplevel Makefile.

The typical warnings exposed are:
signed vs unsigned comparison
unsigned compared to negative constant
unused parameters
unused variables
missing initializers

While there has been some limited discussion (thanks Keith Owens)
regarding if GCC is doing the right thing wrt initializing structures,
the fact remains that if GCC is emitting a warning, then I did what I
could to squash it.  I am usign GCC v2.95.3 as distributed with
Slackware 8.0.

This patch touches a LOT of different files in the include, kernel,
drivers/block, drivers/acpi, and drivers/char directories and while the
changes should be benign, you are advised to handle with care.

This patch is a work in progress so expect more in the future from me. 
I am releasing what I have now for commentary and if necessary, course
correction.  PLEASE be gentle in the commentary as this is my first
major contribution to the kernel.

The patch, at 42k gzip'ed, is sitting on my webserver: 
http://www.rongage.org/2.4.18-rg1-diff.gz

Thanks!

Ron Gage - Saginaw, MI
(ron@rongage.org)


