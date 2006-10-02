Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWJBFMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWJBFMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 01:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWJBFMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 01:12:54 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:7879
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932619AbWJBFMx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 01:12:53 -0400
Message-Id: <200610020511.k925BeSC020416@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
In-Reply-To: Your message of "Sun, 01 Oct 2006 22:59:01 -0000."
             <20061001225720.115967000@cruncher.tec.linutronix.de>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159765900_8054P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 01:11:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159765900_8054P
Content-Type: text/plain; charset=us-ascii

On Sun, 01 Oct 2006 22:59:01 -0000, Thomas Gleixner said:

> the following patch series is an update in response to your review.

This complains if you try to compile with -Werror-implicit-function-declaration
and rightly so, as we're missing a #include to define IS_ERR_VALUE().

Patch attached.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--- linux-2.6.18-mm2/kernel/hrtimer.c.buggy	2006-10-02 00:46:50.000000000 -0400
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-10-02 01:02:55.000000000 -0400
@@ -43,6 +43,7 @@
 #include <linux/clockchips.h>
 #include <linux/profile.h>
 #include <linux/seq_file.h>
+#include <linux/err.h>
 
 #include <asm/uaccess.h>
 
--- linux-2.6.18-mm2/kernel/time/clockevents.c.buggy	2006-10-02 00:46:50.000000000 -0400
+++ linux-2.6.18-mm2/kernel/time/clockevents.c	2006-10-02 01:04:22.000000000 -0400
@@ -33,6 +33,7 @@
 #include <linux/profile.h>
 #include <linux/sysdev.h>
 #include <linux/hrtimer.h>
+#include <linux/err.h>
 
 #define MAX_CLOCK_EVENTS	4
 #define GLOBAL_CLOCK_EVENT	MAX_CLOCK_EVENTS


--==_Exmh_1159765900_8054P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIJ+McC3lWbTT17ARAnWeAKCa/vP1CyFoyRnYtlbiDcGz4G1VkgCg023J
jGk9T5LHLINEngb7CFP5odk=
=ltbL
-----END PGP SIGNATURE-----

--==_Exmh_1159765900_8054P--
