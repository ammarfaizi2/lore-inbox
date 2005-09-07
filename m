Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVIGR3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVIGR3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVIGR3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:29:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29868 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751167AbVIGR3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:29:12 -0400
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
From: Dave Hansen <haveblue@us.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       "A. P. Whitcroft [imap]" <andyw@uk.ibm.com>
In-Reply-To: <20050906035531.31603.46449.sendpatchset@cherry.local>
References: <20050906035531.31603.46449.sendpatchset@cherry.local>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 10:28:36 -0700
Message-Id: <1126114116.7329.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 12:56 +0900, Magnus Damm wrote:
> This patch for 2.6.13-git5 fixes single node sparsemem support. In the case
> when multiple nodes are used, setup_memory() in arch/i386/mm/discontig.c calls
> get_memcfg_numa() which calls memory_present(). The single node case with
> setup_memory() in arch/i386/kernel/setup.c does not call memory_present()
> without this patch, which breaks single node support.

First of all, this is really a feature addition, not a bug fix. :)

The reason we haven't included this so far is that we don't really have
any machines that need sparsemem on i386 that aren't NUMA.  So, we
disabled it for now, and probably need to decide first why we need it
before a patch like that goes in.

I actually have exactly the same patch that you sent out in my tree, but
it's just for testing.  Magnus, perhaps we can get some of my testing
patches in good enough shape to put them in -mm so that the non-NUMA
folks can do more sparsemem testing.  

-- Dave

