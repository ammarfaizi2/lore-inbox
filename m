Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSFJXC6>; Mon, 10 Jun 2002 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSFJXC5>; Mon, 10 Jun 2002 19:02:57 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:15624 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316503AbSFJXC5>;
	Mon, 10 Jun 2002 19:02:57 -0400
Date: Mon, 10 Jun 2002 15:59:16 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI Hotplug ACPI driver minor fix.
Message-ID: <20020610225915.GA5067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.19-pre10 that exports a needed symbol from
the ACPI core.  This symbol is needed for the PCI Hotplug ACPI driver.

thanks,

greg k-h


diff -Naur -X ../dontdiff a/drivers/acpi/acpi_ksyms.c b/drivers/acpi/acpi_ksyms.c
--- a/drivers/acpi/acpi_ksyms.c	Mon Jun 10 12:07:36 2002
+++ a/drivers/acpi/acpi_ksyms.c	Thu Feb 21 15:19:37 2002
@@ -106,6 +106,7 @@
 EXPORT_SYMBOL(acpi_enter_sleep_state);
 EXPORT_SYMBOL(acpi_get_system_info);
 EXPORT_SYMBOL(acpi_leave_sleep_state);
+EXPORT_SYMBOL(acpi_walk_namespace);
 /*EXPORT_SYMBOL(acpi_save_state_mem);*/
 /*EXPORT_SYMBOL(acpi_save_state_disk);*/
 EXPORT_SYMBOL(acpi_hw_register_read);

