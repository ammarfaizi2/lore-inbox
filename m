Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUHEE6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUHEE6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUHEE5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:57:15 -0400
Received: from holomorphy.com ([207.189.100.168]:4033 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267545AbUHEE4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:56:49 -0400
Date: Wed, 4 Aug 2004 21:56:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [11/13] make CONFIG_SMP depend on CONFIG_BROKEN
Message-ID: <20040805045643.GC2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com> <20040805044950.GZ2334@holomorphy.com> <20040805045417.GA2334@holomorphy.com> <20040805045528.GB2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805045528.GB2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:55:28PM -0700, William Lee Irwin III wrote:
> The sun4 port does not support SMP. Disable it via Kconfig.

SMP support is in need of a great deal of work to port it from 2.2 and
2.4. Add a dependency on BROKEN in the Kconfig to warn the unwary.

Index: mm2-2.6.8-rc2/arch/sparc/Kconfig
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/Kconfig
+++ mm2-2.6.8-rc2/arch/sparc/Kconfig
@@ -83,6 +83,7 @@
 
 config SMP
 	bool "Symmetric multi-processing support (does not work on sun4/sun4c)"
+	depends on BROKEN
 	---help---
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
