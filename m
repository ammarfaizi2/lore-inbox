Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbVBEBye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbVBEBye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbVBEByd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:54:33 -0500
Received: from ozlabs.org ([203.10.76.45]:16561 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262991AbVBEByI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:54:08 -0500
Date: Sat, 5 Feb 2005 12:34:26 +1100
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Message-ID: <20050205013426.GC11318@krispykreme.ozlabs.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com> <200502041336.59892.arnd@arndb.de> <1107560989.2189.119.camel@gaston> <200502050122.27254.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502050122.27254.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> This is the patch to evaluate CPU_HAS_FEATURE() at compile time whenever
> possible. Testing showed that vmlinux shrinks around 4000 bytes with
> g5_defconfig. I also checked that pSeries code is completely unaltered
> semantically when support for all CPU types is enabled, although a few
> instructions are emitted in a different order by gcc.
> 
> I have made cpu_has_feature() an inline function that expects the full
> name of a feature bit while the CPU_HAS_FEATURE() macro still behaves
> the same way as in Olofs original patch for now.

Interesting :) However we already get bug reports with the current
CONFIG_POWER4_ONLY option. I worry about adding more options that users
could get wrong unless there is a noticeable improvement in performance.

Anton
