Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbTAQLPx>; Fri, 17 Jan 2003 06:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTAQLPx>; Fri, 17 Jan 2003 06:15:53 -0500
Received: from adsl-173-18.barak.net.il ([62.90.173.18]:12678 "EHLO
	laptop.slamail.org") by vger.kernel.org with ESMTP
	id <S267495AbTAQLPw>; Fri, 17 Jan 2003 06:15:52 -0500
Message-ID: <3E27E6A3.8060902@slamail.org>
Date: Fri, 17 Jan 2003 13:18:59 +0200
From: Yaacov Akiba Slama <ya@slamail.org>
Reply-To: Yaacov Akiba Slama <ya@slamail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en, fr, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@diego.com
Subject: Re: 2.5.59-mm1
Content-Type: multipart/mixed;
 boundary="------------080302080808000209020608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302080808000209020608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

There is a small bug in kirq.pach which gives a compilation error of an 
UP kernel.
The enclosed patch seems to be the fix.

Thanks,
Yaacov Akiba Slama

--------------080302080808000209020608
Content-Type: text/plain;
 name="2.5.59-mm1-kirq"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.59-mm1-kirq"

--- a/arch/i386/kernel/io_apic.c	2003-01-17 13:11:25.000000000 +0200
+++ b/arch/i386/kernel/io_apic.c	2003-01-17 13:11:04.000000000 +0200
@@ -589,6 +589,8 @@
 
 __initcall(balanced_irq_init);
 
+#else /* !SMP */
+static inline void move_irq(int irq) { }
 #endif /* defined(CONFIG_SMP) */
 
 

--------------080302080808000209020608--

