Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287827AbSAXNiu>; Thu, 24 Jan 2002 08:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSAXNin>; Thu, 24 Jan 2002 08:38:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22152 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287827AbSAXNi2>;
	Thu, 24 Jan 2002 08:38:28 -0500
Date: Thu, 24 Jan 2002 05:36:52 -0800 (PST)
Message-Id: <20020124.053652.85395471.davem@redhat.com>
To: adam@yggdrasil.com
Cc: jes@trained-monkey.org, linux-acenic@sunsite.dk,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not
 defined for x86
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201241001.CAA00304@baldur.yggdrasil.com>
In-Reply-To: <200201241001.CAA00304@baldur.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Thu, 24 Jan 2002 02:01:55 -0800

   	linux-2.5.3-pre4/drivers/acenic.c uses pci_unmap_addr_set,
   which is defined for most architectures in include/asm-*/pci.h, but
   not for i386.  For i386 this results in undefined references.  I
   imagine that this is the result of a missed file (include/asm-i386/pci.h?)
   from an Acenic update patch.
   
No, just a dumb typo:

--- include/asm-i386/pci.h.~1~	Tue Jan 15 10:59:36 2002
+++ include/asm-i386/pci.h	Thu Jan 24 05:32:28 2002
@@ -118,7 +118,7 @@
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
 #define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
 #define pci_unmap_addr(PTR, ADDR_NAME)		(0)
-#define pci_unmap_addr_SET(PTR, ADDR_NAME, VAL)	do { } while (0)
+#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
 
