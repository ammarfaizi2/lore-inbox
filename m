Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271964AbTGYIkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271965AbTGYIkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 04:40:49 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:6413 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S271964AbTGYIks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 04:40:48 -0400
Date: Fri, 25 Jul 2003 10:46:48 +0000 (UTC)
From: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1-ac3 and Alpha
Message-ID: <Pine.LNX.4.44L.0307251043300.13096-100000@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK. next problem on Dec ALPHA is missing
F_GETLK64, F_SETKL64 and F_SETLKW64 requires by fs/fcntl.c

fixed by this patch - requires by SELinux too.

--- linux-2.6.0-test1/include/asm-alpha/fcntl.h.org	Mon Jul 14 03:35:14 2003
+++ linux-2.6.0-test1/include/asm-alpha/fcntl.h	Fri Jul 25 09:09:55 2003
@@ -36,6 +36,10 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
+#define F_GETLK64	12	/*  using 'struct flock64' */
+#define F_SETLK64	13
+#define F_SETLKW64	14
+
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 

-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}

