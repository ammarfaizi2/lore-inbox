Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVDHPXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVDHPXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVDHPXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:23:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25261 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262849AbVDHPXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:23:35 -0400
Message-ID: <4256A1EE.8060706@grupopie.com>
Date: Fri, 08 Apr 2005 16:23:26 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
References: <20050408030835.4941cd98.akpm@osdl.org> <42569122.9070003@portrix.net>
In-Reply-To: <42569122.9070003@portrix.net>
Content-Type: multipart/mixed;
 boundary="------------040902010301030006010502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902010301030006010502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Dittmer wrote:
> Andrew Morton wrote:
> 
>>create-a-kstrdup-library-function.patch
>>  create a kstrdup library function
>>
>>create-a-kstrdup-library-function-fixes.patch
>>  create-a-kstrdup-library-function-fixes

Oops, forgot to include slab.h. I guess the other #include's were 
including it somewhere down the line on x86, so it went unnoticed :(

The attached patch should fix this.

[PATCH] create-a-kstrdup-library-function-fix-include-slab

Signed-off-by: Paulo Marques <pmarques@grupopie.com>

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------040902010301030006010502
Content-Type: text/plain;
 name="strdup_fix_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strdup_fix_patch"

--- ./lib/string.c.orig	2005-04-08 16:07:14.000000000 +0100
+++ ./lib/string.c	2005-04-08 16:08:29.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
 /**

--------------040902010301030006010502--
