Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTJMReu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 13:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTJMReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 13:34:50 -0400
Received: from ns.suse.de ([195.135.220.2]:54457 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261838AbTJMRes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 13:34:48 -0400
Date: Mon, 13 Oct 2003 19:34:46 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - stability freeze
Message-ID: <20031013173446.GA13186@suse.de>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Oct 08, Linus Torvalds wrote:

> The more interesting thing is that I and Andrew are trying to calm down 
> development, and I do _not_ want to see patches that don't fix a real and 
> clear bug. In other words, the "cleanup and janitorial" stuff is on hold, 
> and -test8 and then -test9 should be for _stability_ fixes only.

a longstanding bug, should probably go to the main Makefile. But I dont
know if all supported archs know about -msoft-float.


diff -p -purN linux-2.6.0-test7/arch/i386/Makefile linux-2.6.0-test7.fpu/arch/i386/Makefile
--- linux-2.6.0-test7/arch/i386/Makefile	2003-10-08 21:24:04.000000000 +0200
+++ linux-2.6.0-test7.fpu/arch/i386/Makefile	2003-10-13 19:26:21.000000000 +0200
@@ -19,7 +19,7 @@ LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=
 
-CFLAGS += -pipe
+CFLAGS += -pipe -msoft-float
 
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
-- 


USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
