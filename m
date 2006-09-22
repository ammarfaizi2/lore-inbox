Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWIVLrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWIVLrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWIVLrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:47:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:55474 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932310AbWIVLrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:47:36 -0400
Message-ID: <4513CD55.4070208@fr.ibm.com>
Date: Fri, 22 Sep 2006 13:47:33 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [PATCH -mm] x86_64 mm generic getcpu syscall fix
References: <20060919012848.4482666d.akpm@osdl.org>
In-Reply-To: <20060919012848.4482666d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/

while working on a new syscall, i've noticed that the getcpu
patch x86_64-mm-generic-getcpu-syscall.patch does not increase
NR_syscalls. shouldn't it ? 

C.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 include/asm-i386/unistd.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.18-rc7-mm1/include/asm-i386/unistd.h
===================================================================
--- 2.6.18-rc7-mm1.orig/include/asm-i386/unistd.h
+++ 2.6.18-rc7-mm1/include/asm-i386/unistd.h
@@ -327,7 +327,7 @@

 #ifdef __KERNEL__

-#define NR_syscalls 318
+#define NR_syscalls 319
 #include <linux/err.h>

 /*

