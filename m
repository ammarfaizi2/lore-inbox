Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTJGX6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTJGX6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:58:39 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:39172 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262637AbTJGX6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:58:38 -0400
Date: Tue, 7 Oct 2003 21:06:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] asus_acpi: don't include modversions.h
Message-ID: <20031008000607.GE5682@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider applying, fixes this when doing a build with
allmodconfig:

  CC [M]  drivers/acpi/asus_acpi.o
drivers/acpi/asus_acpi.c:37:31: linux/modversions.h: Arquivo ou diretório nao encontrado
make[2]: ** [drivers/acpi/asus_acpi.o] Erro 1
make[1]: ** [drivers/acpi] Erro 2
make: ** [drivers] Erro 2

- Arnaldo

===== drivers/acpi/asus_acpi.c 1.4 vs edited =====
--- 1.4/drivers/acpi/asus_acpi.c	Tue Sep 30 21:38:12 2003
+++ edited/drivers/acpi/asus_acpi.c	Tue Oct  7 20:56:24 2003
@@ -33,9 +33,6 @@
  */
 
 #include <linux/config.h>
-#if defined (CONFIG_MODVERSIONS) && !defined (MODVERSIONS) && defined (MODULE)
-#include <linux/modversions.h>
-#endif
 
 #include <linux/kernel.h>
 #include <linux/module.h>
