Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbREPDUF>; Tue, 15 May 2001 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbREPDTz>; Tue, 15 May 2001 23:19:55 -0400
Received: from [192.48.153.1] ([192.48.153.1]:38518 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S261776AbREPDTs>;
	Tue, 15 May 2001 23:19:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Kernel 2.2.19 + VIA chipset + strange behaviour 
In-Reply-To: Your message of "Wed, 16 May 2001 11:15:44 +0930."
             <200105160145.LAA11531@mercury.physics.adelaide.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 13:17:08 +1000
Message-ID: <21514.989983028@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug in include/linux/module.h.  Patch against 2.2.19.  This does not
explain your oops, the ksymoops message is a separate bug.

Index: 19.1/include/linux/module.h
--- 19.1/include/linux/module.h Tue, 12 Sep 2000 13:37:17 +1100 kaos (linux-2.2/F/51_module.h 1.1.7.2 644)
+++ 19.1(w)/include/linux/module.h Wed, 16 May 2001 12:52:53 +1000 kaos (linux-2.2/F/51_module.h 1.1.7.2 644)
@@ -228,9 +228,9 @@ const char __module_using_checksums[] __
 #define MOD_DEC_USE_COUNT	do { } while (0)
 #define MOD_IN_USE		1
 
-extern struct module *module_list;
-
 #endif /* !__GENKSYMS__ */
+
+extern struct module *module_list;
 
 #endif /* MODULE */
 

