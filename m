Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUJDUkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUJDUkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268479AbUJDUkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:40:47 -0400
Received: from zero.aec.at ([193.170.194.10]:35854 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268470AbUJDUkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:40:42 -0400
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.9-rc3-mm[12]: x86-64-clustered-apic-support.patch problem
References: <2LHjU-fJ-49@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 04 Oct 2004 22:40:34 +0200
In-Reply-To: <2LHjU-fJ-49@gated-at.bofh.it> (Rafael J. Wysocki's message of
 "Mon, 04 Oct 2004 22:10:14 +0200")
Message-ID: <m3pt3yushp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Andrew,
>
> The patch x86-64-clustered-apic-support.patch causes the 2.6.9-rc3-mm[12] 
> kernel to crash at startup on a single-CPU AMD64 box :

This untested patch may fix it. Does it?

-Andi

Index: linux/arch/x86_64/kernel/genapic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/genapic.c	2004-10-03 16:28:07.%N +0200
+++ linux/arch/x86_64/kernel/genapic.c	2004-10-03 17:05:10.%N +0200
@@ -27,7 +27,7 @@
 extern struct genapic apic_cluster;
 extern struct genapic apic_flat;
 
-struct genapic *genapic;
+struct genapic *genapic = &apic_flat;
 
 
 /*

