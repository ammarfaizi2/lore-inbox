Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTLOROi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTLOROh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:14:37 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:39442 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S263834AbTLOROg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:14:36 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND x 2] Fix booting on a number of Motorola PPC32 machines 
In-reply-to: Your message of "Mon, 15 Dec 2003 09:51:17 PDT."
             <20031215165117.GA11761@stop.crashing.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Dec 2003 04:14:25 +1100
Message-ID: <5232.1071508465@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 09:51:17 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>===== arch/ppc/boot/simple/Makefile 1.23 vs edited =====
>--- 1.23/arch/ppc/boot/simple/Makefile	Mon Sep 15 01:01:24 2003
>+++ edited/arch/ppc/boot/simple/Makefile	Mon Dec  1 12:25:29 2003
>@@ -73,9 +73,8 @@
>    cacheflag-$(CONFIG_K2)		:= -include $(clear_L2_L3)
> 
> # kconfig 'feature', only one of these will ever be 'y' at a time.
>-# The rest will be unset.
>-motorola := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750) \
>-$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
>+# The rest will be unset.  Each of these must be on one line.
>+motorola := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750)$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
> pcore := $(CONFIG_PCORE)$(CONFIG_POWERPMC250)

If you want to keep the original line for readability, follow it with

motorola := $(strip $(motorola))

To remove leading and trailing spaces.

