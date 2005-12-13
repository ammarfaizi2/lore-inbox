Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVLMIt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVLMIt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbVLMIt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:49:29 -0500
Received: from ns2.suse.de ([195.135.220.15]:36537 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932549AbVLMIt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:49:28 -0500
Date: Tue, 13 Dec 2005 09:49:26 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213084926.GN23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213004257.0f87d814.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's time to give up on it and just drink more coffee or play more tetris
> or something, I'm afraid.

Or start using icecream (http://wiki.kde.org/icecream) 

Anyways cool.  Gratulations. Can you please apply the following patch then? 

Remove -Wdeclaration-after-statement

Now that gcc 2.95 is not supported anymore it's ok to use C99
style mixed declarations everywhere.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/Makefile
===================================================================
--- linux/Makefile
+++ linux/Makefile
@@ -535,9 +535,6 @@ include $(srctree)/arch/$(ARCH)/Makefile
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
-# warn about C99 declaration after statement
-CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
-
 # disable pointer signedness warnings in gcc 4.0
 CFLAGS += $(call cc-option,-Wno-pointer-sign,)
 
