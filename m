Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUCABkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCABkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:40:21 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:11781 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262076AbUCABkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:40:16 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1
Date: Mon, 1 Mar 2004 02:39:11 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040229140617.64645e80.akpm@osdl.org>
In-Reply-To: <20040229140617.64645e80.akpm@osdl.org>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/QpQACMSBYuzS37"
Message-Id: <200403010239.11725@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/QpQACMSBYuzS37
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 29 February 2004 23:06, Andrew Morton wrote:

Hi Andrew,

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6
>.4-rc1-mm1/
> +modular-mce-handler.patch
>  permit the x86 MCE handler to be used as a module.

This needs following patch for module, otherwise there's an unresolved symbol.

ciao, Marc

--Boundary-00=_/QpQACMSBYuzS37
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.4-rc1-mm1-fixups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.4-rc1-mm1-fixups.patch"

--- old/arch/i386/kernel/i386_ksyms.c	2004-03-01 02:34:02.000000000 +0100
+++ new/arch/i386/kernel/i386_ksyms.c	2004-03-01 02:36:05.000000000 +0100
@@ -206,3 +206,8 @@ EXPORT_SYMBOL(ist_info);
 #endif
 
 EXPORT_SYMBOL(csum_partial);
+
+#ifdef CONFIG_X86_MCE_NONFATAL_MODULE
+extern int (nr_mce_banks);
+EXPORT_SYMBOL(nr_mce_banks);
+#endif

--Boundary-00=_/QpQACMSBYuzS37--
