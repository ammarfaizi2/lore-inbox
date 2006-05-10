Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWEJPZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWEJPZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWEJPZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:25:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45544 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751471AbWEJPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:25:29 -0400
Subject: Re: [Xen-devel] [RFC PATCH 01/35] Add XEN config options and
	disable unsupported config options.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
In-Reply-To: <20060509085145.790527000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085145.790527000@sous-sol.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 16:36:58 +0100
Message-Id: <1147275418.17886.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> plain text document atodiad (config-xen)
> The XEN config option is selected from the i386 subarch menu by
> choosing the X86_XEN "Xen-compatible" subarch.

You need this as well. At least if I read the logic right with regards
to Xen and traps it is safe to do the following (although probably not
safe to run Xen on such a physical system anyway)

Signed-off-by: Alan Cox <alan@redhat.com>

--- arch/i386/Kconfig.cpu~	2006-05-10 15:51:44.956941304 +0100
+++ arch/i386/Kconfig.cpu	2006-05-10 15:51:44.956941304 +0100
@@ -251,7 +251,7 @@
 
 config X86_F00F_BUG
 	bool
-	depends on M586MMX || M586TSC || M586 || M486 || M386
+	depends on ( M586MMX || M586TSC || M586 || M486 || M386 ) && !XEN
 	default y
 
 config X86_WP_WORKS_OK

