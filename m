Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVLIW5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVLIW5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVLIW5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:57:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:28818 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964892AbVLIW5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:57:10 -0500
Date: Fri, 9 Dec 2005 23:57:00 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Rohit Seth <rohit.seth@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, zach@vmware.com, shai@scalex86.org,
       nippung@calsoftinc.com
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page boundary
Message-ID: <20051209225700.GN11190@wotan.suse.de>
References: <20051208215514.GE3776@localhost.localdomain> <1134083357.7131.21.camel@akash.sc.intel.com> <20051208231141.GX11190@wotan.suse.de> <1134084367.7131.32.camel@akash.sc.intel.com> <20051208232610.GY11190@wotan.suse.de> <1134085511.7131.53.camel@akash.sc.intel.com> <20051208234320.GB11190@wotan.suse.de> <20051209221922.GA3676@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209221922.GA3676@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just that any writes on the bp GDT will invalidate the idt_table cacheline,
> which is read mostly (as Nippun pointed out).  So could we keep the padding
> as it is for the BP too? 

Yes, good point.

> Attached is the patch which fixes the retval in do_boot_cpu to return -1.
> __cpu_up handles -1.
> 
> Hope this patch is OK.

Looks good.

Thanks,
-Andi
