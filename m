Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSFJMUa>; Mon, 10 Jun 2002 08:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSFJMU3>; Mon, 10 Jun 2002 08:20:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33286 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311898AbSFJMU2>; Mon, 10 Jun 2002 08:20:28 -0400
Message-ID: <3D048BCB.6010409@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:21:47 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 1/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060000060402070908020305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060000060402070908020305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is fixing missing ; after branch label at two places.

--------------060000060402070908020305
Content-Type: text/plain;
 name="warn-2.5.21-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-1.diff"

diff -urN linux-2.5.21/arch/i386/kernel/apm.c linux/arch/i386/kernel/apm.c
--- linux-2.5.21/arch/i386/kernel/apm.c	2002-06-09 07:26:54.000000000 +0200
+++ linux/arch/i386/kernel/apm.c	2002-06-09 20:41:41.000000000 +0200
@@ -848,6 +848,7 @@
 			case 1: apm_idle_done = 1;
 				break;
 			default: /* BIOS refused */
+				;
 			}
 		}
 		if (original_pm_idle)
diff -urN linux-2.5.21/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.21/arch/i386/kernel/smpboot.c	2002-06-09 07:29:52.000000000 +0200
+++ linux/arch/i386/kernel/smpboot.c	2002-06-09 20:42:46.000000000 +0200
@@ -189,10 +189,10 @@
 		/* If we get here, it's not a certified SMP capable AMD system. */
 		printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
 		tainted |= TAINT_UNSAFE_SMP;
-		
 	}
-valid_k7:
 
+valid_k7:
+	;
 }
 
 /*

--------------060000060402070908020305--

