Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTLWR3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTLWR3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:29:11 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:15054 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261796AbTLWR3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:29:08 -0500
Date: Tue, 23 Dec 2003 10:29:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223172907.GF26574@stop.crashing.org>
References: <20031222211131.70a963fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222211131.70a963fb.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 09:11:31PM -0800, Andrew Morton wrote:

[snip]
> moto-ppc32-booting-fix.patch
>   Fix booting on a number of Motorola PPC32 machines

The following, based on comments from Keith Owens is better, please
replace, thanks:
===== arch/ppc/boot/simple/Makefile 1.23 vs edited =====
--- 1.23/arch/ppc/boot/simple/Makefile	Mon Sep 15 01:01:24 2003
+++ edited/arch/ppc/boot/simple/Makefile	Tue Dec 23 09:58:53 2003
@@ -76,6 +76,7 @@
 # The rest will be unset.
 motorola := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750) \
 $(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
+motorola := $(strip $(motorola))
 pcore := $(CONFIG_PCORE)$(CONFIG_POWERPMC250)
 
       zimage-$(motorola)		:= zImage-PPLUS


-- 
Tom Rini
http://gate.crashing.org/~trini/
