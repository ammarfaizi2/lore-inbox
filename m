Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291352AbSBMEfE>; Tue, 12 Feb 2002 23:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291355AbSBMEey>; Tue, 12 Feb 2002 23:34:54 -0500
Received: from holomorphy.com ([216.36.33.161]:33445 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291352AbSBMEei>;
	Tue, 12 Feb 2002 23:34:38 -0500
Date: Tue, 12 Feb 2002 20:34:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Jameson <rj@open-net.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols ipt_owner.o with 2.4.18-pre9 with mjc patch
Message-ID: <20020213043423.GK767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020212214016.7fa188c3.rj@open-net.org> <20020213032402.GC3588@holomorphy.com> <20020212231110.1338a0bd.rj@open-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020212231110.1338a0bd.rj@open-net.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 11:11:10PM -0500, Robert Jameson wrote:
> nope, after doing that i get the following.
> fork.c:39: parse error before
> `this_object_must_be_defined_as_export_objs_in_the_Makefile' fork.c:39:

This is easy too:

--- linux-virgin/kernel/Makefile
+++ linux-wli/kernel/Makefile
@@ -9,7 +9,7 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o fork.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	     module.o exit.o itimer.o info.o time.o softirq.o resource.o \
