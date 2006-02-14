Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWBNN15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWBNN15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWBNN15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:27:57 -0500
Received: from ns1.suse.de ([195.135.220.2]:52647 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161048AbWBNN15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:27:57 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc3-mm1: i386 compilation broken
Date: Tue, 14 Feb 2006 14:27:49 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060214014157.59af972f.akpm@osdl.org> <20060214131715.GA10701@stusta.de>
In-Reply-To: <20060214131715.GA10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141427.49763.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 14:17, Adrian Bunk wrote:
> On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc2-mm1:
> >...
> > +x86_64-fix-string.patch
> >...
> >  x86_64 tree updates.
> >...
> 
> This patch breaks the compilation on i386:

Ok then the -ffreestanding was apparently still needed on other architectures too.
I guess that part of the patch can be just dropped.

Andrew can you drop that please?

-Andi

Index: linux/Makefile
===================================================================
--- linux.orig/Makefile
+++ linux/Makefile
@@ -339,8 +339,7 @@ LINUXINCLUDE    := -Iinclude \
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS                 := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                  -fno-strict-aliasing -fno-common \
-                  -ffreestanding
+                  -fno-strict-aliasing -fno-common
 AFLAGS         := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from .kernelrelease (if it exists)
