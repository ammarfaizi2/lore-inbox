Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316571AbSFZNLW>; Wed, 26 Jun 2002 09:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSFZNLV>; Wed, 26 Jun 2002 09:11:21 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:19644 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316571AbSFZNLU>;
	Wed, 26 Jun 2002 09:11:20 -0400
Message-ID: <000001c21d12$b52df520$0200a8c0@MichaelKerrisk>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: [2.4.18 Patch] Update comments in include/linux/capabilities.h
Date: Wed, 26 Jun 2002 13:50:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo

After doing a fairly extensive scan of the 2.4.18 source code, I notice that
a few comments in include/linux/capabilities.h were wrong, and that a few
more things could be added.

Cheers

Miichael

--- linux-2.4.18/include/linux/capability.h Mon Jun 24 10:07:00 2002
+++ linux/include/linux/capability.h Wed Jun 26 12:52:04 2002
@@ -90,12 +90,12 @@

 #define CAP_FOWNER           3

-/* Overrides the following restrictions that the effective user ID
-   shall match the file owner ID when setting the S_ISUID and S_ISGID
-   bits on that file; that the effective group ID (or one of the
-   supplementary group IDs) shall match the file owner ID when setting
-   the S_ISGID bit on that file; that the S_ISUID and S_ISGID bits are
-   cleared on successful return from chown(2) (not implemented). */
+/* Overrides the following restrictions that:
+   the S_ISUID and S_ISGID bits will be turned off when a file is modified;
+   the effective group ID (or one of the supplementary group IDs) shall
+   match the file owner ID when setting the S_ISGID bit on that file;
+   the S_ISUID and S_ISGID bits are cleared on successful return
+   from chown(2) (not implemented). */

 #define CAP_FSETID           4

@@ -104,7 +104,7 @@
 #define CAP_FS_MASK          0x1f

 /* Overrides the restriction that the real or effective user ID of a
-   process sending a signal must match the real or effective user ID
+   process sending a signal must match the real or saved-set-user ID
    of the process receiving the signal. */

 #define CAP_KILL             5
@@ -116,7 +116,7 @@
 #define CAP_SETGID           6

 /* Allows set*uid(2) manipulation (including fsuid). */
-/* Allows forged pids on socket credentials passing. */
+/* Allows forged uids on socket credentials passing. */

 #define CAP_SETUID           7

@@ -139,7 +139,7 @@

 #define CAP_NET_BIND_SERVICE 10

-/* Allow broadcasting, listen to multicast */
+/* Allow broadcasting, listen to multicast (unused) */

 #define CAP_NET_BROADCAST    11

@@ -210,7 +210,7 @@
 /* Allow irix_prctl on mips (setstacksize) */
 /* Allow flushing all cache on m68k (sys_cacheflush) */
 /* Allow removing semaphores */
-/* Used instead of CAP_CHOWN to "chown" IPC message queues, semaphores
+/* Perform IPC_SET and IPC_RMID operations on IPC message queues,
semaphores
    and shared memory */
 /* Allow locking/unlocking of shared memory segment */
 /* Allow turning swap on/off */
@@ -231,6 +231,8 @@
 /* Allow enabling/disabling tagged queuing on SCSI controllers and sending
    arbitrary SCSI commands */
 /* Allow setting encryption key on loopback filesystem */
+/* Allow calling of setdomainname() and sethostname() */
+/* Allow RLIMIT_NPROC to be overridden */

 #define CAP_SYS_ADMIN        21




