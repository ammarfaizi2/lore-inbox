Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUCXWvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 17:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCXWvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 17:51:21 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:9668 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S262514AbUCXWvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 17:51:12 -0500
Date: Wed, 24 Mar 2004 17:50:12 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH] export complete_all
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <406210A4.4030609@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------060100040204060507050407
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060100040204060507050407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

No idea why it hasn't been done already, but complete_all wasn't
exported while complete was.

Please apply,

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYhCjdQs4kOxk3/MRAsfQAJ9UuLA3lcBctZl0S961wCFVgE9x6wCfSFlt
HHJ72qURp63J5cPKoojMDvY=
=l/qU
-----END PGP SIGNATURE-----

--------------060100040204060507050407
Content-Type: text/x-patch;
 name="export_complete_all.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_complete_all.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1493  -> 1.1494 
#	      kernel/sched.c	1.255   -> 1.256  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/24	michael.waychison@fp-b7-17.sfbay.sun.com	1.1494
# sched.c:
#   - Export complete_all for module use.
# --------------------------------------------
#
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Mar 24 15:30:26 2004
+++ b/kernel/sched.c	Wed Mar 24 15:30:26 2004
@@ -1869,6 +1869,8 @@
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
+EXPORT_SYMBOL(complete_all);
+
 void fastcall wait_for_completion(struct completion *x)
 {
 	might_sleep();

--------------060100040204060507050407--
