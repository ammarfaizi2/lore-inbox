Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWFWO2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWFWO2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWFWO2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:28:51 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:10897 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750782AbWFWO2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:28:49 -0400
Date: Fri, 23 Jun 2006 10:28:29 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060623142829.GA4333@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060622145743.2accfeaf.akpm@osdl.org> <20060623025418.GC8316@ccure.user-mode-linux.org> <Pine.LNX.4.64.0606231209000.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606231209000.17704@scrub.home>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 12:10:35PM +0200, Roman Zippel wrote:
> BTW this can be now configured. Check DEFCONFIG_LIST in init/Kconfig in 
> -mm.

So, something like this would be OK in order to have the UML build
just use its own defconfig?

				Jeff

Make the UML build ignore the host configs in /boot, /lib, and /etc
and just use its own defconfig.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/um/Kconfig	2006-06-20 17:24:29.000000000 -0400
+++ linux-2.6.17/arch/um/Kconfig	2006-06-23 10:20:27.000000000 -0400
@@ -1,3 +1,8 @@
+config DEFCONFIG_LIST
+	string
+	option defconfig_list
+	default "arch/um/defconfig"
+
 # UML uses the generic IRQ sugsystem
 config GENERIC_HARDIRQS
 	bool
