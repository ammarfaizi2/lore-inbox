Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTFGQew (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTFGQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:34:52 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19205 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263250AbTFGQev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:34:51 -0400
Date: Sat, 7 Jun 2003 18:48:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org
Subject: Re: __user annotations
Message-ID: <20030607164825.GA20413@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org
References: <20030607143219.U626@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.4.44.0306070917150.2840-100000@home.transmeta.com> <20030607164330.GA20312@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607164330.GA20312@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 06:43:30PM +0200, Sam Ravnborg wrote:
> Since we start to know your checker by the name sparse, why not
> call the default executable sparse?

And then we can update the top-level Makefile in the kernel.

	Sam

Rename Linus' checker tool to sparse, and avoid the hardcoded path.

===== Makefile 1.410 vs edited =====
--- 1.410/Makefile	Tue Jun  3 23:27:14 2003
+++ edited/Makefile	Sat Jun  7 18:44:22 2003
@@ -204,7 +204,7 @@
 DEPMOD		= /sbin/depmod
 KALLSYMS	= scripts/kallsyms
 PERL		= perl
-CHECK		= /home/torvalds/parser/check
+CHECK		= sparse
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
