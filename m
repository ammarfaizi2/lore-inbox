Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSIPGtq>; Mon, 16 Sep 2002 02:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSIPGtq>; Mon, 16 Sep 2002 02:49:46 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:34489 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S313305AbSIPGtl>;
	Mon, 16 Sep 2002 02:49:41 -0400
Date: Mon, 16 Sep 2002 16:54:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bjornw@axis.com
Subject: [PATCH] fcntl.h consolidation 4/18
Message-Id: <20020916165422.7ad5b179.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CRIS part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.35/include/asm-cris/fcntl.h 2.5.35-fcntl.1/include/asm-cris/fcntl.h
--- 2.5.35/include/asm-cris/fcntl.h	2001-02-09 11:32:44.000000000 +1100
+++ 2.5.35-fcntl.1/include/asm-cris/fcntl.h	2002-09-16 16:04:22.000000000 +1000
@@ -1,89 +1,6 @@
 #ifndef _CRIS_FCNTL_H
 #define _CRIS_FCNTL_H
 
-/* verbatim copy of i386 version */
-
-/* open/fcntl - O_SYNC is only implemented on blocks devices and on files
-   located on an ext2 file system */
-#define O_ACCMODE	   0003
-#define O_RDONLY	     00
-#define O_WRONLY	     01
-#define O_RDWR		     02
-#define O_CREAT		   0100	/* not fcntl */
-#define O_EXCL		   0200	/* not fcntl */
-#define O_NOCTTY	   0400	/* not fcntl */
-#define O_TRUNC		  01000	/* not fcntl */
-#define O_APPEND	  02000
-#define O_NONBLOCK	  04000
-#define O_NDELAY	O_NONBLOCK
-#define O_SYNC		 010000
-#define FASYNC		 020000	/* fcntl, for BSD compatibility */
-#define O_DIRECT	 040000	/* direct disk access hint - currently ignored */
-#define O_LARGEFILE	0100000
-#define O_DIRECTORY	0200000	/* must be a directory */
-#define O_NOFOLLOW	0400000 /* don't follow links */
-
-#define F_DUPFD		0	/* dup */
-#define F_GETFD		1	/* get f_flags */
-#define F_SETFD		2	/* set f_flags */
-#define F_GETFL		3	/* more flags (cloexec) */
-#define F_SETFL		4
-#define F_GETLK		5
-#define F_SETLK		6
-#define F_SETLKW	7
-
-#define F_SETOWN	8	/*  for sockets. */
-#define F_GETOWN	9	/*  for sockets. */
-#define F_SETSIG	10	/*  for sockets. */
-#define F_GETSIG	11	/*  for sockets. */
-
-#define F_GETLK64      12      /*  using 'struct flock64' */
-#define F_SETLK64      13
-#define F_SETLKW64     14
-
-/* for F_[GET|SET]FL */
-#define FD_CLOEXEC	1	/* actually anything with low bit set goes */
-
-/* for posix fcntl() and lockf() */
-#define F_RDLCK		0
-#define F_WRLCK		1
-#define F_UNLCK		2
-
-/* for old implementation of bsd flock () */
-#define F_EXLCK		4	/* or 3 */
-#define F_SHLCK		8	/* or 4 */
-
-/* for leases */
-#define F_INPROGRESS   16
-
-/* operations for bsd flock(), also used by the kernel implementation */
-#define LOCK_SH		1	/* shared lock */
-#define LOCK_EX		2	/* exclusive lock */
-#define LOCK_NB		4	/* or'd with one of the above to prevent
-				   blocking */
-#define LOCK_UN		8	/* remove lock */
-
-#define LOCK_MAND      32      /* This is a mandatory flock */
-#define LOCK_READ      64      /* ... Which allows concurrent read operations */
-#define LOCK_WRITE     128     /* ... Which allows concurrent write operations */
-#define LOCK_RW        192     /* ... Which allows concurrent read & write ops */
-
-struct flock {
-	short l_type;
-	short l_whence;
-	off_t l_start;
-	off_t l_len;
-	pid_t l_pid;
-};
-
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
-#define F_LINUX_SPECIFIC_BASE  1024
+#include <asm-generic/fcntl.h>
 
 #endif
