Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbRGNSJd>; Sat, 14 Jul 2001 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRGNSJX>; Sat, 14 Jul 2001 14:09:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:1523 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264644AbRGNSJQ>; Sat, 14 Jul 2001 14:09:16 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010715045842.B6963@weta.f00f.org> 
In-Reply-To: <20010715045842.B6963@weta.f00f.org>  <20010715031815.D6722@weta.f00f.org> <200107141414.f6EEEjQ05792@ns.caldera.de> <17573.995129225@redhat.com> 
To: Chris Wedgwood <cw@f00f.org>
Cc: Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Jul 2001 19:09:13 +0100
Message-ID: <19235.995134153@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cw@f00f.org said:
>  If it changes vmlinux by a single byte, I might agree.... all it does
> is close off and older depricated API.

Why is the sane API deprecated in favour of the implementation-specific one?

If we must standardise on a single header file to include, surely we should
do it the other way round?

Index: include/linux/slab.h
===================================================================
RCS file: /inst/cvs/linux/include/linux/slab.h,v
retrieving revision 1.1.1.1.2.12
diff -u -r1.1.1.1.2.12 slab.h
--- include/linux/slab.h	2001/06/08 22:41:51	1.1.1.1.2.12
+++ include/linux/slab.h	2001/07/14 18:08:37
@@ -4,6 +4,10 @@
  * (markhe@nextd.demon.co.uk)
  */
 
+#ifndef _LINUX_MALLOC_H
+#warning Please do not include linux/slab.h directly, use linux/malloc.h instead.
+#endif
+
 #if	!defined(_LINUX_SLAB_H)
 #define	_LINUX_SLAB_H
 


--
dwmw2


