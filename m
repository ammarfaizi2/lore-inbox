Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279106AbRKICML>; Thu, 8 Nov 2001 21:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279144AbRKICMB>; Thu, 8 Nov 2001 21:12:01 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:2553 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279106AbRKICLp>; Thu, 8 Nov 2001 21:11:45 -0500
Date: Thu, 8 Nov 2001 21:11:43 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan Van de Ven <arjanv@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] take 2 of the tr-based current
Message-ID: <20011108211143.A4797@redhat.com>
In-Reply-To: <20011108190546.A29741@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108190546.A29741@redhat.com>; from bcrl@redhat.com on Thu, Nov 08, 2001 at 07:05:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 07:05:46PM -0500, Benjamin LaHaise wrote:
> If other people could bang on this a bit and post any problems, I'd 
> appreciate it.  tia,

Ooops.  A slight typo is fixed below.

		-ben (who shouldn't edit patches before hitting send)


diff -ur ./v2.4.13-ac8/include/asm-i386/smp.h ../toomuch-v2.4.13-ac8+tr/include/asm-i386/smp.h
--- ./v2.4.13-ac8/include/asm-i386/smp.h	Thu Nov  8 21:07:47 2001
+++ toomuch-v2.4.13-ac8+tr/include/asm-i386/smp.h	Thu Nov  8 21:06:25 2001
@@ -102,7 +102,8 @@
  * so this is correct in the x86 case.
  */
 
-static unsigned get_TR(void) __attribute__ ((pure))
+static unsigned get_TR(void) __attribute__ ((pure));
+static unsigned get_TR(void)
 {
 	unsigned tr;
 	__asm__("str %w0" : "=g" (tr));
