Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162917AbWLBLF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162917AbWLBLF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162418AbWLBK77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759475AbWLBK7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CY8z/H7Ir2KtpBAH2oDZjaYFTUJ4H7CFFsAtwbZl+hf5/IAYcwj5e1nztri4DYALFdBEQ7xxEoa4b+zs0uI+mvaqSZZBUq+5shyW+QCz2jgdNooLnomh8VuWHRUJ0WfYEJ92CcuQdCI6rSUMZF9ZgGf9ePhejpdPXRfDFEIDlNA=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/26] Dynamic kernel command-line - s390
Date: Sat, 2 Dec 2006 12:55:00 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021255.00696.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/s390/kernel/setup.c linux-2.6.19/arch/s390/kernel/setup.c
--- linux-2.6.19.org/arch/s390/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/s390/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -633,7 +633,7 @@ setup_arch(char **cmdline_p)
 #endif /* CONFIG_64BIT */
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
 
 	*cmdline_p = COMMAND_LINE;
 	*(*cmdline_p + COMMAND_LINE_SIZE - 1) = '\0';
