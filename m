Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbUCZP7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264070AbUCZP7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:59:24 -0500
Received: from [198.247.175.96] ([198.247.175.96]:34752 "EHLO jethro.hick.org")
	by vger.kernel.org with ESMTP id S264069AbUCZP7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:59:21 -0500
Date: Fri, 26 Mar 2004 09:56:49 -0600 (CST)
From: Matt Miller <mmiller@hick.org>
To: linux-kernel@vger.kernel.org
cc: viro@parcelfarce.linux.theplanet.co.uk, mmiller@hick.org
Subject: Re: [PATCH] 2.6: improved fdmap
In-Reply-To: <200403261524.56694@WOLK>
Message-ID: <Pine.LNX.4.58.0403260951080.9588@jethro.hick.org>
References: <Pine.LNX.4.58.0403252228420.20049@jethro.hick.org>
 <200403261524.56694@WOLK>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004, Marc-Christian Petersen wrote:
> hmm, fdmap == 265 and fadvise64_64 also 265? I think you can leave
> fadvise64_64 at 264 ;)

Doh!  I should have read the patch more closely.  Please apply this second
patch if you are on s390.  It depends on the first patch.  I will wait to
see if there are any more problems before posting a new complete patch.
Thanks for pointing it out!

Matt

-------

Patch for s390 (depends on first patch):

--- linux-2.6.4/include/asm-s390/unistd.h	Fri Mar 26 09:43:50 2004
+++ linux-2.6.4-fdmap-orig/include/asm-s390/unistd.h	Fri Mar 26 09:47:52 2004
@@ -256,11 +256,11 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
-#define __NR_fdmap		265
 /*
  * Number 263 is reserved for vserver
  */
-#define __NR_fadvise64_64	265
+#define __NR_fadvise64_64	264
+#define __NR_fdmap		265

 #define NR_syscalls 266

