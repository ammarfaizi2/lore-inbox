Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSEWVyb>; Thu, 23 May 2002 17:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSEWVya>; Thu, 23 May 2002 17:54:30 -0400
Received: from daimi.au.dk ([130.225.16.1]:60014 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317023AbSEWVy2>;
	Thu, 23 May 2002 17:54:28 -0400
Message-ID: <3CED6510.4FB31E7A@daimi.au.dk>
Date: Thu, 23 May 2002 23:54:24 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] trivial - remove unused field
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused v86mode field from the
thread_struct. It was tested against 2.4.19-pre8-ac5,
and I also verified that 2.5.17 did compile with
this patch.

This field appears to be unused in all 2.4 and 2.5
kernels.

diff -Nur linux.old/include/asm-i386/processor.h linux.new/include/asm-i386/processor.h
--- linux.old/include/asm-i386/processor.h	Thu May 23 08:50:25 2002
+++ linux.new/include/asm-i386/processor.h	Thu May 23 08:50:38 2002
@@ -378,7 +378,7 @@
 /* virtual 86 mode info */
 	struct vm86_struct	* vm86_info;
 	unsigned long		screen_bitmap;
-	unsigned long		v86flags, v86mask, v86mode, saved_esp0;
+	unsigned long		v86flags, v86mask, saved_esp0;
 /* IO permissions */
 	int		ioperm;
 	unsigned long	io_bitmap[IO_BITMAP_SIZE+1];

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
