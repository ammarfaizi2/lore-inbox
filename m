Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280996AbRKOTKr>; Thu, 15 Nov 2001 14:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKOTKi>; Thu, 15 Nov 2001 14:10:38 -0500
Received: from zero.tech9.net ([209.61.188.187]:20741 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280996AbRKOTKX>;
	Thu, 15 Nov 2001 14:10:23 -0500
Subject: Re: Uniprocessor Compile error: 2.4.15-pre4 (-tr) in kernel.o
	(cpu_init()) - Works with SMP
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Ben Ryan <ben@bssc.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20011113162814.A28319@redhat.com>
In-Reply-To: <2482591359.20011114043702@bssc.edu.au>
	<187493868425.20011114074459@bssc.edu.au> 
	<20011113162814.A28319@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 15 Nov 2001 14:10:25 -0500
Message-Id: <1005851437.1061.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 07:44:59AM +1100, Ben Ryan wrote:
> SMP compile succeeded. (albeit with lots of warnings on 'pure')

UP users of the patch will want to apply this, too:

diff -urN rattlesnake/include/asm-i386/current_asm.h  linux/include/asm-i386/current_asm.h 
--- rattlesnake/include/asm-i386/current_asm.h	Thu Nov 15 14:07:46 2001
+++ linux/include/asm-i386/current_asm.h	Thu Nov 15 14:08:15 2001
@@ -7,7 +7,7 @@
 #include <linux/per_cpu.h>
 #include <asm/desc.h>
 
-#if 1 /*def CONFIG_SMP*/
+#ifdef CONFIG_SMP
 /* Pass in the long and short versions of the register.
  * eg GET_CURRENT(%ebx,%bx)
  * All of this braindamage comes to us c/o a bug in gas: the


	Robert Love

