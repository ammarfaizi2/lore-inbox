Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266700AbUFYKIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266700AbUFYKIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUFYKIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:08:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:21952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266696AbUFYKF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:05:58 -0400
Date: Fri, 25 Jun 2004 03:05:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, sparclinux@vger.kernel.org
Subject: Re: [SPARC64] kernel 2.6.7+cset-20040625_0611 = ERROR
Message-Id: <20040625030502.40e25d42.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:
>
> make[1]: *** [arch/sparc64/kernel/process.o] Error 1
>  make: *** [arch/sparc64/kernel] Error 2

here's t'other:



include/linux/byteorder/swab.h: In function `__swab16p':
include/linux/byteorder/swab.h:139: warning: passing arg 1 of `___arch__swab16p' discards qualifiers from pointer target type
include/linux/byteorder/swab.h: In function `__swab32p':
include/linux/byteorder/swab.h:152: warning: passing arg 1 of `___arch__swab32p' discards qualifiers from pointer target type
include/linux/byteorder/swab.h: In function `__swab64p':
include/linux/byteorder/swab.h:172: warning: passing arg 1 of `___arch__swab64p' discards qualifiers from pointer target type

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-sparc64-akpm/include/asm-sparc64/byteorder.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN include/asm-sparc64/byteorder.h~sparc64-swab-fix include/asm-sparc64/byteorder.h
--- 25-sparc64/include/asm-sparc64/byteorder.h~sparc64-swab-fix	2004-06-25 03:00:05.667497712 -0700
+++ 25-sparc64-akpm/include/asm-sparc64/byteorder.h	2004-06-25 03:00:05.670497256 -0700
@@ -7,7 +7,7 @@
 
 #ifdef __GNUC__
 
-static __inline__ __u16 ___arch__swab16p(__u16 *addr)
+static __inline__ __u16 ___arch__swab16p(const __u16 *addr)
 {
 	__u16 ret;
 
@@ -17,7 +17,7 @@ static __inline__ __u16 ___arch__swab16p
 	return ret;
 }
 
-static __inline__ __u32 ___arch__swab32p(__u32 *addr)
+static __inline__ __u32 ___arch__swab32p(const __u32 *addr)
 {
 	__u32 ret;
 
@@ -27,7 +27,7 @@ static __inline__ __u32 ___arch__swab32p
 	return ret;
 }
 
-static __inline__ __u64 ___arch__swab64p(__u64 *addr)
+static __inline__ __u64 ___arch__swab64p(const __u64 *addr)
 {
 	__u64 ret;
 
_

