Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTKTU6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 15:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTKTU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 15:58:54 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:60685 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262110AbTKTU6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 15:58:53 -0500
Date: Thu, 20 Nov 2003 19:01:56 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove include recursion from linux/pagemap.h
Message-ID: <20031120210156.GV30259@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	I don't know if this qualifies for the current patch acceptance mode,
but I found it "funny" enough to send a patch.

- Arnaldo

===== include/linux/pagemap.h 1.37 vs edited =====
--- 1.37/include/linux/pagemap.h	Tue Aug 19 02:38:39 2003
+++ edited/include/linux/pagemap.h	Thu Nov 20 18:57:09 2003
@@ -8,7 +8,6 @@
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
-#include <linux/pagemap.h>
 #include <asm/uaccess.h>
 #include <linux/gfp.h>
 
