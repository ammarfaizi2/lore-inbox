Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbULACSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbULACSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 21:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULACSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 21:18:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:28369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261162AbULACSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 21:18:42 -0500
Date: Tue, 30 Nov 2004 18:18:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build problem with 2.6.10-rc2-mm4: undefined reference to
 `acpi_boot_table_init'
Message-Id: <20041130181817.5268fdeb.akpm@osdl.org>
In-Reply-To: <1101861462.4087.7.camel@localhost>
References: <1101861462.4087.7.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>  arch/i386/kernel/built-in.o(.init.text+0x167a): In function
>  `setup_frame':
>  include/asm/thread_info.h:89: undefined reference to
>  `acpi_boot_table_init'

--- 25/include/linux/acpi.h~x86_64-split-acpi-boot-table-parsing-fix	2004-11-30 18:16:49.597262704 -0800
+++ 25-akpm/include/linux/acpi.h	2004-11-30 18:17:12.974708792 -0800
@@ -418,6 +418,10 @@ static inline int acpi_boot_init(void)
 	return 0;
 }
 
+static inline int acpi_boot_table_init(void)
+{
+	return 0;
+}
 
 static inline int acpi_table_init(void)
 {
_

