Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUHEE6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUHEE6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267544AbUHEE5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:57:01 -0400
Received: from holomorphy.com ([207.189.100.168]:3521 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267540AbUHEEzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:55:33 -0400
Date: Wed, 4 Aug 2004 21:55:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [10/13] sun4 does not support SMP
Message-ID: <20040805045528.GB2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com> <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com> <20040805044950.GZ2334@holomorphy.com> <20040805045417.GA2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805045417.GA2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:54:17PM -0700, William Lee Irwin III wrote:
> This variable is unused and causes noisy compiles.

The sun4 port does not support SMP. Disable it via Kconfig.

Index: mm2-2.6.8-rc2/arch/sparc/Kconfig
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/Kconfig
+++ mm2-2.6.8-rc2/arch/sparc/Kconfig
@@ -221,6 +221,7 @@
 
 config SUN4
 	bool "Support for SUN4 machines (disables SUN4[CDM] support)"
+	depends on !SMP
 	help
 	  Say Y here if, and only if, your machine is a sun4. Note that
 	  a kernel compiled with this option will run only on sun4.
