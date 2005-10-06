Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVJFOKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVJFOKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVJFOKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:10:35 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:46229 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751009AbVJFOKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:10:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vm - swap_prefetch-15 docs
Date: Fri, 7 Oct 2005 00:13:18 +1000
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org
References: <200510070001.01418.kernel@kolivas.org>
In-Reply-To: <200510070001.01418.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+DTRD7bVPra5Zzv"
Message-Id: <200510070013.18958.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+DTRD7bVPra5Zzv
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 7 Oct 2005 12:01 am, Con Kolivas wrote:
> The last known bugs were addressed in this latest version of the swap
> prefetching patch. Thanks to the testers out there who helped it get this
> far.
>
> -Prefetched pages weren't handled properly by the lru lists.
> -Prefetch groups are now 10 times larger when laptop_mode is enabled thus
> decreasing the amount of time spent prefetching and thus the disk spinning.
> -Documentation as suggested by Ingo Oeser
>
> Incremental patches and latest available here:
> http://ck.kolivas.org/patches/swap-prefetch/

And the docs...

Cheers,
Con
---



--Boundary-00=_+DTRD7bVPra5Zzv
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="sp15_docs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="sp15_docs.patch"

Index: linux-2.6.13-ck7/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.13-ck7.orig/Documentation/sysctl/vm.txt	2005-03-02 18:38:17.000000000 +1100
+++ linux-2.6.13-ck7/Documentation/sysctl/vm.txt	2005-10-06 23:10:54.000000000 +1000
@@ -26,6 +26,7 @@ Currently, these files are in /proc/sys/
 - min_free_kbytes
 - laptop_mode
 - block_dump
+- swap_prefetch
 
 ==============================================================
 
@@ -102,3 +103,14 @@ This is used to force the Linux VM to ke
 of kilobytes free.  The VM uses this number to compute a pages_min
 value for each lowmem zone in the system.  Each lowmem zone gets 
 a number of reserved free pages based proportionally on its size.
+
+==============================================================
+
+swap_prefetch
+
+This is the amount of data prefetched per prefetching interval when
+swap prefetching is compiled in. The value means multiples of 128K,
+except when laptop_mode is enabled and then it is ten times larger.
+Setting it to 0 disables prefetching entirely.
+
+The default value is 2.

--Boundary-00=_+DTRD7bVPra5Zzv--
