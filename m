Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbRCHB5O>; Wed, 7 Mar 2001 20:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131255AbRCHB5E>; Wed, 7 Mar 2001 20:57:04 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:22775 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S131254AbRCHB4v>; Wed, 7 Mar 2001 20:56:51 -0500
From: junio@siamese.dhis.twinsun.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misspelled spinlock_prefetch for MK7 (was: Linux 2.4.2ac14)
In-Reply-To: <7vsnkpuk2q.fsf@siamese.dhis.twinsun.com>
Date: 07 Mar 2001 17:56:24 -0800
In-Reply-To: <7vsnkpuk2q.fsf@siamese.dhis.twinsun.com>
Message-ID: <7vn1axuipj.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I have wasted your time by speaking too early.

Here is a corrected version of my fix; the old one replaced one
typo with another X-<.

You need this to link for Athron/Durons.

--- 2.4.2-ac14/include/asm-i386/processor.h	Wed Mar  7 16:59:48 2001
+++ 2.4.2-ac14/include/asm-i386/processor.h	Wed Mar  7 17:25:17 2001
@@ -499,7 +499,7 @@
 {
 	 __asm__ __volatile__ ("prefetch (%0)" : : "r"(x));
 }
-#define spinock_prefetch(x)	prefetchw(x)
+#define spin_lock_prefetch(x)	prefetchw(x)

 #endif
