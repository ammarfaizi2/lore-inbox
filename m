Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVIHRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVIHRpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVIHRpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:45:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12178 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964904AbVIHRpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:45:05 -0400
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, magnus@valinux.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       "A. P. Whitcroft [imap]" <andyw@uk.ibm.com>
In-Reply-To: <20050907164945.14aba736.akpm@osdl.org>
References: <20050906035531.31603.46449.sendpatchset@cherry.local>
	 <1126114116.7329.16.camel@localhost> <512850000.1126117362@flay>
	 <1126117674.7329.27.camel@localhost> <521510000.1126118091@flay>
	 <20050907164945.14aba736.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 17:46:34 -0700
Message-Id: <1126140395.6354.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 16:49 -0700, Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> > Ah, OK - makes more sense. However, some machines do have large holes
> > in e820 map setups - is not really critical, more of an efficiency
> > thing.
> 
> Confused.   Does all this mean that we want the patch, or not?

I say we wait on it.

Martin brings up a scenario in which SPARSEMEM is useful without NUMA,
but it Magnus's patch doesn't actually deal with systems like that.
Let's do it right, and base the memory_present() calls off of real data
from the e820 or efi data.

-- Dave

