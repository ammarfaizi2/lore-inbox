Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbREOPeC>; Tue, 15 May 2001 11:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbREOPdw>; Tue, 15 May 2001 11:33:52 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:54792 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262789AbREOPdm>; Tue, 15 May 2001 11:33:42 -0400
Date: Tue, 15 May 2001 17:30:59 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] fix yenta_socket
Message-ID: <20010515173059.F25153@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The PCI allocation fix in 2.4.5-pre2 breaks yenta_socket because it
depends on pci_mem_start from arch/i386/kernel/setup.c. This patch
fixes that by exporting pci_mem_start. Please apply.


Erik


--- arch/i386/kernel/i386_ksyms.c.orig	Tue May 15 17:21:37 2001
+++ arch/i386/kernel/i386_ksyms.c	Tue May 15 16:56:25 2001
@@ -112,6 +112,7 @@
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(pcibios_penalize_isa_irq);
+EXPORT_SYMBOL(pci_mem_start);
 #endif
 
 #ifdef CONFIG_X86_USE_3DNOW


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
