Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271408AbRHPPeh>; Thu, 16 Aug 2001 11:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270873AbRHPPe2>; Thu, 16 Aug 2001 11:34:28 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:40972 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S271408AbRHPPeL>;
	Thu, 16 Aug 2001 11:34:11 -0400
Date: Thu, 16 Aug 2001 17:34:21 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.8-ac5] Another Sony Vaio laptop with a broken APM...
Message-ID: <20010816173420.J8473@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds yet another Vaio laptop to the list of those
having the APM minutes left swapping problem.

However, the Vaio bioses list is getting bigger and bigger
and I wonder if there is _any_ Vaio laptop that gets this
item right. If not, we could just do a search on SYS_VENDOR /
PRODUCT_NAME strings, like the is_sony_vaio_laptop test...

Comments ?

In the meanwhile, Alan, please apply.

Stelian.


diff -uNr --exclude-from=dontdiff linux-2.4.8-ac5.orig/arch/i386/kernel/dmi_scan.c linux-2.4.8-ac5/arch/i386/kernel/dmi_scan.c
--- linux-2.4.8-ac5.orig/arch/i386/kernel/dmi_scan.c	Thu Aug 16 13:56:37 2001
+++ linux-2.4.8-ac5/arch/i386/kernel/dmi_scan.c	Thu Aug 16 14:06:59 2001
@@ -467,6 +467,11 @@
 			MATCH(DMI_BIOS_VERSION, "R0121Z1"),
 			MATCH(DMI_BIOS_DATE, "05/11/00"), NO_MATCH
 			} },
+	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-C1VN/C1VE */
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "R0208P1"),
+			MATCH(DMI_BIOS_DATE, "11/09/00"), NO_MATCH
+			} },
 	
 	/* Problem Intel 440GX bioses */
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
