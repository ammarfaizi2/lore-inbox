Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUJHFUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUJHFUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 01:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUJHFUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 01:20:08 -0400
Received: from ozlabs.org ([203.10.76.45]:60890 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267740AbUJHFUE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 01:20:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16742.9694.339329.225556@cargo.ozlabs.ibm.com>
Date: Fri, 8 Oct 2004 15:30:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH] PPC64: Remove degree symbol from rtas-proc.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox pointed out that the degree symbol in the thermal sensor proc
files that we have on ppc64 cause problems for people using other
locales or UTF-8.  This patch makes them disappear.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/rtas-proc.c ppc64-2.5-pseries/arch/ppc64/kernel/rtas-proc.c
--- linux-2.5/arch/ppc64/kernel/rtas-proc.c	2004-08-08 12:05:16.000000000 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/rtas-proc.c	2004-08-12 15:52:39.000000000 +1000
@@ -580,7 +580,7 @@
 			}
 			break;
 		case THERMAL_SENSOR:
-			seq_printf(m, "Temp. (°C/°F):\t");
+			seq_printf(m, "Temp. (C/F):\t");
 			temperature = 1;
 			break;
 		case LID_STATUS:
