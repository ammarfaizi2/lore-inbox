Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293560AbSCKXFZ>; Mon, 11 Mar 2002 18:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310120AbSCKXFQ>; Mon, 11 Mar 2002 18:05:16 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:16781 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S293560AbSCKXFK>;
	Mon, 11 Mar 2002 18:05:10 -0500
Date: Tue, 12 Mar 2002 10:02:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Mihnea-Costin Grigore <mgc8@totalnet.ro>
Subject: [PATCH] DMI patch for broken Dell laptop
Message-Id: <20020312100225.2415c8c6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Linus,

This adds DMI recognition for anohter broken Dell laptop BIOS (BIOS
version A12 on the Insiron 2500).

Patch against 2.4.19-pre2, but applies also to 2.5.6 (with offset).

Reported by Mihnea-Costin Grigore <mgc8@totalnet.ro>.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.19-pre2/arch/i386/kernel/dmi_scan.c 2.4.19-pre2-Dell/arch/i386/kernel/dmi_scan.c
--- 2.4.19-pre2/arch/i386/kernel/dmi_scan.c	Wed Mar  6 16:13:35 2002
+++ 2.4.19-pre2-Dell/arch/i386/kernel/dmi_scan.c	Mon Mar 11 11:26:38 2002
@@ -452,6 +452,11 @@
 			MATCH(DMI_BIOS_VERSION, "A04"),
 			MATCH(DMI_BIOS_DATE, "08/24/2000"), NO_MATCH
 			} },
+	{ broken_apm_power, "Dell Inspiron 2500", {	/* Handle problems with APM on Inspiron 2500 */
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "A12"),
+			MATCH(DMI_BIOS_DATE, "02/04/2002"), NO_MATCH
+			} },
 	{ set_realmode_power_off, "Award Software v4.60 PGMA", {	/* broken PM poweroff bios */
 			MATCH(DMI_BIOS_VENDOR, "Award Software International, Inc."),
 			MATCH(DMI_BIOS_VERSION, "4.60 PGMA"),
