Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSCKTEi>; Mon, 11 Mar 2002 14:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288248AbSCKTE2>; Mon, 11 Mar 2002 14:04:28 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:9483 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288058AbSCKTDX>;
	Mon, 11 Mar 2002 14:03:23 -0500
Date: Mon, 11 Mar 2002 10:54:35 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] export IO_APIC_get_PCI_irq_vector for IBM PCI Hotplug driver
Message-ID: <20020311185434.GH20606@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.19-pre2 that exports a symbol that is needed
by the IBM PCI hotplug driver if it is built as a module.

thanks,

greg k-h



diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Mon Mar 11 10:47:54 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Mon Mar 11 10:47:54 2002
@@ -146,6 +146,10 @@
 EXPORT_SYMBOL(flush_tlb_page);
 #endif
 
+#ifdef CONFIG_X86_IO_APIC
+EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
+#endif
+
 #ifdef CONFIG_MCA
 EXPORT_SYMBOL(machine_id);
 #endif
