Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbRIKNBs>; Tue, 11 Sep 2001 09:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272448AbRIKNBa>; Tue, 11 Sep 2001 09:01:30 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:57860 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S272449AbRIKNBK>;
	Tue, 11 Sep 2001 09:01:10 -0400
Message-Id: <200109111418.JAA01522@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9ac10 compile failure (hz_to_std) 
In-Reply-To: Your message of "Tue, 11 Sep 2001 15:39:30 +0800."
             <Pine.LNX.4.31.0109111538280.5196-100000@shaker.worfie.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Sep 2001 09:18:41 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the patch which fixes it which I haven't sent to Alan yet.

				Jeff

diff -Naur linux/include/asm-um/param.h uml/include/asm-um/param.h
--- linux/include/asm-um/param.h	Thu Sep  6 17:51:01 2001
+++ uml/include/asm-um/param.h	Thu Sep  6 19:19:12 2001
@@ -5,6 +5,8 @@
 #define HZ 20
 #endif
 
+#define hz_to_std(a) (((a)*HZ)/100)
+
 #define EXEC_PAGESIZE   4096
 
 #ifndef NGROUPS

