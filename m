Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVKDXVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVKDXVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVKDXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:21:14 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:38604 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751045AbVKDXVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:21:12 -0500
Date: Fri, 4 Nov 2005 15:21:09 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: [PATCH 4/4] Memory Add Fixes for ppc64
Message-ID: <20051104232109.GE25545@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104231552.GA25545@w-mikek2.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc64 needs a special sysfs probe file for adding new memory.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.14-git7/arch/ppc64/Kconfig linux-2.6.14-git7.work/arch/ppc64/Kconfig
--- linux-2.6.14-git7/arch/ppc64/Kconfig	2005-11-04 21:21:06.000000000 +0000
+++ linux-2.6.14-git7.work/arch/ppc64/Kconfig	2005-11-04 22:11:16.000000000 +0000
@@ -277,6 +277,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
 # between a node's start and end pfns, it may not
