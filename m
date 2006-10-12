Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWJLTiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWJLTiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWJLTiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:38:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62080 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751140AbWJLTh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:37:59 -0400
Date: Thu, 12 Oct 2006 14:37:53 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
       Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
In-Reply-To: <20061011172332.8f7b354f.akpm@osdl.org>
Message-ID: <20061012143353.J85966@pkunk.americas.sgi.com>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
 <20061011172332.8f7b354f.akpm@osdl.org>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When removing SN2 dependencies from the ioc4 master driver, I overlooked
removing various SN-specific includes in the driver.  These need to be
removed to build on non-SN2 systems.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
---
Note to Andrew: ioc4-enable-build-on-non-sn2-fix.patch in -mm should
be removed once this patch is applied.

This time I confirmed the results build on both SN2 and x86_64.

 ioc4.c |    3 ---
 1 file changed, 3 deletions(-)
---
Index: top/drivers/misc/ioc4.c
===================================================================
--- top.orig/drivers/misc/ioc4.c	2006-10-12 12:56:40.000000000 -0500
+++ top/drivers/misc/ioc4.c	2006-10-12 12:57:35.368546949 -0500
@@ -32,9 +32,6 @@
 #include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <linux/time.h>
-#include <asm/sn/addrs.h>
-#include <asm/sn/clksupport.h>
-#include <asm/sn/shub_mmr.h>
 
 /***************
  * Definitions *
