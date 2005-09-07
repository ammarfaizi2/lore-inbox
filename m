Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVIGXuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVIGXuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 19:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVIGXuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 19:50:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751320AbVIGXt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 19:49:59 -0400
Date: Wed, 7 Sep 2005 16:49:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: haveblue@us.ibm.com, magnus@valinux.co.jp, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, andyw@uk.ibm.com
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
Message-Id: <20050907164945.14aba736.akpm@osdl.org>
In-Reply-To: <521510000.1126118091@flay>
References: <20050906035531.31603.46449.sendpatchset@cherry.local>
	<1126114116.7329.16.camel@localhost>
	<512850000.1126117362@flay>
	<1126117674.7329.27.camel@localhost>
	<521510000.1126118091@flay>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> 
> 
> --On Wednesday, September 07, 2005 11:27:54 -0700 Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > On Wed, 2005-09-07 at 11:22 -0700, Martin J. Bligh wrote:
> >> CONFIG_NUMA was meant to (and did at one point) support both NUMA and flat
> >> machines. This is essential in order for the distros to support it - same
> >> will go for sparsemem.
> > 
> > That's a different issue.  The current code works if you boot a NUMA=y
> > SPARSEMEM=y machine with a single node.  The current Kconfig options
> > also enforce that SPARSEMEM depends on NUMA on i386.
> > 
> > Magnus would like to enable SPARSEMEM=y while CONFIG_NUMA=n.  That
> > requires some Kconfig changes, as well as an extra memory present call.
> > I'm questioning why we need to do that when we could never do
> > DISCONTIG=y while NUMA=n on i386.
> 
> Ah, OK - makes more sense. However, some machines do have large holes
> in e820 map setups - is not really critical, more of an efficiency
> thing.

Confused.   Does all this mean that we want the patch, or not?
