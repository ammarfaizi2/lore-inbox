Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135613AbREFLJP>; Sun, 6 May 2001 07:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135619AbREFLJG>; Sun, 6 May 2001 07:09:06 -0400
Received: from smtp.mountain.net ([198.77.1.35]:48401 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S135613AbREFLIx>;
	Sun, 6 May 2001 07:08:53 -0400
Message-ID: <3AF53090.CF4DD5B4@mountain.net>
Date: Sun, 06 May 2001 07:08:00 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Incremental to kill warnings
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I missed one, patch is incremental to the previous one.

Tom

$ diff -u include/asm-i386/checksum.h.orig include/asm-i386/checksum.h
--- include/asm-i386/checksum.h.orig	Sun May  6 07:05:35 2001
+++ include/asm-i386/checksum.h	Sun May  6 07:06:52 2001
@@ -100,10 +100,8 @@
 
 static inline unsigned int csum_fold(unsigned int sum)
 {
-	__asm__("
-		addl %1, %0
-		adcl $0xffff, %0
-		"
+	__asm__("addl %1, %0\n\t"
+		"adcl $0xffff, %0\n"
 		: "=r" (sum)
 		: "r" (sum << 16), "0" (sum & 0xffff0000)
 	);

-- 
The Daemons lurk and are dumb. -- Emerson
