Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSHGNAw>; Wed, 7 Aug 2002 09:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317819AbSHGNAv>; Wed, 7 Aug 2002 09:00:51 -0400
Received: from CPE-203-51-35-72.nsw.bigpond.net.au ([203.51.35.72]:8435 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S317751AbSHGNAv>; Wed, 7 Aug 2002 09:00:51 -0400
Message-ID: <3D511AD8.3C7CF2A7@eyal.emu.id.au>
Date: Wed, 07 Aug 2002 23:04:24 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <laughing@shared-source.org>
Subject: 2.4.20-pre1-ac1: apm.c non SMP compile error
Content-Type: multipart/mixed;
 boundary="------------38F9E29C15A8D23A570837AA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------38F9E29C15A8D23A570837AA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

apm_save_cpus() is defined without parameters for non-SMP, breaks
compile.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------38F9E29C15A8D23A570837AA
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre1-ac1-apm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre1-ac1-apm.patch"

--- linux/arch/i386/kernel/apm.c.orig	Wed Aug  7 22:59:06 2002
+++ linux/arch/i386/kernel/apm.c	Wed Aug  7 22:56:55 2002
@@ -524,7 +524,7 @@
  *	No CPU lockdown needed on a uniprocessor
  */
  
-#define apm_save_cpus	0
+#define apm_save_cpus()	0
 #define apm_restore_cpus(x)
 
 #endif

--------------38F9E29C15A8D23A570837AA--

