Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264746AbSJPLTQ>; Wed, 16 Oct 2002 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264897AbSJPLTQ>; Wed, 16 Oct 2002 07:19:16 -0400
Received: from uucp.gnuu.de ([151.189.0.84]:26128 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S264746AbSJPLTP>;
	Wed, 16 Oct 2002 07:19:15 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix path in Documentation/networking/pktgen.txt
 (2.4.20-pre11)
From: krause@sdbk.de (Sebastian D.B. Krause)
Date: Wed, 16 Oct 2002 13:23:15 +0200
Message-ID: <87r8eqvd98.fsf@sdbk.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct me if I'm wrong, but it seems that the path to pktgen's
proc-directory is wrong in the Documentation, because the directory
is /proc/net/pktgen/, not /proc/net/pg/. This little patch should fix
it:

--- Documentation/networking/pktgen.txt.orig    Wed Oct 16 13:00:22 2002
+++ Documentation/networking/pktgen.txt Wed Oct 16 13:02:32 2002
@@ -6,7 +6,7 @@
 3. Edit script to set preferred device and destination IP address.
 3a.  Create more scripts for different interfaces.  Up to thirty-two
      pktgen processes can be configured and run at once by using the
-     32 /proc/net/pg* files.
+     32 /proc/net/pktgen/pg* files.
 4. Run in shell: ". ipg"
 5. After this two commands are defined:
    A. "pg" to start generator and to get results.
@@ -52,7 +52,7 @@

 modprobe pktgen

-PGDEV=/proc/net/pg/pg0
+PGDEV=/proc/net/pktgen/pg0

 function pgset() {
     local result
