Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293082AbSCOSha>; Fri, 15 Mar 2002 13:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293088AbSCOShL>; Fri, 15 Mar 2002 13:37:11 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:26401 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S293082AbSCOShG>; Fri, 15 Mar 2002 13:37:06 -0500
Message-ID: <61DB42B180EAB34E9D28346C11535A78062D1A@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'rusty@rustcorp.com.au'" <rusty@rustcorp.com.au>
Cc: "'davem@redhat.com'" <davem@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PROT_SEM in 2.5.7pre1 on Sparc question
Date: Fri, 15 Mar 2002 13:36:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am playing around with 2.5.7pre1 on Sparc64 platform.  There's a new flag
definition in mman.h for PROT_SEM set to 0x8.  Right now, the proper def is
not in the sparc tree,  Dave may already have seen this, I diff'd the file
below, if your interested, that will allow the kernel compile to complete.  

I see that this is related to the fast user space mutexes.  I have been
reading up the LKML notes I have found on this, but I am wondering if there
are any implications on this for the Sparc architecture?  I don't have a
working kernel yet for testing.  But was wondering if you had any thoughts
on this.

Thanks
Bruce Holzrichter

-------------------------------------------------------------

--- include/asm-sparc64/mman.h.old	Fri Mar 15 12:03:57 2002
+++ include/asm-sparc64/mman.h	Fri Mar 15 12:05:07 2002
@@ -7,6 +7,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM		0x8		/* page may be used for
atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
