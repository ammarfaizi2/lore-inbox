Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVIHBpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVIHBpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVIHBpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:45:39 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:8732 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932555AbVIHBpj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:45:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ONVfW6MFB/qeCokjOlbwZJP6X6RPTwIL0sL9Og7m+Giv4z7zdEY3U3mzARZzrMVNBkF5NKE3GgtoKmympwJcIDRnPPhZd5s2LmZGCk/L7cLqmupNc5fQ7bA0wE5fPGe56lk6hhxBzASCIgTZkIbIlf/VtU+vx2RmPjUJZtMTQ08=
Message-ID: <aec7e5c305090718455166714e@mail.gmail.com>
Date: Thu, 8 Sep 2005 10:45:37 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: magnus.damm@gmail.com
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
Cc: Dave Hansen <haveblue@us.ibm.com>, Magnus Damm <magnus@valinux.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       "A. P. Whitcroft [imap]" <andyw@uk.ibm.com>
In-Reply-To: <512850000.1126117362@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050906035531.31603.46449.sendpatchset@cherry.local>
	 <1126114116.7329.16.camel@localhost> <512850000.1126117362@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Martin J. Bligh <mbligh@mbligh.org> wrote:
> --On Wednesday, September 07, 2005 10:28:36 -0700 Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > On Tue, 2005-09-06 at 12:56 +0900, Magnus Damm wrote:
> >> This patch for 2.6.13-git5 fixes single node sparsemem support. In the case
> >> when multiple nodes are used, setup_memory() in arch/i386/mm/discontig.c calls
> >> get_memcfg_numa() which calls memory_present(). The single node case with
> >> setup_memory() in arch/i386/kernel/setup.c does not call memory_present()
> >> without this patch, which breaks single node support.
> >
> > First of all, this is really a feature addition, not a bug fix. :)
> >
> > The reason we haven't included this so far is that we don't really have
> > any machines that need sparsemem on i386 that aren't NUMA.  So, we
> > disabled it for now, and probably need to decide first why we need it
> > before a patch like that goes in.
> 
> CONFIG_NUMA was meant to (and did at one point) support both NUMA and flat
> machines. This is essential in order for the distros to support it - same
> will go for sparsemem.

Yes, by reading the code this becomes very clear. But what is the
current status? Is CONFIG_X86_GENERICARCH working right out of the box
on 2.6.13?

Thanks!

/ magnus
