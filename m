Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVLHTwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVLHTwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVLHTwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:52:51 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:54676 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750907AbVLHTwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:52:51 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andy Whitcroft <andyw@uk.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, dwg@au1.ibm.com,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1134071266.9305.4.camel@localhost>
References: <1133995060.21841.56.camel@localhost.localdomain>
	 <43976AA4.2060606@uk.ibm.com>
	 <1133997772.21841.62.camel@localhost.localdomain>
	 <1134002888.30387.82.camel@localhost>
	 <1134058055.21841.70.camel@localhost.localdomain>
	 <1134069335.6159.21.camel@localhost>
	 <Pine.LNX.4.61.0512081930340.11944@goblin.wat.veritas.com>
	 <1134071266.9305.4.camel@localhost>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 11:53:07 -0800
Message-Id: <1134071587.21841.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 11:47 -0800, Dave Hansen wrote:
> On Thu, 2005-12-08 at 19:33 +0000, Hugh Dickins wrote:
> > Oh, it isn't worth that effort, just test is_vm_hugetlb_page(vma)
> > in show_smap, and skip it if so - or make up appropriate numbers
> > from (vm_end - vm_start) in that case if you like.
> 
> I think the reason Badari was looking at it was that some DB guys want
> to get some statistics out of there.  They'll certainly care about
> HugeTLB pages.
> 
> With the HugeTLB prefault mechanism having gone away, we can't assume
> that the pages are resident.  So, I don't think just using the VMA's
> size will work.

Yep. You replied before I can :)

Thanks,
Badari

