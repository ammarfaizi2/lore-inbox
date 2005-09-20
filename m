Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVITMxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVITMxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVITMxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:53:47 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3271 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965003AbVITMxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:53:47 -0400
Date: Tue, 20 Sep 2005 15:53:36 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050920123149.GA29112@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509201551480.11907@sbz-30.cs.Helsinki.FI>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
 <20050920123149.GA29112@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, I would prefer this one to be applied instead. The other parts should 
be okay, right?

[PATCH] CodingStyle remove sizeof preferred form

It isn't clear that the use of p = kmalloc(sizeof(*p), ...) is
preferred over p = kmalloc(sizeof(struct foo), ...) - in fact,
there are some good reasons to use the latter form.

Therefore, the choice of which to use should be left up to the
developer concerned, and not written in to the coding style.

For discussion, please see the thread:
     http://lkml.org/lkml/2005/9/18/29

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

Index: 2.6/Documentation/CodingStyle
===================================================================
--- 2.6.orig/Documentation/CodingStyle
+++ 2.6/Documentation/CodingStyle
@@ -416,14 +416,6 @@ The kernel provides the following genera
 kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
 documentation for further information about them.
 
-The preferred form for passing a size of a struct is the following:
-
-	p = kmalloc(sizeof(*p), ...);
-
-The alternative form where struct name is spelled out hurts readability and
-introduces an opportunity for a bug when the pointer variable type is changed
-but the corresponding sizeof that is passed to a memory allocator is not.
-
 Casting the return value which is a void pointer is redundant. The conversion
 from void pointer to any other pointer type is guaranteed by the C programming
 language.
