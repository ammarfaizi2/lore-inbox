Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263287AbVCJWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263287AbVCJWRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVCJWOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:14:17 -0500
Received: from waste.org ([216.27.176.166]:31648 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262806AbVCJWDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:03:36 -0500
Date: Thu, 10 Mar 2005 14:03:29 -0800
From: Matt Mackall <mpm@selenic.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] rol/ror type cleanup
Message-ID: <20050310220329.GN3120@waste.org>
References: <200503082005.j28K5lBp028415@hera.kernel.org> <Pine.LNX.4.62.0503101032500.9286@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503101032500.9286@numbat.sonytel.be>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 10:33:29AM +0100, Geert Uytterhoeven wrote:
> `unsigned int', while we're at it?

Minor type cleanup.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: bk/include/linux/bitops.h
===================================================================
--- bk.orig/include/linux/bitops.h	2005-03-10 13:52:49.000000000 -0800
+++ bk/include/linux/bitops.h	2005-03-10 13:59:51.000000000 -0800
@@ -140,7 +140,7 @@ static inline unsigned long hweight_long
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u32 rol32(__u32 word, int shift)
+static inline __u32 rol32(__u32 word, unsigned int shift)
 {
 	return (word << shift) | (word >> (32 - shift));
 }
@@ -151,7 +151,7 @@ static inline __u32 rol32(__u32 word, in
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u32 ror32(__u32 word, int shift)
+static inline __u32 ror32(__u32 word, unsigned int shift)
 {
 	return (word >> shift) | (word << (32 - shift));
 }

-- 
Mathematics is the supreme nostalgia of our time.
