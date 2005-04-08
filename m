Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVDHWZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDHWZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDHWXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:23:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:58499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261174AbVDHWVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:21:22 -0400
Date: Fri, 8 Apr 2005 15:21:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc2-mm2
Message-Id: <20050408152126.3b1c03ac.akpm@osdl.org>
In-Reply-To: <425691BD.9080507@portrix.net>
References: <20050408030835.4941cd98.akpm@osdl.org>
	<425691BD.9080507@portrix.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <j.dittmer@portrix.net> wrote:
>
> Andrew Morton wrote:
> > - The bk-acpi patch here causes my ia64 test box to hang during boot
> 
> >  bk-ia64.patch
> 
> ia64 defconfig does not even build anymore:
> 
> 
>   CC [M]  drivers/char/agp/hp-agp.o
> In file included from /usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:18:
> include2/asm/acpi-ext.h:15: error: parse error before "hp_acpi_csr_space"
> include2/asm/acpi-ext.h:15: error: parse error before "u64"
> include2/asm/acpi-ext.h:15: warning: type defaults to `int' in declaration of `hp_acpi_csr_space'

I suppose this is needed.

--- 25/include/asm-ia64/acpi-ext.h~acpi-ext-build-fix	Fri Apr  8 15:19:43 2005
+++ 25-akpm/include/asm-ia64/acpi-ext.h	Fri Apr  8 15:20:12 2005
@@ -11,6 +11,7 @@
 #define _ASM_IA64_ACPI_EXT_H
 
 #include <linux/types.h>
+#include <acpi/actypes.h>
 
 extern acpi_status hp_acpi_csr_space (acpi_handle, u64 *base, u64 *length);
 
_

