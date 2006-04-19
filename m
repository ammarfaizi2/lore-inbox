Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWDSNaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWDSNaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWDSNaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:30:05 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:1051 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750739AbWDSNaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:30:04 -0400
X-ME-UUID: 20060419133002440.6B9EE1C00280@mwinf0802.wanadoo.fr
Message-ID: <44463B59.5070408@cosmosbay.com>
Date: Wed, 19 Apr 2006 15:30:01 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: [PATCH] x86_64 : bring back __read_mostly support to linux-2.6.17-rc2
Content-Type: multipart/mixed;
 boundary="------------070301040501050508060307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301040501050508060307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It seems latest kernel (2.6.17-rc2) has a wrong/missing __read_mostly 
implementation for x86_64

__read_mostly macro should be declared outside of #if CONFIG_X86_VSMP block

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------070301040501050508060307
Content-Type: text/plain;
 name="read_mostly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="read_mostly.patch"

--- a/include/asm-x86_64/cache.h	2006-04-19 12:43:14.000000000 +0200
+++ b/include/asm-x86_64/cache.h	2006-04-19 14:11:50.000000000 +0200
@@ -20,8 +20,8 @@
        __attribute__((__section__(".data.page_aligned")))
 #endif
 
-#define __read_mostly __attribute__((__section__(".data.read_mostly")))
-
 #endif
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 #endif

--------------070301040501050508060307--


