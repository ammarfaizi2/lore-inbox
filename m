Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTFGHEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTFGHEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:04:37 -0400
Received: from mail019.syd.optusnet.com.au ([210.49.20.160]:57814 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262636AbTFGHEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:04:36 -0400
Date: Sat, 7 Jun 2003 17:16:24 +1000
To: khromy <khromy@lnuxlab.ath.cx>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIV-PATCH] Better CONFIG_X86_GENERIC description (was: Re: Generic x86 support in 2.5.70-bk)
Message-ID: <20030607071624.GB1540@cancer>
References: <20030601182532.GA1948@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601182532.GA1948@lnuxlab.ath.cx>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jun 01, 2003 at 02:25:32PM -0400, khromy wrote:
> Generic x86 support (X86_GENERIC) [N/y/?] (NEW) ?
> ^-- Am I the only one confused by this description?

No, it's a bit funny (no, not ha-ha funny). Maybe this is a bit clearer?


--- linux-2.5.70-bk11-orig/arch/i386/Kconfig	2003-06-06 23:55:43.000000000 +1000
+++ linux-2.5.70-bk11stew1/arch/i386/Kconfig	2003-06-07 17:11:16.000000000 +1000
@@ -289,9 +289,13 @@
 config X86_GENERIC
        bool "Generic x86 support" 
        help
-       	  Including some tuning for non selected x86 CPUs too.
-	  when it has moderate overhead. This is intended for generic 
-	  distributions kernels.
+	  Instead of just including optimizations for the selected
+	  x86 variant (e.g. PII, Crusoe or Athlon), include some more
+	  generic optimizations as well. This will make the kernel
+	  perform better on x86 CPUs other than that selected.
+
+	  This is really intended for distributors who need more
+	  generic optimizations.
 
 #
 # Define implied options from the CPU selection here
