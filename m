Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUHENGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUHENGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267676AbUHENFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:05:04 -0400
Received: from holomorphy.com ([207.189.100.168]:7619 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267670AbUHENDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:03:13 -0400
Date: Thu, 5 Aug 2004 06:03:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040805130308.GC14358@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm1/
> - Added David Woodhouse's MTD tree to the "external trees" list
> - Dropped the staircase scheduler, mainly because the schedstats patch broke
>   it.
>   We learned quite a lot from having staircase in there.  Now it's time for
>   a new scheduler anyway.

One of these changes means we need to be able to dereference struct
device in include/asm-ia64/dma-mapping.h.

--- mm1-2.6.8-rc3/include/asm-ia64/dma-mapping.h.orig	2004-08-05 22:56:27.204548702 -0700
+++ mm1-2.6.8-rc3/include/asm-ia64/dma-mapping.h	2004-08-05 22:57:40.435993118 -0700
@@ -5,7 +5,8 @@
  * Copyright (C) 2003-2004 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
-
+#include <linux/config.h>
+#include <linux/device.h>
 #include <asm/machvec.h>
 
 #define dma_alloc_coherent	platform_dma_alloc_coherent
