Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWFUAXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWFUAXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWFUAXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:23:15 -0400
Received: from xenotime.net ([66.160.160.81]:34961 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751874AbWFUAXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:23:14 -0400
Date: Tue, 20 Jun 2006 17:26:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christian.Limpach@cl.cam.ac.uk, chrisw@sous-sol.org
Subject: Re: [PATCH] Implement kasprintf
Message-Id: <20060620172600.9294cd00.rdunlap@xenotime.net>
In-Reply-To: <44988F7F.2010502@goop.org>
References: <44988B5C.9080400@goop.org>
	<20060620171020.301add23.rdunlap@xenotime.net>
	<44988F7F.2010502@goop.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 17:14:55 -0700 Jeremy Fitzhardinge wrote:

> Randy.Dunlap wrote:
> > Why do we want a separate source file for this one function?
> >   
> Because if it shared a file with something else, someone would complain 
> about it bloating code which doesn't use it...  At the moment there are 
> no in-tree users (though I'm sure there's something out there with an 
> open-coded version of this), but we'll be needing it for Xen.

Doesn't this already add the bloat/code? ::

diff -r c175fd50e604 lib/Makefile
--- a/lib/Makefile	Tue Jun 20 16:47:53 2006 -0700
+++ b/lib/Makefile	Tue Jun 20 16:53:19 2006 -0700
@@ -5,7 +5,7 @@ lib-y := errno.o ctype.o string.o vsprin
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o kasprintf.o

> I'm happy to fold it into vsprintf.c though.

That makes sense to me.

Thanks,
---
~Randy
