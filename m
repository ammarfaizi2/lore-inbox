Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVBRS3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVBRS3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVBRS3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:29:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:18660 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261426AbVBRS3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:29:00 -0500
Subject: [PATCH] 2.6.10 patch to export kallsyms_lookup_name()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-PM6aNuFQUzm/ntafT3/b"
Organization: 
Message-Id: <1108751348.20053.1756.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Feb 2005 10:29:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PM6aNuFQUzm/ntafT3/b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Trivial patch to export kallsyms_lookup_name() for
kprobe/jprobe module use.

Please apply. 

(BTW, I personally don't care if it should be
EXPORT_SYMBOL_GPL or EXPORT_SYMBOL).

Thanks,
Badari



--=-PM6aNuFQUzm/ntafT3/b
Content-Disposition: attachment; filename=kallsym.patch
Content-Type: text/plain; name=kallsym.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10.org/kernel/kallsyms.c	2005-02-18 11:18:54.004259856 -0800
+++ linux-2.6.10/kernel/kallsyms.c	2005-02-18 11:20:01.619980704 -0800
@@ -382,3 +382,4 @@ int __init kallsyms_init(void)
 __initcall(kallsyms_init);
 
 EXPORT_SYMBOL(__print_symbol);
+EXPORT_SYMBOL(kallsyms_lookup_name);

--=-PM6aNuFQUzm/ntafT3/b--

