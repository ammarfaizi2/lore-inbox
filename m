Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSEZMQg>; Sun, 26 May 2002 08:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315993AbSEZMQf>; Sun, 26 May 2002 08:16:35 -0400
Received: from daimi.au.dk ([130.225.16.1]:61959 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315988AbSEZMQf>;
	Sun, 26 May 2002 08:16:35 -0400
Message-ID: <3CF0D21F.59BBDEA0@daimi.au.dk>
Date: Sun, 26 May 2002 14:16:31 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trivial - remove unused field
In-Reply-To: <3CED6510.4FB31E7A@daimi.au.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> 
> This patch removes the unused v86mode field from the
> thread_struct. It was tested against 2.4.19-pre8-ac5,
> and I also verified that 2.5.17 did compile with
> this patch.

Here is a version of the patch that applies cleanly
to 2.5.18:

diff -Nur linux.old/include/asm-i386/processor.h linux.new/include/asm-i386/processor.h
--- linux.old/include/asm-i386/processor.h	Sat May 25 14:17:40 2002
+++ linux.new/include/asm-i386/processor.h	Sat May 25 14:17:15 2002
@@ -367,7 +367,7 @@
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
