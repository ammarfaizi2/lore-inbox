Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWB0FMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWB0FMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 00:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWB0FMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 00:12:07 -0500
Received: from fmr23.intel.com ([143.183.121.15]:51940 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751379AbWB0FL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 00:11:59 -0500
Subject: Re: [PATCH] Enable mprotect on huge pages
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       kenneth.w.chen@intel.com,
       "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>
In-Reply-To: <20060225085409.GA22456@infradead.org>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
	 <20060225085409.GA22456@infradead.org>
Content-Type: text/plain
Message-Id: <1141016998.1256.27.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 27 Feb 2006 13:09:58 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 16:54, Christoph Hellwig wrote:
> On Thu, Feb 23, 2006 at 11:19:40AM +0800, Zhang, Yanmin wrote:
> > From: Zhang, Yanmin <yanmin.zhang@intel.com>
> > 
> > 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn?t support hugetlb
> > mprotect. My patch against 2.6.16-rc3 enables this capability.
> 
> Adding another special case for hugetlb pages sounds rather bad.  Could
> you try adding a mrotect vm_area_operation if that works out cleaner?
I don't quite understand your idea. vm_operations_struct has no mprotect function
pointer. Could you elaborate it?
In current kernel, sys_mprotect would bypass hugetlb if (is_vm_hugetlb_page(vma)).


