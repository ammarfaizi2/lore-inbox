Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280592AbRK1UD3>; Wed, 28 Nov 2001 15:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280593AbRK1UDT>; Wed, 28 Nov 2001 15:03:19 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:35303 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S280592AbRK1UDN>;
	Wed, 28 Nov 2001 15:03:13 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15365.17135.339116.913689@napali.hpl.hp.com>
Date: Wed, 28 Nov 2001 12:02:55 -0800
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, Nathan Myers <ncm-nospam@cantrip.org>
Subject: Re: [RFC] [PATCH] omnibus header cleanup, certification
In-Reply-To: <20011127061714.A41881@cantrip.org>
In-Reply-To: <20011127061714.A41881@cantrip.org>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The attached portion of Nathan's patch looks good to me.  Could you
please apply it on your tree?

Nathan, note that I'm not responsible for the files in asm-ia64/sn/*.
I will forward your mail to the relevant people at SGI, though.

Thanks,

	--david

diff -u -r linux-bak/include/asm-ia64/pal.h linux/include/asm-ia64/pal.h
--- linux-bak/include/asm-ia64/pal.h	Thu Nov 15 16:10:16 2001
+++ linux/include/asm-ia64/pal.h	Thu Nov 15 16:18:50 2001
@@ -88,10 +88,10 @@
 typedef s64				pal_status_t;
 
 #define PAL_STATUS_SUCCESS		0	/* No error */
-#define PAL_STATUS_UNIMPLEMENTED	-1	/* Unimplemented procedure */
-#define PAL_STATUS_EINVAL		-2	/* Invalid argument */
-#define PAL_STATUS_ERROR		-3	/* Error */
-#define PAL_STATUS_CACHE_INIT_FAIL	-4	/* Could not initialize the
+#define PAL_STATUS_UNIMPLEMENTED	(-1)	/* Unimplemented procedure */
+#define PAL_STATUS_EINVAL		(-2)	/* Invalid argument */
+#define PAL_STATUS_ERROR		(-3)	/* Error */
+#define PAL_STATUS_CACHE_INIT_FAIL	(-4)	/* Could not initialize the
 						 * specified level and type of
 						 * cache without sideeffects
 						 * and "restrict" was 1
diff -u -r linux-bak/include/asm-ia64/siginfo.h linux/include/asm-ia64/siginfo.h
--- linux-bak/include/asm-ia64/siginfo.h	Thu Nov 15 16:10:17 2001
+++ linux/include/asm-ia64/siginfo.h	Thu Nov 15 16:19:26 2001
@@ -119,11 +119,11 @@
 
 #define SI_USER		0		/* sent by kill, sigsend, raise */
 #define SI_KERNEL	0x80		/* sent by the kernel from somewhere */
-#define SI_QUEUE	-1		/* sent by sigqueue */
+#define SI_QUEUE	(-1)		/* sent by sigqueue */
 #define SI_TIMER __SI_CODE(__SI_TIMER,-2) /* sent by timer expiration */
-#define SI_MESGQ	-3		/* sent by real time mesq state change */
-#define SI_ASYNCIO	-4		/* sent by AIO completion */
-#define SI_SIGIO	-5		/* sent by queued SIGIO */
+#define SI_MESGQ	(-3)		/* sent by real time mesq state change */
+#define SI_ASYNCIO	(-4)		/* sent by AIO completion */
+#define SI_SIGIO	(-5)		/* sent by queued SIGIO */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
