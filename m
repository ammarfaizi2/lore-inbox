Return-Path: <linux-kernel-owner+w=401wt.eu-S933004AbWLSXhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbWLSXhu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933009AbWLSXhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:37:50 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:42339 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933004AbWLSXhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:37:50 -0500
X-Originating-Ip: 24.163.66.209
Date: Tue, 19 Dec 2006 18:32:01 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ok, maybe i misread that whole "kmem_cache_alloc()" thing
Message-ID: <Pine.LNX.4.64.0612191829510.14612@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-12.808, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  all right, i may have misread what's going on with
kmem_cache_alloc() and kmem_cache_zalloc(), and my earlier submission
may be entirely nonsense, since it involved transformations like this:

         * it with privilege level 3 because the IVE uses non-privileged accesses to these
         * tables.  IA-32 segmentation is used to protect against IA-32 accesses to them.
         */
-       vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+       vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
        if (vma) {
-               memset(vma, 0, sizeof(*vma));
                vma->vm_mm = current->mm;
                vma->vm_start = IA32_GDT_OFFSET;
                vma->vm_end = vma->vm_start + PAGE_SIZE;


can someone briefly tell me if what i did makes sense?

rday
