Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTFGQ35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTFGQ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:29:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:48132 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262598AbTFGQ34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:29:56 -0400
Date: Sat, 7 Jun 2003 18:43:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org
Subject: Re: __user annotations
Message-ID: <20030607164330.GA20312@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org
References: <20030607143219.U626@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.4.44.0306070917150.2840-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306070917150.2840-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 09:25:43AM -0700, Linus Torvalds wrote:
> 
> You can even have user pointers _inside_ the structure: because "sparse" 

Since we start to know your checker by the name sparse, why not
call the default executable sparse?

	Sam

===== Makefile 1.21 vs edited =====
--- 1.21/Makefile	Tue Jun  3 03:15:27 2003
+++ edited/Makefile	Sat Jun  7 18:41:15 2003
@@ -2,7 +2,7 @@
 CFLAGS=-g -Wall
 AR=ar
 
-PROGRAMS=test-lexing test-parsing obfuscate check
+PROGRAMS=test-lexing test-parsing obfuscate sparse
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h
 
@@ -22,7 +22,7 @@
 obfuscate: obfuscate.o $(LIB_FILE)
 	gcc -o $@ $< $(LIB_FILE)
 
-check: check.o $(LIB_FILE)
+sparse: check.o $(LIB_FILE)
 	gcc -o $@ $< $(LIB_FILE)
 
 $(LIB_FILE): $(LIB_OBJS)
