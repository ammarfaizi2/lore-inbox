Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263381AbVBEBtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbVBEBtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbVBEBtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:49:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:62948 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266542AbVBEBsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:48:41 -0500
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Andrew Morton <akpm@osdl.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <200502050122.27254.arnd@arndb.de>
References: <20050204072254.GA17565@austin.ibm.com>
	 <200502041336.59892.arnd@arndb.de> <1107560989.2189.119.camel@gaston>
	 <200502050122.27254.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 12:47:05 +1100
Message-Id: <1107568025.2189.136.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is the patch to evaluate CPU_HAS_FEATURE() at compile time whenever
> possible. Testing showed that vmlinux shrinks around 4000 bytes with
> g5_defconfig. I also checked that pSeries code is completely unaltered
> semantically when support for all CPU types is enabled, although a few
> instructions are emitted in a different order by gcc.
> 
> I have made cpu_has_feature() an inline function that expects the full
> name of a feature bit while the CPU_HAS_FEATURE() macro still behaves
> the same way as in Olofs original patch for now.

Note that this doesn't the asm part of it, where feature "sections"
are nop'ed out... it may be interesting to get rid of the nops too
here, oh well, that's too complicated for now.

Ben.


