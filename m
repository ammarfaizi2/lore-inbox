Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUHJQun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUHJQun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUHJQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:47:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21661 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267527AbUHJQiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:38:24 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc4-mm1
Date: Tue, 10 Aug 2004 09:37:47 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org>
In-Reply-To: <20040810002110.4fd8de07.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bnPGBFu6+EaWej6"
Message-Id: <200408100937.47451.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_bnPGBFu6+EaWej6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, August 10, 2004 12:21 am, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc4/2.6
>.8-rc4-mm1/

Needs a build fix for ia64, which is attached.  acpi_noirq wasn't defined for 
anything but i386, afaict.

Once I fix the build, it hangs in the same way as 2.6.8-rc3-mm2.  I assume wli 
is still working on fixing that...

Jesse

--Boundary-00=_bnPGBFu6+EaWej6
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ia64-acpi-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ia64-acpi-build-fix.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8-rc4.orig/include/asm-ia64/acpi.h linux-2.6.8-rc4/include/asm-ia64/acpi.h
--- linux-2.6.8-rc4.orig/include/asm-ia64/acpi.h	2004-08-10 09:01:34.000000000 -0700
+++ linux-2.6.8-rc4/include/asm-ia64/acpi.h	2004-08-10 09:26:39.000000000 -0700
@@ -89,6 +89,7 @@ ia64_acpi_release_global_lock (unsigned 
 	((Acq) = ia64_acpi_release_global_lock((unsigned int *) GLptr))
 
 #define acpi_disabled 0	/* ACPI always enabled on IA64 */
+#define acpi_noirq 0	/* ACPI always enabled on IA64 */
 #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
 #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
 static inline void disable_acpi(void) { }

--Boundary-00=_bnPGBFu6+EaWej6--
