Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVA0AHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVA0AHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVA0AGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:06:12 -0500
Received: from web52303.mail.yahoo.com ([206.190.39.98]:24731 "HELO
	web52303.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262453AbVAZV2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:28:14 -0500
Message-ID: <20050126212812.74696.qmail@web52303.mail.yahoo.com>
Date: Wed, 26 Jan 2005 22:28:12 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [PATCH 2.6.11-rc2-mm1] perfctl-ppc: fix duplicate mmcr0 define
To: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-438995560-1106774892=:73159"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-438995560-1106774892=:73159
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

This small patch fixes a compilation warning due to a
duplicate definition of MMCR0_PMXE.

The definition comes in perfctr-ppc.patch, but was
recently introduced too in Linus tree.

Cheers,
Albert



		
______________________________________________ 
Renovamos el Correo Yahoo!: ¡250 MB GRATIS! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
--0-438995560-1106774892=:73159
Content-Type: text/plain; name="perfctr-ppc-mmcr0-duplicate-define-fix.patch"
Content-Description: perfctr-ppc-mmcr0-duplicate-define-fix.patch
Content-Disposition: inline; filename="perfctr-ppc-mmcr0-duplicate-define-fix.patch"

--- a/include/asm-ppc/reg.h	2005-01-26 22:31:19.000000000 +0100
+++ b/include/asm-ppc/reg.h	2005-01-26 22:32:26.000000000 +0100
@@ -388,7 +388,6 @@
 #define MMCR0_PMC2_CYCLES	0x1
 #define MMCR0_PMC2_ITLB		0x7
 #define MMCR0_PMC2_LOADMISSTIME	0x5
-#define MMCR0_PMXE		(1 << 26)
 
 /* Short-hand versions for a number of the above SPRNs */
 #define CTR	SPRN_CTR	/* Counter Register */

--0-438995560-1106774892=:73159--
