Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTKPOPc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 09:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTKPOPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 09:15:32 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:49024 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262848AbTKPOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 09:15:29 -0500
Date: Sun, 16 Nov 2003 15:15:27 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 - document elevator= parameter
In-Reply-To: <200311160259.hAG2x4La006117@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0311161510280.14183@gockel.physik3.uni-rostock.de>
References: <200311160259.hAG2x4La006117@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nick wrote a nice as-iosched.txt file, but apparently nobody updated the
> kernel-parameters.txt file...
> 
> Diff against 2.6.0-test9-mm3.
...
> +	elevator=	[IOSCHED]
> +			Format: {"as"|"cfq"|"deadline"|"noop"}

IIRC cfq isn't yet in mainline, thus it seems a bit too early to
document it...

Tim


--- linux.dist/Documentation/kernel-parameters.txt.dist	2003-11-13 15:20:43.000000000 -0500
+++ linux/Documentation/kernel-parameters.txt	2003-11-15 21:54:54.004814257 -0500
@@ -24,6 +24,7 @@
 	HW	Appropriate hardware is enabled.
 	IA-32	IA-32 aka i386 architecture is enabled.
 	IA-64	IA-64 architecture is enabled.
+	IOSCHED	More than one I/O scheduler is enabled.
 	IP_PNP	IP DCHP, BOOTP, or RARP is enabled.
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
@@ -303,6 +304,10 @@
 			See comment before function elanfreq_setup() in
 			arch/i386/kernel/cpu/cpufreq/elanfreq.c.
 
+	elevator=	[IOSCHED]
+			Format: {"as"|"deadline"|"noop"}
+			See Documentation/as-iosched.txt for details
+
 	es1370=		[HW,OSS]
 			Format: <lineout>[,<micbias>]
 			See also header of sound/oss/es1370.c.


