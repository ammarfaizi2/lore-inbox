Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVF2A5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVF2A5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVF2A4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:56:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3224 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262337AbVF1X7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:59:52 -0400
Date: Tue, 28 Jun 2005 18:59:44 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 9/13]: PCI Err: Whitespace janitoring
Message-ID: <20050628235944.GA6442@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-9-whitespace-janitor.patch

Whitespace janitoring -- remove trailing blanks at ends of 
various lines.

Signed-off-by: Linas Vepstas <linas@linas.org>

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-9-whitespace-janitor.patch"

--- linux-2.6.12-git10/include/asm-ppc64/eeh.h.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/include/asm-ppc64/eeh.h	2005-06-22 15:28:29.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * eeh.h
  * Copyright (C) 2001  Dave Engebretsen & Todd Inglett IBM Corporation.
  *
@@ -6,12 +6,12 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -129,7 +129,7 @@ static inline void eeh_remove_device(str
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
 
-/* 
+/*
  * MMIO read/write operations with EEH support.
  */
 static inline u8 eeh_readb(const volatile void __iomem *addr)
@@ -251,21 +251,21 @@ static inline void eeh_memcpy_fromio(voi
 		*((u8 *)dest) = *((volatile u8 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
 		vsrc = (void *)((unsigned long)vsrc + 1);
-		dest = (void *)((unsigned long)dest + 1);			
+		dest = (void *)((unsigned long)dest + 1);
 		n--;
 	}
 	while(n > 4) {
 		*((u32 *)dest) = *((volatile u32 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
 		vsrc = (void *)((unsigned long)vsrc + 4);
-		dest = (void *)((unsigned long)dest + 4);			
+		dest = (void *)((unsigned long)dest + 4);
 		n -= 4;
 	}
 	while(n) {
 		*((u8 *)dest) = *((volatile u8 *)vsrc);
 		__asm__ __volatile__ ("eieio" : : : "memory");
 		vsrc = (void *)((unsigned long)vsrc + 1);
-		dest = (void *)((unsigned long)dest + 1);			
+		dest = (void *)((unsigned long)dest + 1);
 		n--;
 	}
 	__asm__ __volatile__ ("sync" : : : "memory");
@@ -287,19 +287,19 @@ static inline void eeh_memcpy_toio(volat
 	while(n && (!EEH_CHECK_ALIGN(vdest, 4) || !EEH_CHECK_ALIGN(src, 4))) {
 		*((volatile u8 *)vdest) = *((u8 *)src);
 		src = (void *)((unsigned long)src + 1);
-		vdest = (void *)((unsigned long)vdest + 1);			
+		vdest = (void *)((unsigned long)vdest + 1);
 		n--;
 	}
 	while(n > 4) {
 		*((volatile u32 *)vdest) = *((volatile u32 *)src);
 		src = (void *)((unsigned long)src + 4);
-		vdest = (void *)((unsigned long)vdest + 4);			
+		vdest = (void *)((unsigned long)vdest + 4);
 		n-=4;
 	}
 	while(n) {
 		*((volatile u8 *)vdest) = *((u8 *)src);
 		src = (void *)((unsigned long)src + 1);
-		vdest = (void *)((unsigned long)vdest + 1);			
+		vdest = (void *)((unsigned long)vdest + 1);
 		n--;
 	}
 	__asm__ __volatile__ ("sync" : : : "memory");

--u3/rZRmxL6MmkK24--
