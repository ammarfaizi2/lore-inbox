Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268454AbTCFWbC>; Thu, 6 Mar 2003 17:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268470AbTCFWbC>; Thu, 6 Mar 2003 17:31:02 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:33177 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S268454AbTCFWbA>; Thu, 6 Mar 2003 17:31:00 -0500
Subject: Re: [PATCH] Fix breakage caused by spelling 'fix'
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Michael Hayes <mike@aiinc.ca>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303061356030.8521-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303061356030.8521-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Mar 2003 15:37:24 -0700
Message-Id: <1046990244.4992.104.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 14:57, Linus Torvalds wrote:
> 
> On Thu, 6 Mar 2003, Michael Hayes wrote:
> >
> > This fixes a spelling "fix" that resulted in a compile error.
> > 
> > With apologies to Russell King.
> 
> Ugh, please make things like this just write out the full non-contracted 
> thing. Ie "cannot" is a perfectly fine word, we don't need to force 
> spelling errors.
> 
> 		Linus

For yet another alternative:

[steven@spc9 steven]$ cat -n hello.c
     1  #if 0
     2  /* This won't break anything */
     3  #include <bogus.h>
     4  #endif
     5
     6  #if 0
     7  * This won't compile
     8  #include <missing.h>
     9  #endif
    10
    11  #include <stdio.h>
    12  int main()
    13  {
    14          printf("Hello world!\n");
    15  }
[steven@spc9 steven]$ cc -c hello.c
hello.c:7:11: missing terminating ' character

--- linux-2.5.64/include/asm-arm/proc-fns.h.orig	Thu Mar  6 15:19:17 2003
+++ linux-2.5.64/include/asm-arm/proc-fns.h	Thu Mar  6 15:20:13 2003
@@ -124,9 +124,9 @@
 #endif /* __KERNEL__ */
 
 #if 0
- * The following is to fool mkdep into generating the correct
- * dependencies.  Without this, it can't figure out that this
- * file does indeed depend on the cpu-*.h files.
+/* The following is to fool mkdep into generating the correct */
+/* dependencies.  Without this, it can't figure out that this */
+/* file does indeed depend on the cpu-*.h files.              */
 #include <asm/cpu-single.h>
 #include <asm/cpu-multi26.h>
 #include <asm/cpu-multi32.h>


