Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbUKPMnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUKPMnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 07:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUKPMnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 07:43:22 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:28167 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261963AbUKPMnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:43:20 -0500
Date: Tue, 16 Nov 2004 12:42:01 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Nickolai Zeldovich <kolya@MIT.EDU>, linux-kernel@vger.kernel.org,
       csapuntz@stanford.edu, hiroit@mcn.ne.jp
Subject: RE: [patch] Fix GDT re-load on ACPI resume
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.58L.0411161237020.17411@blysk.ds.pg.gda.pl>
References: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Li, Shaohua wrote:

> There is a patch from hiroit@mcn.ne.jp to fix the GDT issue. You can try
> it.
> Please cc 'acpi-devel@lists.sourceforge.net' for suspend/resume issue.

 What is the "gdt body must be addressable from real mode" requirement
about?  GDT is addressed by the CPU using a linear address as obtained
from GDTR (bypassing segmentation, for obvious reasons) and is accessible
regardless of its placement within the 32-bit linear address space in all
CPU modes.  As its a linear address it only undergoes translation at the
page level, if enabled.  The same applies to IDT.

  Maciej
