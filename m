Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316175AbSEOA4r>; Tue, 14 May 2002 20:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316176AbSEOA4q>; Tue, 14 May 2002 20:56:46 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:25227 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316175AbSEOA4p>;
	Tue, 14 May 2002 20:56:45 -0400
Date: Wed, 15 May 2002 10:55:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: bjornw@axis.com, Trivial Kernel Patches <trivial@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: PATCH] 2.4.19-pre8 small typo in signal code for cris
Message-Id: <20020515105518.31db513e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This is obviously correct :-)  A similar typo in the mips and mips64
architectures has been fixed already (but not in 2.5 ...)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.19-pre8/arch/cris/mm/fault.c 2.4.19-pre8-si.2/arch/cris/mm/fault.c
--- 2.4.19-pre8/arch/cris/mm/fault.c	Wed Mar  6 16:07:54 2002
+++ 2.4.19-pre8-si.2/arch/cris/mm/fault.c	Wed May 15 10:50:46 2002
@@ -437,7 +437,7 @@
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	info.si_code = SIGBUS;
+	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
