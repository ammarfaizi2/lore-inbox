Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVCGVeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVCGVeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVCGV2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:28:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:18120 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261782AbVCGVTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:19:22 -0500
Subject: Re: 2.6.11-mm1 (x86-abstract-discontigmem-setup.patch)
From: Dave Hansen <haveblue@us.ibm.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503060121.19354.adobriyan@mail.ru>
References: <200503051535.24372.adobriyan@mail.ru>
	 <1110049138.6446.3.camel@localhost>  <200503060121.19354.adobriyan@mail.ru>
Content-Type: multipart/mixed; boundary="=-583yTQ1BjdOiz8y5BsZY"
Date: Mon, 07 Mar 2005 13:19:10 -0800
Message-Id: <1110230350.6446.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-583yTQ1BjdOiz8y5BsZY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I hit send on that other one accidentally...

I believe the attached patch should fix the extra output.  Compiles on
my normal summit discontig configuration.  Andrew, please apply some
time after x86-abstract-discontigmem-setup-fix.patch in your series.

-- Dave

--=-583yTQ1BjdOiz8y5BsZY
Content-Disposition: attachment; filename=x86-abstract-discontigmem-setup-fix-printk.patch
Content-Type: text/x-patch; name=x86-abstract-discontigmem-setup-fix-printk.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 clean-dave/arch/i386/mm/discontig.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/mm/discontig.c~x86-abstract-discontigmem-setup-fix-printk arch/i386/mm/discontig.c
--- clean/arch/i386/mm/discontig.c~x86-abstract-discontigmem-setup-fix-printk	2005-03-07 10:40:53.000000000 -0800
+++ clean-dave/arch/i386/mm/discontig.c	2005-03-07 10:41:29.000000000 -0800
@@ -70,9 +70,9 @@ void memory_present(int nid, unsigned lo
 	printk(KERN_DEBUG "  ");
 	for (pfn = start; pfn < end; pfn += PAGES_PER_ELEMENT) {
 		physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
-		printk(KERN_DEBUG "%ld ", pfn);
+		printk("%ld ", pfn);
 	}
-	printk(KERN_DEBUG "\n");
+	printk("\n");
 }
 
 unsigned long node_memmap_size_bytes(int nid, unsigned long start_pfn,
_

--=-583yTQ1BjdOiz8y5BsZY--

