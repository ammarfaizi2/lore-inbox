Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSAAXEt>; Tue, 1 Jan 2002 18:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286337AbSAAXEk>; Tue, 1 Jan 2002 18:04:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286342AbSAAXEa>;
	Tue, 1 Jan 2002 18:04:30 -0500
Message-ID: <3C32407A.BB44CBCE@mandrakesoft.com>
Date: Tue, 01 Jan 2002 18:04:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Re: NFS "dev_t" issues..
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------0856575C10236C44BC9D1619"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0856575C10236C44BC9D1619
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus,

What do you think about the attached simple patch, making the cookie
size more explicit?

I was looking at fixing up reiserfs, which already has 32-bit storage
for dev_t on-disk, and the following change came to mind.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------0856575C10236C44BC9D1619
Content-Type: text/plain; charset=us-ascii;
 name="kdev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdev.patch"

Index: include/linux/kdev_t.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/include/linux/kdev_t.h,v
retrieving revision 1.2
diff -u -r1.2 kdev_t.h
--- include/linux/kdev_t.h	2002/01/01 22:41:11	1.2
+++ include/linux/kdev_t.h	2002/01/01 23:02:10
@@ -86,7 +86,7 @@
  * internal equality comparisons and for things
  * like NFS filehandle conversion.
  */
-static inline unsigned int kdev_val(kdev_t dev)
+static inline u32 kdev_val(kdev_t dev)
 {
 	return dev.value;
 }

--------------0856575C10236C44BC9D1619--

