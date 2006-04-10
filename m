Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWDJWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWDJWyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWDJWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:54:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:48615 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932161AbWDJWyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:54:18 -0400
X-Authenticated: #704063
Subject: [Patch] Use of NULL variable in scripts/mod/modpost.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 00:54:16 +0200
Message-Id: <1144709657.31850.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

before is NULL in this case, concluding from the surrounding code
it seems that after is the right one to use.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/scripts/mod/modpost.c.orig	2006-04-11 00:50:34.000000000 +0200
+++ linux-2.6.17-rc1/scripts/mod/modpost.c	2006-04-11 00:50:47.000000000 +0200
@@ -658,7 +658,7 @@ static void warn_sec_mismatch(const char
 		warn("%s - Section mismatch: reference to %s:%s from %s "
 		     "before '%s' (at offset -0x%llx)\n",
 		     modname, secname, refsymname, fromsec,
-		     elf->strtab + before->st_name,
+		     elf->strtab + after->st_name,
 		     (long long)r.r_offset);
 	} else {
 		warn("%s - Section mismatch: reference to %s:%s from %s "


