Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759074AbWLAFWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759074AbWLAFWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759077AbWLAFWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:22:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33683 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759074AbWLAFWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:22:35 -0500
Date: Thu, 30 Nov 2006 21:19:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/i386/kernel/reboot.c should #include
 <linux/reboot.h>
Message-Id: <20061130211922.73112be6.akpm@osdl.org>
In-Reply-To: <20061129100426.GM11084@stusta.de>
References: <20061129100426.GM11084@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 11:04:26 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Every file should #include the headers containing the prototypes for 
> its global functions.

--- a/Makefile~add-gcc-wmissing-prototypes
+++ a/Makefile
@@ -313,7 +313,7 @@ LINUXINCLUDE    := -Iinclude \
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common -Wmissing-prototypes
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
_

Have fun...
