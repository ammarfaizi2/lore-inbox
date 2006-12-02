Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162942AbWLBLCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162942AbWLBLCX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162927AbWLBLA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:62694 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759462AbWLBK7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uZFceLc26IK/fr5DK1D9Ew8cMA2OmkiQ3jPuQ7cTRCRg99PasE4J3OKoN+ulbYqpk6S486oBBHCIKxbKSxxMobNp/CuwdTSyh4s6dcW/7oVld5Lzm/RHB8VEhewug7MnJIlcqCPMW4Awbo67mDJ9e9GCPOU9O7KmQGXxZud9DTA=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/26] Dynamic kernel command-line - m68k
Date: Sat, 2 Dec 2006 12:52:36 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021252.37087.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/m68k/kernel/setup.c linux-2.6.19/arch/m68k/kernel/setup.c
--- linux-2.6.19.org/arch/m68k/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/m68k/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -256,7 +256,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) &_end;
 
 	*cmdline_p = m68k_command_line;
-	memcpy(saved_command_line, *cmdline_p, CL_SIZE);
+	memcpy(boot_command_line, *cmdline_p, CL_SIZE);
 
 	/* Parse the command line for arch-specific options.
 	 * For the m68k, this is currently only "debug=xxx" to enable printing
