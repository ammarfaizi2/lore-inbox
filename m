Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVCOAIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVCOAIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVCOAH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:07:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:53725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262140AbVCOAHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:07:10 -0500
Date: Mon, 14 Mar 2005 16:00:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: ak@suse.de, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86-64: add memcpy/memset prototypes
Message-Id: <20050314160041.4522bb3a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)

Put function prototypes for memset() and memcpy() ahead of where
there are used, to kill sparse warnings:

arch/x86_64/boot/compressed/../../../../lib/inflate.c:317:3: warning: undefined identifier 'memset'
arch/x86_64/boot/compressed/../../../../lib/inflate.c:601:11: warning: undefined identifier 'memcpy'
arch/x86_64/boot/compressed/misc.c:151:2: warning: undefined identifier 'memcpy'
arch/x86_64/boot/compressed/../../../../lib/inflate.c:317:3: warning: call with no type!
arch/x86_64/boot/compressed/../../../../lib/inflate.c:601:17: warning: call with no type!
arch/x86_64/boot/compressed/misc.c:151:9: warning: call with no type!

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/x86_64/boot/compressed/misc.c |    3 +++
 1 files changed, 3 insertions(+)

diff -Naurp ./arch/x86_64/boot/compressed/misc.c~misc_includes ./arch/x86_64/boot/compressed/misc.c
--- ./arch/x86_64/boot/compressed/misc.c~misc_includes	2004-12-24 13:34:32.000000000 -0800
+++ ./arch/x86_64/boot/compressed/misc.c	2005-02-16 10:37:48.988294016 -0800
@@ -92,6 +92,9 @@ static unsigned long output_ptr = 0;
 static void *malloc(int size);
 static void free(void *where);
  
+void* memset(void* s, int c, unsigned n);
+void* memcpy(void* dest, const void* src, unsigned n);
+
 static void putstr(const char *);
   
 extern int end;

---
