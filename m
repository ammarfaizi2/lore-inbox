Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUEEMLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUEEMLg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUEEMLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:11:36 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:51947 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S264628AbUEEML0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:11:26 -0400
Message-ID: <4098D994.8040007@keyaccess.nl>
Date: Wed, 05 May 2004 14:09:56 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <20040505013135.7689e38d.akpm@osdl.org>	<200405051312.30626.dominik.karall@gmx.net> <20040505043002.2f787285.akpm@osdl.org>
In-Reply-To: <20040505043002.2f787285.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020102080704040707000304"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102080704040707000304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> We need to push this issue along quickly.  The single-page stack generally
> gives us a better kernel and having the stack size configurable creates
> pain.

Hi. No idea if you want this. Not seeing 4KSTACKS in there made me recheck.

Rene.

--------------020102080704040707000304
Content-Type: text/plain;
 name="linux-2.6.6-rc3-mm2_vermagic-4kstacks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6-rc3-mm2_vermagic-4kstacks.diff"

# restore 4KSTACKS to VERMAGIC

--- linux-2.6.6-rc3-mm2/include/asm-i386/module.h.orig	2004-05-05 13:51:29.000000000 +0200
+++ linux-2.6.6-rc3-mm2/include/asm-i386/module.h	2004-05-05 13:52:26.000000000 +0200
@@ -60,11 +60,7 @@
 #define MODULE_REGPARM ""
 #endif
 
-#ifdef CONFIG_4KSTACKS
 #define MODULE_STACKSIZE "4KSTACKS "
-#else
-#define MODULE_STACKSIZE ""
-#endif
 
 #define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM MODULE_STACKSIZE
 

--------------020102080704040707000304--
