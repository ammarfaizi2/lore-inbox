Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269608AbUINVsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269608AbUINVsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUINVn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:43:27 -0400
Received: from gw.anda.ru ([212.57.164.72]:44807 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S266175AbUINVja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:39:30 -0400
Date: Wed, 15 Sep 2004 03:39:11 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Gerst <bgerst@didntduck.org>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
Message-ID: <20040915033911.B1621@natasha.ward.six>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Brian Gerst <bgerst@didntduck.org>,
	Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
	Matt Mackall <mpm@selenic.com>
References: <20040915021418.A1621@natasha.ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915021418.A1621@natasha.ward.six>; from zzz@anda.ru on Wed, Sep 15, 2004 at 02:14:18AM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank everybody.

Whould it be better to document the trick?  At least, this will
prevent the others from suspicions.


--- arch/i386/Makefile.orig	2004-08-14 16:55:10.000000000 +0600
+++ arch/i386/Makefile	2004-09-15 03:37:49.000000000 +0600
@@ -20,6 +20,8 @@ OBJCOPYFLAGS	:= -O binary -R .note -R .c
 LDFLAGS_vmlinux :=
 CHECK		:= $(CHECK) -D__i386__=1
 
+# The FP must not be used in the kernel code.  So, the bogus compiler
+# flag is here to catch such an attempts at the link stage.
 CFLAGS += -pipe -msoft-float
 
 # prevent gcc from keeping the stack 16 byte aligned
