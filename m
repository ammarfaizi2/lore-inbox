Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbRG2Brm>; Sat, 28 Jul 2001 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbRG2Brb>; Sat, 28 Jul 2001 21:47:31 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:20497 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267446AbRG2BrV>; Sat, 28 Jul 2001 21:47:21 -0400
Message-ID: <3B636CA1.337A9C1A@zip.com.au>
Date: Sun, 29 Jul 2001 11:53:37 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Kotzian <thomasko321k@gmx.at>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: missing symbols in 2.4.7-ac2
In-Reply-To: <E15Q8Uz-0005l0-00@the-village.bc.nu> <01072902183404.02683@kiwiunixman.nodomain.nowhere> <0dee01c11785$3a874f80$0301a8c0@none56n4x0fcnq>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Thomas Kotzian wrote:
> 
> when compiling with highmem = 4GB
> problem in 3c59x - module:
> unresolved symbol nr_free_highpages ...
> 

Ah.  Sorry.

Alan, is it OK to export this symbol?


--- linux-2.4.7-ac1/kernel/ksyms.c	Sun Jul 29 11:43:01 2001
+++ ac/kernel/ksyms.c	Sun Jul 29 11:43:05 2001
@@ -122,6 +122,7 @@ EXPORT_SYMBOL(kmap_high);
 EXPORT_SYMBOL(kunmap_high);
 EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(create_bounce);
+EXPORT_SYMBOL(nr_free_highpages);
 #endif
 
 /* filesystem internal functions */
