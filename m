Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbUDGVYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264171AbUDGVYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:24:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:52371 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264041AbUDGVYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:24:33 -0400
Subject: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081373058.9061.16.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 14:24:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,
	I must be missing something here, but did you not include mempolicy.h
and policy.c in these patches?  I can't seem to find them anywhere?!? 
It's really hard to evaluate your patches if the core of them is
missing!

Andrew already mentioned your mistake on the i386 syscalls which needs
to be fixed.

Also, this snippet of code is in 2 of your patches (#1 and #6) causing
rejects:

@@ -435,6 +445,8 @@
 
 struct page *shmem_nopage(struct vm_area_struct * vma,
                         unsigned long address, int *type);
+int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy
*new);
+struct mempolicy *shmem_get_policy(struct vm_area_struct *vma, unsigned
long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long
flags);
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);



Just from the patches you posted, I would really disagree that these are
ready for merging into -mm.

-Matt

