Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUAIXrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUAIXrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:47:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27350 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264286AbUAIXrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:47:13 -0500
Date: Sat, 10 Jan 2004 00:47:03 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org
Subject: [2.6 patch] ia64: use range for NR_CPUS
Message-ID: <20040109234703.GM1440@fs.tum.de>
References: <20040109013850.GI13867@fs.tum.de> <20040108211706.7772da92.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108211706.7772da92.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 09:17:06PM -0800, Paul Jackson wrote:
> > The help text on ia64 didn't suggest any values. Could someone tell the 
> > correct values for ia64 (and if it's only a minimum value of 2)?
> 
> It keeps moving.  We've announced experimental versions up to 512 CPUs,
> I believe.  We being SGI, and our SN product, which uses ia64 arch.  So
> I guess you can put that in.

Thanks for this information.

The patch to use "range" for NR_CPUS on ia64 is below.

cu
Adrian

--- linux-2.6.1-mm1/arch/ia64/Kconfig.old	2004-01-10 00:44:19.000000000 +0100
+++ linux-2.6.1-mm1/arch/ia64/Kconfig	2004-01-10 00:45:17.000000000 +0100
@@ -411,7 +411,8 @@
 	  support" (CONFIG_PROC_FS) is enabled, too.
 
 config NR_CPUS
-	int "Maximum number of CPUs"
+	int "Maximum number of CPUs (2-512)"
+	range 2 512
 	depends on SMP
 	default "64"
 	help
