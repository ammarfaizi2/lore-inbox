Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbUDGVyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbUDGVyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:54:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:62170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264189AbUDGVuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:50:39 -0400
Date: Wed, 7 Apr 2004 14:51:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ak@suse.de, mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-Id: <20040407145130.4b1bdf3e.akpm@osdl.org>
In-Reply-To: <1081373058.9061.16.camel@arrakis>
References: <1081373058.9061.16.camel@arrakis>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> Just from the patches you posted, I would really disagree that these are
> ready for merging into -mm.

I have them all merged up here.  I made a number of small changes -
additional CONFIG_NUMA ifdefs, whitespace improvements, remove unneeded
arch_hugetlb_fault() implementation.  The core patch created two copies of
the same file in mempolicy.h, compile fix in mmap.c and a few other things.

It builds OK for NUMAQ, although NUMAQ does have a problem:

drivers/built-in.o: In function `acpi_pci_root_add':
drivers/built-in.o(.text+0x22015): undefined reference to `pci_acpi_scan_root'

ppc64+CONFIG_NUMA compiles OK.

