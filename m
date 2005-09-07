Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVIGSWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVIGSWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVIGSWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:22:46 -0400
Received: from dvhart.com ([64.146.134.43]:3466 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932190AbVIGSWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:22:45 -0400
Date: Wed, 07 Sep 2005 11:22:42 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Dave Hansen <haveblue@us.ibm.com>, Magnus Damm <magnus@valinux.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       "A. P. Whitcroft [imap]" <andyw@uk.ibm.com>
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
Message-ID: <512850000.1126117362@flay>
In-Reply-To: <1126114116.7329.16.camel@localhost>
References: <20050906035531.31603.46449.sendpatchset@cherry.local> <1126114116.7329.16.camel@localhost>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, September 07, 2005 10:28:36 -0700 Dave Hansen <haveblue@us.ibm.com> wrote:

> On Tue, 2005-09-06 at 12:56 +0900, Magnus Damm wrote:
>> This patch for 2.6.13-git5 fixes single node sparsemem support. In the case
>> when multiple nodes are used, setup_memory() in arch/i386/mm/discontig.c calls
>> get_memcfg_numa() which calls memory_present(). The single node case with
>> setup_memory() in arch/i386/kernel/setup.c does not call memory_present()
>> without this patch, which breaks single node support.
> 
> First of all, this is really a feature addition, not a bug fix. :)
> 
> The reason we haven't included this so far is that we don't really have
> any machines that need sparsemem on i386 that aren't NUMA.  So, we
> disabled it for now, and probably need to decide first why we need it
> before a patch like that goes in.

CONFIG_NUMA was meant to (and did at one point) support both NUMA and flat
machines. This is essential in order for the distros to support it - same
will go for sparsemem.
 
M.
