Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWF2RGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWF2RGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWF2RGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:06:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16587 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750995AbWF2RGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:06:20 -0400
Message-ID: <44A40874.20202@us.ibm.com>
Date: Thu, 29 Jun 2006 10:05:56 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, kamezawa.hiroyu@jp.fujitsu.com,
       Andrew Morton <akpm@osdl.org>
Subject: 2.6.17-git14 compile failure & fix
Content-Type: multipart/mixed;
 boundary="------------080009020106060302030003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080009020106060302030003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I get "unknown definition" compile failure while compiling 2.6.17-git14
with CONFIG_MEMORY_HOTPLUG. (kernel/resource.c line: 243) -
due to recent changes to it.

Here is the patch to fix it. I can't take credit for the patch, since its
part of GregKH resource_t  patches :)

Thanks,
Badari



--------------080009020106060302030003
Content-Type: text/plain;
 name="define-resource-size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="define-resource-size.patch"

Index: linux-2.6.17/include/linux/types.h
===================================================================
--- linux-2.6.17.orig/include/linux/types.h	2006-06-29 09:53:00.000000000 -0700
+++ linux-2.6.17/include/linux/types.h	2006-06-29 09:58:21.000000000 -0700
@@ -177,6 +177,8 @@ typedef __u64 __bitwise __be64;
 
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
+
+typedef unsigned long resource_size_t;
 #endif
 
 struct ustat {

--------------080009020106060302030003--

